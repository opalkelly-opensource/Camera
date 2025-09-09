//------------------------------------------------------------------------
// test_okhi_tf.v
//
// This test fixture exercises the Opal Kelly RAMTester application of 
// the MIG DDR2 core.  Unlike the _oktb version, this includes the full
// FrontPanel simulation component.
//
//------------------------------------------------------------------------
// Copyright (c) 2009 Opal Kelly Incorporated
// $Rev$ $Date$
//------------------------------------------------------------------------

`default_nettype none
`timescale 1ns / 1ps

module tf;
// ========================================================================== //
// Parameters                                                                 //
// ========================================================================== //
parameter SIMULATION      = "TRUE";
parameter ROWS            = 12; // 12  243
parameter COLUMNS         = 14; // 14  324

// ========================================================================== //
// Signal Declarations                                                        //
// ========================================================================== //

//FrontPanel Host
wire [4:0]   okUH;
wire [2:0]   okHU;
wire [31:0]  okUHU;
wire         okAA;
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

//Testbench
reg    sys_clk;
reg    sensor_sim_reset_b;

//Image Sensor I/O
wire        pix_sdata;
wire        pix_sclk;
wire        pix_trigger;
wire        pix_reset;

wire        pix_extclk;
wire        pix_strobe;
wire        pix_clk;
wire        pix_lv;
wire        pix_fv;
wire [11:0] pix_data;

//LEDs
wire [3:0]  led;

//Clocks
wire        sys_clkp;  // 100 MHz
wire        sys_clkn;  // 100 MHz

// DDR3
wire [15:0] ddr3_dq;
wire [14:0] ddr3_addr;
wire [2:0]  ddr3_ba;
wire [0:0]  ddr3_ck_p;
wire [0:0]  ddr3_ck_n;
wire [0:0]  ddr3_cke;
wire [0:0]  ddr3_cs_n;
wire        ddr3_cas_n;
wire        ddr3_ras_n;
wire        ddr3_we_n;
wire [0:0]  ddr3_odt;
wire [1:0]  ddr3_dm;
wire [1:0]  ddr3_dqs_p;
wire [1:0]  ddr3_dqs_n;
wire        ddr3_reset_n;

// The PULLDOWN component is connected to the ZIO signal primarily to avoid the
// unknown state in simulation. In real hardware, ZIO should be a no connect(NC) pin.
//PULLDOWN zio_pulldown3 (.O(ddr3_zio));
//PULLDOWN rzq_pulldown3 (.O(ddr3_rzq));

//OK Host Simulation
// Registers
reg [31:0] u32Address  [0:(registerSetSize-1)];
reg [31:0] u32Data     [0:(registerSetSize-1)];
reg [31:0] u32Count;

//------------------------------------------------------------------------
// DDR3 Memory Model
//------------------------------------------------------------------------
ddr3_model u_comp_ddr3 (
	.rst_n   (ddr3_reset_n),
	.ck      (ddr3_ck_p),
	.ck_n    (ddr3_ck_n),
	.cke     (ddr3_cke),
	.cs_n    (ddr3_cs_n),
	.ras_n   (ddr3_ras_n),
	.cas_n   (ddr3_cas_n),
	.we_n    (ddr3_we_n),
	.dm_tdqs (ddr3_dm),
	.ba      (ddr3_ba),
	.addr    (ddr3_addr),
	.dq      (ddr3_dq),
	.dqs     (ddr3_dqs_p),
	.dqs_n   (ddr3_dqs_n),
	.tdqs_n  (),
	.odt     (ddr3_odt)
);
 

//------------------------------------------------------------------------
// Image Sensor Model
//------------------------------------------------------------------------
sensor_sim #(
	.COLUMNS(COLUMNS),
	.ROWS(ROWS)
) snsr_sm0 (
	.reset_b(pix_reset & sensor_sim_reset_b),
	.extclk(pix_extclk),

	.frame_valid(pix_fv),
	.line_valid(pix_lv),
	
	.pixclk(pix_clk),
	.dout(pix_data)
	);

//------------------------------------------------------------------------
// EVB1005 DUT
//------------------------------------------------------------------------
evb1006 #(
	.SIMULATION(SIMULATION)
)
dut(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.led(led),
	
	.sys_clkp(sys_clkp), 
	.sys_clkn(sys_clkn), 
	
	.pix_sdata(pix_sdata),
	.pix_sclk(pix_sclk),  
	.pix_trigger(pix_trigger),
	.pix_reset(pix_reset),

	.pix_extclk(pix_extclk),
	.pix_strobe(pix_strobe),

	.pix_clk(pix_clk),
	.pix_lv(pix_lv),
	.pix_fv(pix_fv),
	.pix_data(pix_data),

	.ddr3_dq(ddr3_dq),
	.ddr3_addr(ddr3_addr),
	.ddr3_ba(ddr3_ba),
	.ddr3_ck_p(ddr3_ck_p),
	.ddr3_ck_n(ddr3_ck_n),
	.ddr3_cke(ddr3_cke),
	.ddr3_cs_n(ddr3_cs_n),
	.ddr3_cas_n(ddr3_cas_n),
	.ddr3_ras_n(ddr3_ras_n),
	.ddr3_we_n(ddr3_we_n),
	.ddr3_odt(ddr3_odt),
	.ddr3_dm(ddr3_dm),
	.ddr3_dqs_p(ddr3_dqs_p),
	.ddr3_dqs_n(ddr3_dqs_n),
	.ddr3_reset_n(ddr3_reset_n)
);


