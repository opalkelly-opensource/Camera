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
   parameter DEBUG_EN                = 0;
   localparam DBG_WR_STS_WIDTH       = 32;
   localparam DBG_RD_STS_WIDTH       = 32;
   	parameter C3_MEMCLK_PERIOD     = 3200;
   parameter C3_RST_ACT_LOW        = 0;
   parameter C3_INPUT_CLK_TYPE     = "SINGLE_ENDED";
   parameter C3_NUM_DQ_PINS        = 16;
   parameter C3_MEM_ADDR_WIDTH     = 13;
   parameter C3_MEM_BANKADDR_WIDTH = 3;
   parameter C3_MEM_ADDR_ORDER     = "ROW_BANK_COLUMN"; 
      parameter C3_P0_MASK_SIZE       = 8;
   parameter C3_P0_DATA_PORT_SIZE  = 64;  
   parameter C3_P1_MASK_SIZE       = 8;
   parameter C3_P1_DATA_PORT_SIZE  = 64;
   parameter C3_CALIB_SOFT_IP      = "FALSE";  // kz shut of calibration
   parameter C3_SIMULATION      = "TRUE";
   parameter C3_HW_TESTING      = "FALSE";

// ========================================================================== //
// Signal Declarations                                                        //
// ========================================================================== //

	//FP Host
	reg  [7:0]  hi_in;
	wire [1:0]  hi_out;
	wire [15:0] hi_inout;
	wire        hi_aa;
	
	wire        i2c_sda;
	wire        i2c_scl;
	wire        hi_muxsel;
	
	wire [7:0]  led;
	
	//Testbench
	reg         clk1; // CY22393 CLKA @ 100MHz
	
	//Image Sensor I/O
	wire        sdata;
	wire        sclk;  
	wire        trigger;
	wire        reset_b;

	wire        extclk;
	wire        strobe;

	wire        pix_clk;
	wire        line_valid;
	wire        frame_valid;

	wire [11:0] pix_data;

	// DDR2                              
	wire                                c3_sys_rst_n;
	wire                                calib_done;
	wire                                error;
	
	wire [C3_NUM_DQ_PINS-1:0]           mcb3_dram_dq;
	wire [C3_MEM_ADDR_WIDTH-1:0]        mcb3_dram_a;
	wire [C3_MEM_BANKADDR_WIDTH-1:0]    mcb3_dram_ba;
	wire                                mcb3_dram_ras_n;
	wire                                mcb3_dram_cas_n;
	wire                                mcb3_dram_we_n;
	wire                                mcb3_dram_odt;
	wire                                mcb3_dram_cke;
	wire                                mcb3_dram_dm;
	wire                                mcb3_dram_udqs;
	wire                                mcb3_dram_udqs_n;
	wire                                mcb3_rzq;
	wire                                mcb3_zio;
	wire                                mcb3_dram_udm;
	wire                                mcb3_dram_dqs;
	wire                                mcb3_dram_dqs_n;
	wire                                mcb3_dram_ck;
	wire                                mcb3_dram_ck_n;
	wire                                mcb3_dram_cs_n;
	
	// The PULLDOWN component is connected to the ZIO signal primarily to avoid the
	// unknown state in simulation. In real hardware, ZIO should be a no connect(NC) pin.
	PULLDOWN zio_pulldown3 (.O(mcb3_zio));
	PULLDOWN rzq_pulldown3 (.O(mcb3_rzq));


