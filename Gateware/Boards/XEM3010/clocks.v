// clocks.v
//
// This generates the clock for the SDRAM other clock management that is 
// required for the image sensor interface.

`timescale 1ns/1ps

module clocks # (
		parameter C_CLKIN_PERIOD          = 10.000,    // System clock period (ns)
		parameter C_CLKFX_DIVIDE          = 3,         // Input clock divider
		parameter C_CLKFX_MULTIPLY        = 4,         // PLL multiplier  VCO = (INCLK / DIV) * MULT
		parameter C_CLKPIXEXT_DIVIDE      = 5,         // Image sensor EXTCLK divider
		parameter C_PHASE_SHIFT           = -100,      // Determined experimentatlly for SDRAM
		parameter PIXGEN_PHASE_SHIFT      = 0          // Phase shift for PIX_CLK generation
	) (
		input  wire        sys_clk,
		input  wire        sys_rst_n,
		output wire        sdram_clk,
		output wire        dcm_locked,
		output wire        pix_extclk,          // Outgoing image sensor EXTCLK (96 MHz)
		input  wire        pix_clk,             // Incoming pixel clock from the sensor
		input  wire        reset_pixdcm,
		output wire        clk_pix
	);

wire                       sdram_clk_bufg_in;
wire                       pix_extclk_bufg_in;
wire                       clk_pix_bufg_in, clkpix_bufg;


//-------------------------------------------------------------------------
// DCM to generate SDRAM Clock and PIX_EXTCLK 
//-------------------------------------------------------------------------
DCM_SP # (
		.CLKDV_DIVIDE(C_CLKPIXEXT_DIVIDE),    // CLKDV divide value
		                                      // (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
		.CLKFX_DIVIDE(C_CLKFX_DIVIDE),        // Divide value on CLKFX outputs - D - (1-32)
		.CLKFX_MULTIPLY(C_CLKFX_MULTIPLY),    // Multiply value on CLKFX outputs - M - (2-32)
		.CLKIN_DIVIDE_BY_2("FALSE"),          // CLKIN divide by two (TRUE/FALSE)
		.CLKIN_PERIOD(C_CLKIN_PERIOD),        // Input clock period specified in nS
		.CLKOUT_PHASE_SHIFT("FIXED"),         // Output phase shift (NONE, FIXED, VARIABLE)
		.CLK_FEEDBACK("1X"),                  // Feedback source (NONE, 1X, 2X)
		.DESKEW_ADJUST("SOURCE_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
		.DFS_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
		.DLL_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
		.DSS_MODE("NONE"),                    // Unsupported - Do not change value
		.DUTY_CYCLE_CORRECTION("TRUE"),       // Unsupported - Do not change value
		.FACTORY_JF(16'hc080),                // Unsupported - Do not change value
		.PHASE_SHIFT(C_PHASE_SHIFT),          // Amount of fixed phase shift (-255 to 255)
		.STARTUP_WAIT("FALSE")                // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
	) DCM_SP_sdram (
		.CLKIN    (sys_clk),            // 1-bit input: Clock input
		.CLKFB    (sdram_clk),          // 1-bit input: Clock feedback input
		.RST      (sys_rst_n),          // 1-bit input: Active high reset input
		.DSSEN    (1'b0),               // 1-bit input: Unsupported, specify to GND.
		.PSCLK    (),                   // 1-bit input: Phase shift clock input
		.PSEN     (1'b0),               // 1-bit input: Phase shift enable
		.PSINCDEC (),                   // 1-bit input: Phase shift increment/decrement input
	
		.CLK0     (),                   // 1-bit output: 0 degree clock output
		.CLK180   (),                   // 1-bit output: 180 degree clock output
		.CLK270   (),                   // 1-bit output: 270 degree clock output
		.CLK2X    (),                   // 1-bit output: 2X clock frequency clock output
		.CLK2X180 (),                   // 1-bit output: 2X clock frequency, 180 degree clock output
		.CLK90    (),                   // 1-bit output: 90 degree clock output
		.CLKDV    (pix_extclk_bufg_in), // 1-bit output: Divided clock output
		.CLKFX    (sdram_clk_bufg_in),  // 1-bit output: Digital Frequency Synthesizer output (DFS)
		.CLKFX180 (),                   // 1-bit output: 180 degree CLKFX output
		.LOCKED   (dcm_locked),         // 1-bit output: DCM_SP Lock Output
		.PSDONE   (),                   // 1-bit output: Phase shift done output
		.STATUS   ()                    // 8-bit output: DCM_SP status output
	);

BUFG U_BUFG_CLK0 (.I(sdram_clk_bufg_in),    .O(sdram_clk));
BUFG U_BUFG_CLK4 (.I(pix_extclk_bufg_in),   .O(pix_extclk));


//-------------------------------------------------------------------------
// DCM to capture the PIX_CLK from the image sensor and create a local
// pixel clock to capture incoming pixel data.
//-------------------------------------------------------------------------
DCM_SP # (
		.CLKDV_DIVIDE(2.0),                   // CLKDV divide value
		                                      // (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
		.CLKFX_DIVIDE(1),                     // Divide value on CLKFX outputs - D - (1-32)
		.CLKFX_MULTIPLY(4),                   // Multiply value on CLKFX outputs - M - (2-32)
		.CLKIN_DIVIDE_BY_2("FALSE"),          // CLKIN divide by two (TRUE/FALSE)
		.CLKIN_PERIOD(13.8),                  // Input clock period specified in nS
		.CLKOUT_PHASE_SHIFT("FIXED"),         // Output phase shift (NONE, FIXED, VARIABLE)
		.CLK_FEEDBACK("1X"),                  // Feedback source (NONE, 1X, 2X)
		.DESKEW_ADJUST("SOURCE_SYNCHRONOUS"), // SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
		.DFS_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
		.DLL_FREQUENCY_MODE("LOW"),           // Unsupported - Do not change value
		.DSS_MODE("NONE"),                    // Unsupported - Do not change value
		.DUTY_CYCLE_CORRECTION("TRUE"),       // Unsupported - Do not change value
		.FACTORY_JF(16'hc080),                // Unsupported - Do not change value
		.PHASE_SHIFT(PIXGEN_PHASE_SHIFT),     // Amount of fixed phase shift (-255 to 255)
		.STARTUP_WAIT("FALSE")                // Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
	) DCM_SP_pix_clk (
		.CLKIN    (pix_clk),            // 1-bit input: Clock input
		.CLKFB    (clkpix_bufg),        // 1-bit input: Clock feedback input
		.RST      (reset_pixdcm),       // 1-bit input: Active high reset input
		.DSSEN    (1'b0),               // 1-bit input: Unsupported, specify to GND.
		.PSCLK    (),                   // 1-bit input: Phase shift clock input
		.PSEN     (1'b0),               // 1-bit input: Phase shift enable
		.PSINCDEC (),                   // 1-bit input: Phase shift increment/decrement input
	
		.CLK0     (clk_pix_bufg_in),    // 1-bit output: 0 degree clock output
		.CLK180   (),                   // 1-bit output: 180 degree clock output
		.CLK270   (),                   // 1-bit output: 270 degree clock output
		.CLK2X    (),                   // 1-bit output: 2X clock frequency clock output
		.CLK2X180 (),                   // 1-bit output: 2X clock frequency, 180 degree clock output
		.CLK90    (),                   // 1-bit output: 90 degree clock output
		.CLKDV    (),                   // 1-bit output: Divided clock output
		.CLKFX    (),                   // 1-bit output: Digital Frequency Synthesizer output (DFS)
		.CLKFX180 (),                   // 1-bit output: 180 degree CLKFX output
		.LOCKED   (),                   // 1-bit output: DCM_SP Lock Output
		.PSDONE   (),                   // 1-bit output: Phase shift done output
		.STATUS   ()                    // 8-bit output: DCM_SP status output
	);

BUFG U_BUFG_CLKPIX (.I(clk_pix_bufg_in), .O(clkpix_bufg));

// Invert the output of the PIX_CLK DCM.  This means that CLK_PIX is 
// inverted from the image sensor's PIX_CLK.  Therefore, we will 
// capture all inputs on the falling edge of PIX_CLK.
assign clk_pix = ~clkpix_bufg;

endmodule