//------------------------------------------------------------------------
// Begin okHost simulation user configurable global data
//------------------------------------------------------------------------
parameter BlockDelayStates = 5;   // REQUIRED: # of clocks between blocks of pipe data
parameter ReadyCheckDelay = 5;    // REQUIRED: # of clocks before block transfer before
								  //           host interface checks for ready (0-255)
parameter PostReadyDelay = 5;     // REQUIRED: # of clocks after ready is asserted and
								  //           check that the block transfer begins (0-255)
parameter pipeInSize = 	2 * 1024;      // REQUIRED: byte (must be even) length of default
								  //           PipeIn; Integer 0-2^32
parameter pipeOutSize = 512;     // REQUIRED: byte (must be even) length of default
								  //           PipeOut; Integer 0-2^32
parameter registerSetSize = 32;  // Size of array for register set commands.
//------------------------------------------------------------------------

integer e;
reg	[7:0]	pipeIn  [0:(pipeInSize-1)];
reg	[7:0]	pipeOut [0:(pipeOutSize-1)];
reg	[7:0]	pipetmp [0:(pipeOutSize-1)];   // Data Check Array
reg [11:0]  img_array [COLUMNS-1:0][ROWS-1:0];
reg [31:0]  data_wire;

// Initialize image data (stolen from sensor_sim.v)
integer i,j,k;
initial begin
    k = 0;
	//$readmemb(image_file, image);
	for (i=0; i<ROWS; i=i+1) begin
		for (j=0; j<COLUMNS; j=j+1) begin
			img_array[j][i] = (i * COLUMNS) + j;
			
			pipetmp[k] = img_array[j][i] >> 8;
			k = k + 1;
			pipetmp[k] = img_array[j][i] & 8'hFF;
			k = k + 1;
		end
	end
end

// Clock Generation
parameter tCLK = 5.0;
parameter tREFCLK = 5.0;

initial sys_clk = 0;
always #(tCLK/2.0) sys_clk = ~sys_clk;

//initial dut.clkinst0.clk_ref_in = 0;
//always #(tREFCLK/2.0) dut.clkinst0.clk_ref_in = ~dut.clkinst0.clk_ref_in;

assign sys_clkp = sys_clk;
assign sys_clkn = ~sys_clk;

// Reset
initial begin
	sensor_sim_reset_b = 1'b0;
	data_wire = 1'b0;
end

// FrontPanel API Task Calls.
initial begin
	
	FrontPanelReset;
	$display("//// Begin Single Capture at:                           %dns   /////", $time);
	
	// Assert then deassert RESET_FIFO
	SetWireInValue(8'h00, 32'h0000002f, 32'h0000002f); // Ping Pong Mode enabled, 16bit packing
	UpdateWireIns;
	SetWireInValue(8'h00, 32'h00000000, 32'h00000007); // Release clock resets
	UpdateWireIns;
	#1000
	$display("//// System resets complete at:          %dns   /////", $time);
	
	// Set Readout count
	// This is based on the default sensor simulation size of 12x14 (with
	// 2-bytes per pixel, rounded up to a multiple of 256 (to match software)
	SetWireInValue(8'h02, 32'h200, 32'h0000ffff); // Set readout count
	SetWireInValue(8'h03, 32'h0, 32'h0000ffff); // Set readout count
	UpdateWireIns;

	wait (dut.memif_calib_done == 1'b1);
	$display("//// DDR2 PHY initialization complete at:          %dns   /////", $time);
	
	SetWireInValue(8'h00, 32'h00000000, 32'h0000000f); // Release async resets
	UpdateWireIns;
	
	#100
	sensor_sim_reset_b = 1'b1;
	$display("//// Release Sensor Simulation Reset at:          %dns   /////", $time);

	// Clear PipeOut
	for (k=0; k<pipeOutSize; k=k+1) pipeOut[k] = 8'h00;
		
	// Read 1 512 byte block (contains a single frame)
	for (k=0; k<1; k=k+1) begin
		// Wait for a wire indicating that image data is available
		data_wire=0;
		while (data_wire==0) begin
			UpdateWireOuts;
			data_wire = GetWireOutValue(8'h23) & 9'h100;
		end
		$display("Frame Available in DDR #%d at:           %dns", k, $time);
		
		// Begin Host Readout
		ActivateTriggerIn(8'h40, 0);
		$display("Image Data Readout #%d at:           %dns", k, $time);
		
		#1000
	
		// Read the block out
		ReadFromPipeOut(8'ha0, pipeOutSize);
		$display("//// Read From DDR2 complete at:                   %dns   /////", $time);
		
		// End Host Readout
		ActivateTriggerIn(8'h40, 1);
	end
	
	
	// Test read-back data. Only test the data related to the image.
	e=0;
	for (k=0; k<2 * (ROWS*COLUMNS-1); k=k+1) begin 
		if (pipeOut[k] !== pipetmp[k]) begin
			e=e+1;	// Keep track of the number of errors
			$display(" ");
			$display("Error! Data mismatch at byte %d:  Expected: 0x%08x Read: 0x%08x", k, pipetmp[k], pipeOut[k]);
		end
	end
	
	if (e == 0) begin
		$display(" ");
		$display("Success! All data passes readback.");
	end


    $display("Simulation done at: %dns", $time);
    $finish;

end

// Do not remove!
`include "./oksim/okHostCalls.v"

endmodule