//------------------------------------------------------------------------
// DDR2 Memory Model
//------------------------------------------------------------------------
	generate
		if(C3_NUM_DQ_PINS == 16) begin : MEM_INST3
			ddr2_model_c3 u_mem_c3(
				.ck         (mcb3_dram_ck),
				.ck_n       (mcb3_dram_ck_n),
				.cke        (mcb3_dram_cke),
				.cs_n       (1'b0),
				.ras_n      (mcb3_dram_ras_n),
				.cas_n      (mcb3_dram_cas_n),
				.we_n       (mcb3_dram_we_n),
				.dm_rdqs    ({mcb3_dram_udm,mcb3_dram_dm}),
				.ba         (mcb3_dram_ba),
				.addr       (mcb3_dram_a),
				.dq         (mcb3_dram_dq),
				.dqs        ({mcb3_dram_udqs,mcb3_dram_dqs}),
				.dqs_n      ({mcb3_dram_udqs_n,mcb3_dram_dqs_n}),
				.rdqs_n     (),
				.odt        (mcb3_dram_odt)
			);
		end else begin
			ddr2_model_c3 u_mem_c3(
				.ck         (mcb3_dram_ck),
				.ck_n       (mcb3_dram_ck_n),
				.cke        (mcb3_dram_cke),
				.cs_n       (1'b0),
				.ras_n      (mcb3_dram_ras_n),
				.cas_n      (mcb3_dram_cas_n),
				.we_n       (mcb3_dram_we_n),
				.dm_rdqs    (mcb3_dram_dm),
				.ba         (mcb3_dram_ba),
				.addr       (mcb3_dram_a),
				.dq         (mcb3_dram_dq),
				.dqs        (mcb3_dram_dqs),
				.dqs_n      (mcb3_dram_dqs_n),
				.rdqs_n     (),
				.odt        (mcb3_dram_odt)
			);
		end
	endgenerate

//------------------------------------------------------------------------
// Image Sensor Model
//------------------------------------------------------------------------
	sensor_sim snsr_sm0(
		.reset_b(reset_b),
		.extclk(extclk),
	
		.frame_valid(frame_valid),
		.line_valid(line_valid),
		
		.pixclk(pix_clk),
		.dout(pix_data)        
		);

//------------------------------------------------------------------------
// EVB1005 DUT
//------------------------------------------------------------------------
	evb1005 #(
		.C3_P0_MASK_SIZE       (C3_P0_MASK_SIZE      ),
.C3_P0_DATA_PORT_SIZE  (C3_P0_DATA_PORT_SIZE ),
.C3_P1_MASK_SIZE       (C3_P1_MASK_SIZE      ),
.C3_P1_DATA_PORT_SIZE  (C3_P1_DATA_PORT_SIZE ),
.C3_MEMCLK_PERIOD      (C3_MEMCLK_PERIOD),
.C3_RST_ACT_LOW        (C3_RST_ACT_LOW),
.C3_INPUT_CLK_TYPE     (C3_INPUT_CLK_TYPE),

 
.DEBUG_EN              (DEBUG_EN),

.C3_MEM_ADDR_ORDER     (C3_MEM_ADDR_ORDER    ),
.C3_NUM_DQ_PINS        (C3_NUM_DQ_PINS       ),
.C3_MEM_ADDR_WIDTH     (C3_MEM_ADDR_WIDTH    ),
.C3_MEM_BANKADDR_WIDTH (C3_MEM_BANKADDR_WIDTH),

.C3_HW_TESTING         (C3_HW_TESTING),
.C3_SIMULATION         (C3_SIMULATION),
.C3_CALIB_SOFT_IP      (C3_CALIB_SOFT_IP )
	)
	dut(
		.hi_in                  (hi_in),
		.hi_out                 (hi_out),
		.hi_inout               (hi_inout),
		.hi_aa                  (hi_aa),
		.i2c_sda                (i2c_sda),
		.i2c_scl                (i2c_scl),
		.hi_muxsel              (hi_muxsel),
	
		.led                    (led),
		
		.sdata(sdata),
		.sclk(sclk),  
		.trigger(trigger),
		.reset_b(reset_b),
	
		.extclk(extclk),
		.strobe(strobe),
	
		.pix_clk(pix_clk),
		.line_valid(line_valid),
		.frame_valid(frame_valid),
	
		.pix_data(pix_data),
		
		//.calib_done(calib_done),
		//.error(error),
		//.c3_sys_rst_n(c3_sys_rst_n),
	   
		.clk1                   (clk1),
		
		.mcb3_dram_dq(mcb3_dram_dq),
		.mcb3_dram_a(mcb3_dram_a),
		.mcb3_dram_ba(mcb3_dram_ba),
		.mcb3_dram_ras_n(mcb3_dram_ras_n),
		.mcb3_dram_cas_n(mcb3_dram_cas_n),
		.mcb3_dram_we_n(mcb3_dram_we_n),
		.mcb3_dram_odt(mcb3_dram_odt),
		.mcb3_dram_cke(mcb3_dram_cke),
		.mcb3_dram_dm(mcb3_dram_dm),
		.mcb3_dram_udqs(mcb3_dram_udqs),
		.mcb3_dram_udqs_n(mcb3_dram_udqs_n),
		.mcb3_rzq(mcb3_rzq),
		.mcb3_zio(mcb3_zio),
		.mcb3_dram_udm(mcb3_dram_udm),
	   
		.mcb3_dram_dqs(mcb3_dram_dqs),
		.mcb3_dram_dqs_n(mcb3_dram_dqs_n),
		.mcb3_dram_ck(mcb3_dram_ck),
		.mcb3_dram_ck_n(mcb3_dram_ck_n),
		.mcb3_dram_cs_n(mcb3_dram_cs_n)
	);


	//------------------------------------------------------------------------
	// Begin okHost simulation user configurable global data
	//------------------------------------------------------------------------
	parameter BlockDelayStates = 5;   // REQUIRED: # of clocks between blocks of pipe data
	parameter ReadyCheckDelay = 5;    // REQUIRED: # of clocks before block transfer before
	                                  //           host interface checks for ready (0-255)
	parameter PostReadyDelay = 5;     // REQUIRED: # of clocks after ready is asserted and
	                                  //           check that the block transfer begins (0-255)
	parameter pipeInSize = 	1024;     // REQUIRED: byte (must be even) length of default
	                                  //           PipeIn; Integer 0-2^32
	parameter pipeOutSize = 9600;     // REQUIRED: byte (must be even) length of default
	                                  //           PipeOut; Integer 0-2^32
	integer k, e;
	reg	[7:0]	pipeIn  [0:(pipeInSize-1)];
	reg	[7:0]	pipeOut [0:(pipeOutSize-1)];
	reg	[7:0]	pipetmp [0:(pipeInSize-1)];   // Data Check Array
	reg [15:0] fifo_rd_count;
	reg [15:0] status;
	reg i2c_done;
	
	
	// Clock Generation
	parameter tCLK = 10.0;
	initial clk1 = 0;
	always #(tCLK/2.0) clk1 = ~clk1;


	// FrontPanel API Task Calls.
	integer i;
	initial begin
		
		FrontPanelReset;
		$display("//// Beginning Tests at:                           %dns   /////", $time);
		
		SetWireInValue(8'h00, 16'h000f, 16'h00ff);
		UpdateWireIns;
		SetWireInValue(8'h00, 16'h000e, 16'h00ff);
		UpdateWireIns;
		SetWireInValue(8'h00, 16'h000c, 16'h00ff); 
		UpdateWireIns;
		SetWireInValue(8'h00, 16'h0008, 16'h00ff); 
		UpdateWireIns;
		SetWireInValue(8'h00, 16'h0000, 16'h00ff); 
		UpdateWireIns;
		
		status=16'h0;
		while (status == 16'b0) begin
			UpdateWireOuts;
			status = GetWireOutValue(8'h21);
		end
		$display("Reset Complete at:           %dns", $time);

		
		//wait (calib_done == 1'b1);
	  #10000
		$display("//// DDR2 PHY initialization complete at:          %dns   /////", $time);
		
		/*
		$display("//// I2C Setup at:          %dns   /////", $time);
		// Mem Start
		ActivateTriggerIn(8'h42, 1);// Clear Address Counters
		// Num of Data Words
		SetWireInValue(8'h01, 16'h0030, 16'h00ff); // Address + Data Words
		UpdateWireIns;
		ActivateTriggerIn(8'h42, 2);
		// Device Address
		SetWireInValue(8'h01, 16'h00ba, 16'h00ff); // 0xBA for MT9P031
		UpdateWireIns;
		ActivateTriggerIn(8'h42, 2);
		// Register Address
		SetWireInValue(8'h01, 16'h00a0, 16'h00ff); // A0 = Test Patern Control
		UpdateWireIns;
		ActivateTriggerIn(8'h42, 2);
		// Data 0 MSB
		SetWireInValue(8'h01, 16'h0000, 16'h00ff); 
		UpdateWireIns;
		ActivateTriggerIn(8'h42,2);
		// Data 1 LSB
		SetWireInValue(8'h01, 16'h0021, 16'h00ff); // Classic Test Patern
		UpdateWireIns;
		ActivateTriggerIn(8'h42, 2);
		
		$display("//// I2C Start:          %dns   /////", $time);
		ActivateTriggerIn(8'h42, 0);
		
		i2c_done = 0;
		while (i2c_done == 0) begin
			UpdateTriggerOuts;
			i2c_done = IsTriggered(8'h61, 16'h0001);
		end
		$display("I2C Done at:           %dns", $time);
		
		*/
		
		// Clear PipeOut
		for (k=0; k<pipeOutSize; k=k+1) pipeOut[k] = 8'h00;
		
		ActivateTriggerIn(8'h40, 0);
		$display("Trigger Frame Capture at:           %dns", $time);
		
		fifo_rd_count=16'h0;
		while (fifo_rd_count < 128) begin
			UpdateWireOuts;
			fifo_rd_count = GetWireOutValue(8'h20);
		end
		$display("Frame Available at:           %dns", $time);
		
		// Read the block out
		ReadFromPipeOut(8'ha0, 128); //Sim Image 80x60x2 = 9600 bytes
		$display("//// Read From DDR2 complete at:                   %dns   /////", $time);
		
		

		
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
