//------------------------------------------------------------------------
// xem6010.v - Top-level EVB1005 camera HDL
//
// Clocks:
//    CLK_SYS    - 100 MHz single-ended input clock
//    CLK_TI     - 48 MHz host-interface clock provided by okHost
//    CLK0       - Memory interface clock provided by MEM_IF
//    CLK_PIX    - 96 MHz single-ended input clock from image sensor
//
//
// Host Interface registers:
// WireIn 0x00
//     0 - System PLL RESET (active high)
//     1 - Image sensor RESET (active high)
//     2 - Pixel DCM RESET (active high)
//     3 - Logic RESET (active high)
//     4 - Image capture mode (0=trigger, 1=ping-pong)
//     5 - Image packing mode (0=8-bit, 1=16-bit)
// WireIn 0x01
//   7:0 - I2C input data
// WireIn 03:02 - readout_count[23:0]
// WireIn 05:04 - readout_addr[29:0]
//
// WireOut 0x20
//  10:0 - Image buffer read count
// WireOut 0x21
//     0 - Reset complete
// WireOut 0x22
//  15:0 - I2C data output
// WireOut 0x23
//   7:0 - Skipped frame count
//
// TriggerIn 0x40
//     0 - Image capture
//     1 - Readout start
//     2 - Readout complete (buffer A)
//     3 - Readout complete (buffer B)
// TriggerIn 0x42
//     0 - I2C start
//     1 - I2C memory start
//     2 - I2C memory write
//     3 - I2C memory read
// TriggerOut 0x60  (pix_clk)
//     0 - Frame available
// TriggerOut 0x61  (i2c_clk)
//     0 - I2C done
//
// PipeOut 0xA0 - Image readout port
//
// This sample is included for reference only.  No guarantees, either 
// expressed or implied, are to be drawn.
//------------------------------------------------------------------------
// tabstop 3
// Copyright (c) 2005-2009 Opal Kelly Incorporated
// $Rev: 154 $ $Date: 2012-01-03 14:29:48 -0600 (Tue, 03 Jan 2012) $
//------------------------------------------------------------------------
`timescale 1ns/1ps
// Don't use this because the Xilinx MIG generates code that doesn't declare
// net types on module inputs, so it's not compliant.
//`default_nettype none

module evb1005 (
	input  wire [7:0]  hi_in,
	output wire [1:0]  hi_out,
	inout  wire [15:0] hi_inout,

	output wire        i2c_sda,
	output wire        i2c_scl,
	output wire        hi_muxsel,
	
	output wire [7:0]  led,
	
	//Clocks
	input  wire        sys_clk, // CY22393 CLKA @ 100MHz  
	
	//EVB1005
	inout  wire        pix_sdata,
	output wire        pix_sclk,
	output wire        pix_trigger,
	output wire        pix_reset,

	output wire        pix_extclk,
	input  wire        pix_strobe,
	input  wire        pix_clk,
	input  wire        pix_lv,
	input  wire        pix_fv,
	input  wire [11:0] pix_data,
	
	//SDRAM Memory
	output wire        sdram_cke,
	output wire        sdram_cs_n,
	output wire        sdram_we_n,
	output wire        sdram_cas_n,
	output wire        sdram_ras_n,
	output wire        sdram_ldqm,
	output wire        sdram_udqm,
	output wire [1:0]  sdram_ba,
	output wire [12:0] sdram_a,
	inout  wire [15:0] sdram_d
	);


// USB Host Interface
wire        clk_ti;
wire [30:0] ok1;
wire [16:0] ok2;

// SDRAM harnessing
wire         sdram_clk;
wire         memif_async_rst;
wire         dcm_locked;


// SDRAM controller / negotiator connections
wire         p0_wr_en;
wire [63:0]  p0_wr_data;
wire         p0_cmd_wr;
wire [29:0]  p0_cmd_byte_addr;


wire         p1_rd_clk;
wire         p1_rd_en;
wire [15:0]  p1_rd_data;
wire         p1_rd_empty;
wire         p1_cmd_rd;
wire [29:0]  p1_cmd_byte_addr;

//OK
wire [15:0] ep00wire, ep02wire, ep03wire, ep04wire, ep05wire;
wire [15:0] ti40_pix, ti40_mig, ti42_clkti;
wire [15:0] to60_pix, to61_clkti;
wire        pipe_out_ep_read;
wire [15:0] pipe_out_datain;
wire [10:0] pipe_out_rd_count;
wire        imgctl_packing_mode;
wire        frame_done_t;
wire        clk_pix;
wire        i2c_sdat_out;
wire        i2c_drive;
wire        pix_extclk_o;


