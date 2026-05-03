//------------------------------------------------------------------------
// mem_if.v
//
// Memory interface for the XEM3010.
//
// This sample is included for reference only.  No guarantees, either 
// expressed or implied, are to be drawn.
//------------------------------------------------------------------------
// tabstop 3
// Copyright (c) 2005-2009 Opal Kelly Incorporated
// $Rev: 145 $ $Date: 2011-12-12 11:02:12 -0600 (Mon, 12 Dec 2011) $
//------------------------------------------------------------------------
`timescale 1ns/1ps

module mem_if (
	// Clocks
	input  wire                                async_rst,
	input  wire                                sdram_clk,
	
	// Command Interface
	input  wire                                sdram_wren,
	input  wire                                sdram_rden,
	
	output wire                                cmd_wack, //Needed?
	output wire                                cmd_rack, //Needed?
	
	output wire                                cmd_done,
	input  wire                                frame_done,
	
	input  wire [29:0]                         image_if_start_addr, //Are these the right size?
	input  wire [29:0]                         host_if_start_addr,
	
	// Data Interfaces
	input  wire                                p0_wr_clk,
	input  wire                                p0_wr_en,
	input  wire [63:0]                         p0_wr_data,
  output wire                                p0_wr_full,
  
  /*
	input  wire                                p1_rd_clk,
	input  wire                                p1_rd_en,
	output wire [16:0]                         p1_rd_data,
	output wire                                p1_rd_empty,
	*/
	output  wire          c0_fifo_write,
	putput  wire [15:0]   c0_fifo_dout,
	
	// SDRAM
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

wire        c0_fifo_read;//, c0_fifo_write;
wire [15:0] p0_dout;//, c0_fifo_dout; 

assign sdram_cke = 1'b1;
assign sdram_ldqm = 1'b0;
assign sdram_udqm = 1'b0;

//------------------------------------------------------------------------
// SDRAM transfer negotiator
//   This block handles communication between the SDRAM controller and
//   the FIFOs.  The FIFOs act as a simplified cache, holding at least
//   a full page on-chip while the PC reads the FIFO.  This dramatically
//   increases DRAM access performance since full pages can be read very
//   quickly.  Since the PC transfers are slower than the DRAM, there is
//   no fear of underrun.
//------------------------------------------------------------------------
parameter n_idle = 0,
          n_wackwait = 1,
          n_rackwait = 2,
			 n_busy = 3;
integer staten;
always @(negedge sdram_clk) begin
	if (reset == 1'b1) begin
		staten <= n_idle;
		cmd_pagewrite <= 1'b0;
		cmd_pageread <= 1'b0;
		rowaddr <= 15'h0000;
	end else begin
		cmd_pagewrite <= 1'b0;
		cmd_pageread <= 1'b0;

		case (staten)
			n_idle: begin
				staten <= n_idle;

				// If SDRAM WRITEs are enabled, trigger a block write whenever
				// the Pipe In buffer is at least 1/4 full (1 page, 512 words).
				if ((sdram_wren == 1'b1) && (ep80fifo_status[10:7] >= 4'b0100)) begin
					staten <= n_wackwait;
				end

				// If SDRAM READs are enabled, trigger a block read whenever
				// the Pipe Out buffer has room for at least 1 page (512 words).
				else if ((sdram_rden == 1'b1) && (epA0fifo_status[10:7] <= 4'b1000)) begin
					staten <= n_rackwait;
				end
			end


			n_wackwait: begin
				cmd_pagewrite <= 1'b1;
				staten <= n_wackwait;
				if (cmd_ack == 1'b1) begin
					rowaddr <= rowaddr + 1;
					staten <= n_busy;
				end
			end
			

			n_rackwait: begin
				cmd_pageread <= 1'b1;
				staten <= n_rackwait;
				if (cmd_ack == 1'b1) begin
					rowaddr <= rowaddr + 1;
					staten <= n_busy;
				end
			end
			

			n_busy: begin
				staten <= n_busy;
				if (cmd_done == 1'b1) begin
					staten <= n_idle;
				end
			end

		endcase
	end
end

sdramctrl c0 (
		.clk(~sdram_clk),
		.clk_read(~sdram_clk),
		.reset(async_rst),
		.cmd_pagewrite(cmd_pagewrite),
		.cmd_pageread(cmd_pageread),
		.cmd_ack(cmd_ack),
		.cmd_done(cmd_done),
		.rowaddr_in(rowaddr),
		.fifo_din(p0_dout),
		.fifo_read(c0_fifo_read),
		.fifo_dout(c0_fifo_dout),
		.fifo_write(c0_fifo_write),
		.sdram_cmd({sdram_cs_n, sdram_ras_n, sdram_cas_n, sdram_we_n}),
		.sdram_ba(sdram_ba),
		.sdram_a(sdram_a),
		.sdram_d(sdram_d));

// Write FIFO (p0) 64->16bit for compatibility with PACKING_MODE=0
fifo_w64_512_r16_2048 p0 (
		.rst(async_rst), 
		.empty(), 
		.full(p0_wr_full),
		
		.wr_clk(p0_wr_clk), 
		.wr_en(p0_wr_en),
		.wr_data_count(), 
		.din(p0_wr_data),
		
		.rd_clk(~sdram_clk), 
		.rd_en(c0_fifo_read),
		.rd_data_count(), 
		.dout(p0_dout));

/*
// Read FIFO (p1) 16->16bit
fifo16w16r_2048 p1 (
		.rst(async_rst), 
		.empty(p1_rd_empty), 
		.full(),
		
		.wr_clk(~sdram_clk), 
		.wr_en(c0_fifo_write),
		.wr_data_count(), 
		.din(c0_fifo_dout),
		
		.rd_clk(p1_rd_clk), 
		.rd_en(p1_rd_en), 
		.rd_data_count(),
		.dout(p1_rd_data));
*/

endmodule
