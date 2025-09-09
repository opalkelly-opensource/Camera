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
	wire [1:0]  led;

	// DDR3
	wire [15:0] mem_dq;
	wire [12:0] mem_addr;
	wire [2:0]  mem_ba;
	wire [0:0]  mem_clk;
	wire [0:0]  mem_clk_n;
	wire [0:0]  mem_cke;
	wire [0:0]  mem_cs_n;
	wire        mem_cas_n;
	wire        mem_ras_n;
	wire        mem_we_n;
	wire [0:0]  mem_odt;
	wire [1:0]  mem_dm;
	wire [1:0]  mem_dqs;
	wire        mem_reset_n;
	
	wire [1:0]  mem_dqs_n;
	assign      mem_dqs_n = {~mem_dqs[1],~mem_dqs[0]};


//------------------------------------------------------------------------
// DDR2 Memory Model
//------------------------------------------------------------------------
//ddr2_interface_mem_model u_comp_ddr2 (
ddr2_interface_full_mem_model u_comp_ddr2 (
	.mem_dq      (mem_dq),
	.mem_dqs     (mem_dqs),
	.mem_dqs_n   (mem_dqs_n),
	.mem_addr    (mem_addr),
	.mem_ba      (mem_ba),
	.mem_clk     (mem_clk),
	.mem_clk_n   (mem_clk_n),
	.mem_cke     (mem_cke),
	.mem_cs_n    (mem_cs_n),
	.mem_ras_n   (mem_ras_n),
	.mem_cas_n   (mem_cas_n),
	.mem_we_n    (mem_we_n),
	.mem_dm      (mem_dm),
	.mem_odt     (mem_odt)
	);
	
	//mem_reset_n // Altera model doesn't have reset
 

//------------------------------------------------------------------------
// Image Sensor Model
//------------------------------------------------------------------------
	sensor_sim snsr_sm0(
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
	evb1007 dut(
		.okUH(okUH),
		.okHU(okHU),
		.okUHU(okUHU),
		.okAA(okAA),
		.led(led),
		
		.sys_clk(sys_clk), 
		
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

		.mem_dq(mem_dq),
		.mem_addr(mem_addr),
		.mem_ba(mem_ba),
		.mem_clk(mem_clk),
		.mem_clk_n(mem_clk_n),
		.mem_cke(mem_cke),
		.mem_cs_n(mem_cs_n),
		.mem_cas_n(mem_cas_n),
		.mem_ras_n(mem_ras_n),
		.mem_we_n(mem_we_n),
		.mem_odt(mem_odt),
		.mem_dm(mem_dm),
		.mem_dqs(mem_dqs)
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
	parameter pipeOutSize = 1024;     // REQUIRED: byte (must be even) length of default
	                                  //           PipeOut; Integer 0-2^32
	parameter registerSetSize = 32;  // Size of array for register set commands.
	//------------------------------------------------------------------------
	//OK Host Simulation
	// Registers
	reg [31:0] u32Address  [0:(registerSetSize-1)];
	reg [31:0] u32Data     [0:(registerSetSize-1)];
	reg [31:0] u32Count;
	integer k, e;
	reg	[7:0]	pipeIn  [0:(pipeInSize-1)];
	reg	[7:0]	pipeOut [0:(pipeOutSize-1)];
	reg	[7:0]	pipetmp [0:(pipeInSize-1)];   // Data Check Array
	reg data_trigger;
	
	
	// Clock Generation
	parameter tCLK = 20.0;
	initial sys_clk = 0;
	always #(tCLK/2.0) sys_clk = ~sys_clk;
	
	// Reset
	initial begin
		sensor_sim_reset_b = 1'b0;
		data_trigger = 1'b0;
	end

	// FrontPanel API Task Calls.
	integer i;
	initial begin
		
		FrontPanelReset;
		$display("//// Begin Single Capture at:                           %dns   /////", $time);
		
		// Assert then deassert RESET_FIFO
		SetWireInValue(8'h00, 32'h0000002f, 32'h0000002f); // Ping Pong Mode dis-abled, 16bit packing
		UpdateWireIns;
		SetWireInValue(8'h00, 32'h00000000, 32'h00000007); // Release clock resets
		UpdateWireIns;
		#1000
		SetWireInValue(8'h00, 32'h00000000, 32'h0000000f); // Release async resets
		UpdateWireIns;
		$display("//// System resets complete at:          %dns   /////", $time);
		
		SetWireInValue(8'h02, 32'h3900, 32'h0000ffff); // Set readout count (1259776)
		SetWireInValue(8'h03, 32'h13, 32'h0000ffff); // Set readout count
		SetWireInValue(8'h04, 32'd0, 32'h0000ffff); // Set readout address 15:0
		SetWireInValue(8'h05, 32'd0, 32'h0000ffff); // Set readout address 29:16
		UpdateWireIns;
	
		wait (dut.memif_init_done == 1'b1);
		$display("//// DDR2 PHY initialization complete at:          %dns   /////", $time);
		
		#100
		sensor_sim_reset_b = 1'b1;
		$display("//// Release Sensor Simulation Reset at:          %dns   /////", $time);
	
		// Clear PipeOut
		for (k=0; k<pipeOutSize; k=k+1) pipeOut[k] = 8'h00;
		
		// Capture Trigger
			ActivateTriggerIn(8'h40, 0);
			$display("Capture trigger #%d at:           %dns", k, $time);
			
		// Read 16 2048 byte blocks
		for (k=0; k<16; k=k+1) begin
			// Wait for a trigger indicating that image data is available (FIFO is half full = 2048 bytes available)
			data_trigger=0;
			while (data_trigger==0) begin
				UpdateTriggerOuts;
				data_trigger = IsTriggered(8'h60, 32'h00000001);
			end
			$display("Frame Available in DDR #%d at:           %dns", k, $time);
			
			// Begin Host Readout
			ActivateTriggerIn(8'h40, 1);
			$display("Image Data Readout #%d at:           %dns", k, $time);
			
			#1000
		
			// Read the block out
			ReadFromPipeOut(8'ha0, 2048);
			$display("//// Read From DDR2 complete at:                   %dns   /////", $time);
		end
		
		/*
		// Test read-back data.
		e=0;
		for (k=0; k<pipeInSize; k=k+1) begin 
			if (pipeOut[k] != pipetmp[k]) begin
				e=e+1;	// Keep track of the number of errors
				$display(" ");
				$display("Error! Data mismatch at byte %d:  Expected: 0x%08x Read: 0x%08x", k, pipetmp[k], pipeOut[k]);
			end
		end
		
		if (e == 0) begin
			$display(" ");
			$display("Success! All data passes readback.");
		end
*/

	$display("Simulation done at: %dns", $time);

	end

	// Do not remove!
	`include "./oksim/okHostCalls.v"

endmodule