assign i2c_sda        = 1'bz;
assign i2c_scl        = 1'bz;
assign hi_muxsel      = 1'b0;
assign pix_trigger    = 1'b0;
assign led = ~{skipped_count[3:0], buffer_full[1:0], 1'b0, dcm_locked};
assign pix_sdata = (i2c_drive) ? (i2c_sdat_out) : (1'bz);
ODDR2 i_pixext (.Q   (pix_extclk),
                .C0  (pix_extclk_o),
                .C1  (~pix_extclk_o),
                .D0  (1'b1),
                .D1  (1'b0),
                .CE  (dcm_locked),
                .R   (~dcm_locked),
                .S   (1'b0));


// Reset Chain
wire reset_syspll;
wire reset_pixdcm;
wire reset_async;
wire reset_clkpix;
wire reset_clkti;
wire reset_clk0;

assign reset_syspll        =  ep00wire[0];
assign pix_reset           = ~ep00wire[1];
assign reset_pixdcm        =  ep00wire[2];
assign reset_async         =  ep00wire[3];
assign imgctl_packing_mode =  ep00wire[5];


// Create RESETs that deassert synchronous to specific clocks
sync_reset sync_reset0 (.clk(clk_pix),   .async_reset(reset_async),  .sync_reset(reset_clkpix));
sync_reset sync_reset1 (.clk(sdram_clk), .async_reset(reset_async),  .sync_reset(reset_clk0));
sync_reset sync_reset2 (.clk(clk_ti),    .async_reset(reset_async),  .sync_reset(reset_clkti));


// Coordinator
// * Manual mode - Start image capture from host.
// * Ping-Pong mode - Automatic double-buffered continual capture
wire         pingpong = ep00wire[4];
wire         imgctl_framedone;
wire         imgctl_skipped;
reg  [7:0]   skipped_count;
reg  [1:0]   buffer_done;
reg  [1:0]   buffer_full;
reg          buffer_active;
reg          ping_trig;
reg  [29:0]  ping_addr;
integer stateA;
localparam a_idle             = 0,
           a_bufA_wait        = 1,
           a_bufA_capture     = 2,
           a_bufB_wait        = 3,
           a_bufB_capture     = 4;
always @(posedge clk_pix or posedge reset_clkpix) begin
	if (reset_clkpix) begin
		stateA        <= a_idle;
		buffer_full   <= 2'b00;
		buffer_done   <= 2'b00;
		ping_trig     <= 1'b0;
		skipped_count <= 8'h00;
	end else begin
		ping_trig <= 1'b0;
		buffer_done <= 2'b00;
		
		if (imgctl_skipped) begin
			skipped_count <= skipped_count + 1'b1;
		end
		
		if (ti40_pix[2] == 1'b1)
			buffer_full[0] <= 1'b0;
		if (ti40_pix[3] == 1'b1)
			buffer_full[1] <= 1'b0;
		
		case (stateA)
			a_idle: begin
				stateA <= a_bufA_wait;
			end
			
			a_bufA_wait: begin
				if (buffer_full[0] == 1'b0) begin
					stateA <= a_bufA_capture;
					ping_trig <= 1'b1;
					ping_addr <= 30'h00000000;
				end
			end
			
			a_bufA_capture: begin
				if (imgctl_framedone == 1'b1) begin
					stateA <= a_bufB_wait;
					buffer_full[0] <= 1'b1;
					buffer_done[0] <= 1'b1;
				end
			end

			a_bufB_wait: begin
				if (buffer_full[1] == 1'b0) begin
					stateA <= a_bufB_capture;
					ping_trig <= 1'b1;
					ping_addr <= 30'h00800000;
				end
			end

			a_bufB_capture: begin
				if (imgctl_framedone == 1'b1) begin
					stateA <= a_bufA_wait;
					buffer_full[1] <= 1'b1;
					buffer_done[1] <= 1'b1;
				end
			end
		endcase
	end
end



// Image Sensor Interface
assign to60_pix[0] = imgctl_framedone;
assign to60_pix[1] = | buffer_done;
assign to60_pix[2] = buffer_done[0];
assign to60_pix[3] = buffer_done[1];
assign to60_pix[15:4] = 0;
image_if imgif0(
		.clk                 (clk_pix),
		.reset               (reset_clkpix),
		.packing_mode        (imgctl_packing_mode),
	
		.pix_fv              (pix_fv),
		.pix_lv              (pix_lv),
		.pix_data            (pix_data),
		
		.trigger             (pingpong ? ping_trig : ti40_pix[0]),
		.start_addr          (pingpong ? ping_addr : 30'h0),
		.frame_done          (imgctl_framedone),
		.skipped             (imgctl_skipped),
		
		.mem_wr_en           (p0_wr_en),
		.mem_wr_data         (p0_wr_data),
		.mem_cmd_wr          (p0_cmd_wr),
		.mem_cmd_byte_addr   (p0_cmd_byte_addr)
		//.mem_wr_full         (p0_wr_full),
	);



host_if hstif0(
		.clk                (sdram_clk),
		.clk_ti             (clk_ti),
		.reset_clk          (reset_clk0),
		.readout_start      (ti40_mig[1]),
		.readout_done       (ti40_mig[2] | ti40_mig[3]),
		.readout_addr       ({ep05wire[13:0], ep04wire[15:0]}),
		.readout_count      ({ep03wire[7:0], ep02wire[15:0]}),
		
		.c0_fifo_write      (c0_fifo_write),
		.c0_fifo_dout       (c0_fifo_dout),
		
		.mem_cmd_rd         (p1_cmd_rd),
		.mem_cmd_byte_addr  (p1_cmd_byte_addr),
	
		.ob_rd_en           (pipe_out_ep_read),
		.pofifo0_rd_count   (pipe_out_rd_count),  
		.pofifo0_dout       (pipe_out_datain),
		.pofifo0_full       (),
		.pofifo0_empty      ()
	);



wire [15:0] memdin;
wire [7:0]  memdout;
i2cController i2c_ctrl0 (
		.clk          (clk_ti),
		.reset        (reset_clkti),
		.start        (ti42_clkti[0]),
		.done         (to61_clkti[0]),
		.divclk       (8'd47),
		.memclk       (clk_ti),
		.memstart     (ti42_clkti[1]),
		.memwrite     (ti42_clkti[2]),
		.memread      (ti42_clkti[3]),
		.memdin       (memdin[7:0]),
		.memdout      (memdout[7:0]),
		.i2c_sclk     (pix_sclk),
		.i2c_sdat_in  (pix_sdata),
		.i2c_sdat_out (i2c_sdat_out),
		.i2c_drive    (i2c_drive)
	);



mem_if memif0 (
		.async_rst           (memif_async_rst),
		.sdram_clk           (sdram_clk),
		
		.cmd_pageread        (cmd_pageread),
		.cmd_pagewrite       (cmd_pagewrite),
		.cmd_ack             (cmd_ack),
		.cmd_done            (cmd_done),
		.rowaddr             (rowaddr),
		
		.p0_wr_clk           (clk_pix),
		.p0_wr_en            (p0_wr_en),
		.p0_wr_data          (p0_wr_data),
		.p0_wr_full          (p0_wr_full),
		
		.c0_fifo_write       (c0_fifo_write),
		.c0_fifo_dout        (c0_fifo_dout),
		
		.sdram_cke           (sdram_cke),
		.sdram_cs_n          (sdram_cs_n),
		.sdram_we_n          (sdram_we_n),
		.sdram_cas_n         (sdram_cas_n),
		.sdram_ras_n         (sdram_ras_n),
		.sdram_ldqm          (sdram_ldqm),
		.sdram_udqm          (sdram_udqm),
		.sdram_ba            (sdram_ba),
		.sdram_a             (sdram_a),
		.sdram_d             (sdram_d)
	);



// Phase shift is performed in order to accommodate the setup/hold
// requirements:
// + We capture PIX_DATA, FV, and LV on the falling edge of PIX_CLK.
// + FV/LV may arrive as late as 1.0ns before the falling edge.
// + The setup time for Spartan-6 is approximately 1.8ns.
// + No phase shift is required when the DCM runs in SOURCE_SYNCHRONOUS
//   mode, but some positive shift may be added to improve margin.
clocks # (
		.C_CLKIN_PERIOD          (10.000),     // System clock is 100 MHz
		.C_CLKFX_DIVIDE          (3),          // Divide to 33.333 MHz
		.C_CLKFX_MULTIPLY        (4),          // SDRAM frequency is 133.33 MHz
		.C_CLKPIXEXT_DIVIDE      (5),          // Image sensor EXTCLK output is 20 MHz
		.C_PHASE_SHIFT           (-100),       // Determined experimentatlly for SDRAM
		.PIXGEN_PHASE_SHIFT      (0)           // Phase shift for PIX_CLK generation
	) clkinst0 (
		.sys_clk        (sys_clk),
		.sys_rst_n      (reset_syspll),
		.sdram_clk      (sdram_clk),
		.dcm_locked     (dcm_locked),
		.mcb_drp_clk    (memif_mcb_drp_clk),

		.pix_extclk     (pix_extclk_o),
		.pix_clk        (pix_clk),
		.reset_pixdcm   (reset_pixdcm),
		.clk_pix        (clk_pix)
	);

// Instantiate the okHost and connect endpoints.
okHost host (
		.hi_in     (hi_in),
		.hi_out    (hi_out),
		.hi_inout  (hi_inout),
		.hi_aa     (hi_aa),
		.ti_clk    (clk_ti),
		.ok1       (ok1), 
		.ok2       (ok2)
	);

wire [17*7-1:0]  ok2x;
okWireOR # (.N(7)) wireOR (.ok2(ok2), .ok2s(ok2x));

okWireIn     wi00  (.ok1(ok1),                           .ep_addr(8'h00), .ep_dataout(ep00wire));
okWireIn     wi01  (.ok1(ok1),                           .ep_addr(8'h01), .ep_dataout(memdin));
okWireIn     wi02  (.ok1(ok1),                           .ep_addr(8'h02), .ep_dataout(ep02wire));
okWireIn     wi03  (.ok1(ok1),                           .ep_addr(8'h03), .ep_dataout(ep03wire));
okWireIn     wi04  (.ok1(ok1),                           .ep_addr(8'h04), .ep_dataout(ep04wire));
okWireIn     wi05  (.ok1(ok1),                           .ep_addr(8'h05), .ep_dataout(ep05wire));

okTriggerIn  ti40a (.ok1(ok1),                           .ep_addr(8'h40), .ep_clk(clk_pix),  .ep_trigger(ti40_pix));
okTriggerIn  ti40b (.ok1(ok1),                           .ep_addr(8'h40), .ep_clk(sdram_clk),     .ep_trigger(ti40_mig));
okTriggerIn  ti42  (.ok1(ok1),                           .ep_addr(8'h42), .ep_clk(clk_ti),   .ep_trigger(ti42_clkti));

okTriggerOut to60  (.ok1(ok1), .ok2(ok2x[ 0*17 +: 17 ]), .ep_addr(8'h60), .ep_clk(clk_pix),  .ep_trigger(to60_pix));
okTriggerOut to61  (.ok1(ok1), .ok2(ok2x[ 1*17 +: 17 ]), .ep_addr(8'h61), .ep_clk(clk_ti),   .ep_trigger(to61_clkti));

okPipeOut    po0   (.ok1(ok1), .ok2(ok2x[ 2*17 +: 17 ]), .ep_addr(8'ha0), .ep_read(pipe_out_ep_read),   .ep_datain(pipe_out_datain));

okWireOut    wo20  (.ok1(ok1), .ok2(ok2x[ 3*17 +: 17 ]), .ep_addr(8'h20), .ep_datain({5'b0, pipe_out_rd_count}));
okWireOut    wo21  (.ok1(ok1), .ok2(ok2x[ 4*17 +: 17 ]), .ep_addr(8'h21), .ep_datain(16'b0));
okWireOut    wo22  (.ok1(ok1), .ok2(ok2x[ 5*17 +: 17 ]), .ep_addr(8'h22), .ep_datain({8'b0, memdout}));
okWireOut    wo23  (.ok1(ok1), .ok2(ok2x[ 6*17 +: 17 ]), .ep_addr(8'h23), .ep_datain({6'b0, buffer_full[1:0], skipped_count[7:0]}));

endmodule
 

module i2cController (clk, reset, start, done, divclk, memclk, memstart, memwrite, memread, memdin, memdout, i2c_sclk, i2c_sdat_in, i2c_sdat_out, i2c_drive);
	input        clk;
	input        reset;
	input        start;
	output       done;
	input  [7:0] divclk;
	
	input        memclk;
	input        memstart;
	input        memwrite;
	input        memread;
	input  [7:0] memdin;
	output [7:0] memdout;
	
	output       i2c_sclk;
	input        i2c_sdat_in;
	output       i2c_sdat_out;
	output       i2c_drive;
// synthesis attribute box_type i2cController "black_box"
endmodule
