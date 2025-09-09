`timescale 1 ns / 10 ps
`default_nettype none
module tf();
	reg  clk;
	reg  reset;
	reg  start;
	wire done;
	wire [7:0] divclk;
	
	wire       memclk;
	reg        memstart;
	reg        memwrite;
	reg        memread;
	reg  [7:0] memdin;
	wire [7:0] memdout;
	
	wire i2c_sclk;
	wire i2c_sdat;
	wire i2c_sdat_out;
	wire i2c_drive;

parameter   ENABLE_CLK_STRETCH     = 0;
parameter   CLK_STRETCH_COUNT      = 256;
parameter   CLK_STRETCH_BITS       = 9'b100000000;
parameter   DIVCLK                 = 47;

assign divclk = DIVCLK;

i2cController dut (
	.clk(clk), 
	.reset(reset), 
	.start(start), 
	.done(done),
	.divclk(divclk),
	.memclk(memclk), 
	.memstart(memstart),
	.memwrite(memwrite), 
	.memread(memread), 
	.memdin(memdin), 
	.memdout(memdout),
	.i2c_sclk(i2c_sclk), 
	.i2c_sdat_in(i2c_sdat),
	.i2c_sdat_out(i2c_sdat_out),
	.i2c_drive(i2c_drive)
	);

`define T_Slave_Delay     150      //150ns
`define T_I2cCtrlClk      39.062  // 78.125ns = 12.8MHz => 100KHz SCLK

pullup(i2c_sclk);
pullup(i2c_sdat);

//Sdata Tristate
assign i2c_sdat = (i2c_drive) ? (i2c_sdat_out) : (1'bz);

//Generate Clocks
initial begin
	clk = 0;
	forever begin
		#(`T_I2cCtrlClk) clk = 1'b1;
		#(`T_I2cCtrlClk) clk = 1'b0;
	end
end
assign memclk = clk;

//Reset
initial begin
	reset = 1;
	start = 0;
	memstart = 0;
	memwrite = 0;
	memread = 0;
	memdin = 0;

	@(posedge clk);
	@(posedge clk) reset = 0;
end

// Sync Test Fixture "go" signal into 
// one shot "start" signal in clk domain
reg go;
reg [1:0] god;
always @(posedge clk) begin
	god <= {god[0], go};
	start <= god[0] ^ god[1];
end


initial begin
	go = 0;
	god = 0;
	
@(posedge memclk);
	@(posedge memclk);
	@(posedge memclk);

  // 1. Write data into I2S memory.
  @(posedge memclk); memstart = 1;
	@(posedge memclk); memstart = 0;
	
	@(posedge memclk); memwrite = 1; memdin = 8'h30; // Number of words. Address + Data [7:4]
	@(posedge memclk); memwrite = 0;
	@(posedge memclk); memwrite = 1; memdin = 8'hba; //Device Address
	@(posedge memclk); memwrite = 0;
	@(posedge memclk); memwrite = 1; memdin = 8'h10; //Register Address (REG_PLL_CONTROL)
	@(posedge memclk); memwrite = 0;
	@(posedge memclk); memwrite = 1; memdin = 8'hab; //MSB 0x00
	@(posedge memclk); memwrite = 0;
	@(posedge memclk); memwrite = 1; memdin = 8'h51; //LSB 0x51
	@(posedge memclk); memwrite = 0;
	
	go = ~go;
	while (done == 0) begin
		@(posedge memclk);
	end
	
	// 2. Read out I2S memory.
	@(posedge memclk); memstart = 1;
	@(posedge memclk); memstart = 0;
	
	@(posedge memclk); memwrite = 1; memdin = 8'h31; // Number of words. Address + Data [7:4]
	@(posedge memclk); memwrite = 0;
	@(posedge memclk); memwrite = 1; memdin = 8'hba; //Device Address
	@(posedge memclk); memwrite = 0;
	@(posedge memclk); memwrite = 1; memdin = 8'h10; //Register Address (REG_PLL_CONTROL)
	@(posedge memclk); memwrite = 0;

	go = ~go;
	while (done == 0) begin
		@(posedge memclk);
	end
	
	@(posedge memclk); memstart = 1;
	@(posedge memclk); memstart = 0;
	@(posedge memclk); memread = 1; #1 $display("Read: %h", memdout);
	@(posedge memclk); memread = 0;
	
end

/////////////////////////////////////
// I2C slave device emulation.
/////////////////////////////////////
reg         i2c_start;
reg         i2c_stop;
reg         i2c_dir;
integer     i2c_bitcursor;
reg  [7:0]  i2c_wordcap;
reg  [7:0]  i2c_devaddr;
reg         i2c_sdout;
reg         i2c_writing;
reg  [7:0]  i2c_readmem[0:16];
reg  [7:0]  i2c_readout;
integer     i2c_readptr;
wire [8:0]  i2c_clk_stretch;
reg  [15:0] i2c_clk_stretch_count;
reg         i2c_sclk_intent;

assign i2c_sdat = (i2c_dir) ? (i2c_sdout) : (1'bz);
assign i2c_sclk = (i2c_sclk_intent) ? (1'bz) : (1'b0); //Clock Stretching
assign i2c_clk_stretch = CLK_STRETCH_BITS;

initial begin
	i2c_start = 0;
	i2c_stop = 0;
	i2c_dir = 0;
	i2c_sdout = 1;
	i2c_writing = 1;
	i2c_readptr = 0;
	i2c_clk_stretch_count = 0;
	i2c_sclk_intent = 1;
	
	i2c_readmem[0] = 8'h05;
	i2c_readmem[1] = 8'hf0;
	i2c_readmem[2] = 8'h5a;
	i2c_readmem[3] = 8'h0f;
	i2c_readmem[4] = 8'h12;
	i2c_readmem[5] = 8'h34;
	i2c_readmem[6] = 8'h56;
	i2c_readmem[7] = 8'h78;
	i2c_readmem[8] = 8'h00;
end

reg i2c_sclk_setup;
always @(i2c_sclk) #1 i2c_sclk_setup = i2c_sclk;

always @(negedge i2c_sdat) begin
	// START condition.
	if ((i2c_sclk_setup == 1) && (i2c_sclk == 1)) begin
		i2c_start = 1;
		i2c_writing = 1;
		i2c_bitcursor = 0;
		i2c_wordcap = 0;
		i2c_devaddr = 0;
		i2c_readout <= i2c_readmem[i2c_readptr];
		$display("START at time: %t", $time);
	end
end

always @(posedge i2c_sdat) begin
	// STOP condition.
	if (i2c_sclk_setup == 1) begin
		$display("STOP");
	end
end

// Drive output when READING.
always @(negedge i2c_sclk) begin
	if (~i2c_writing) begin
		if (i2c_bitcursor < 8) begin
			#`T_Slave_Delay i2c_sdout = i2c_readout[7-i2c_bitcursor];
		end
	end
end

always @(posedge i2c_sclk) begin
	if (i2c_writing) begin
		if (i2c_bitcursor < 8) begin
			i2c_wordcap[7-i2c_bitcursor] = #`T_Slave_Delay i2c_sdat;
		end
	end
	
	// Get device address if first transmission.
	if (i2c_bitcursor == 8) begin
		i2c_bitcursor = 0;
		if (i2c_start) begin
			i2c_start = 0;
			i2c_devaddr = i2c_wordcap;
			i2c_writing = ~i2c_wordcap[0];
			i2c_clk_stretch_count = 0;
			$display("Device Address: %h", i2c_devaddr);
		end else begin
			if (i2c_writing) begin
				$display("Wrote word: %h", i2c_wordcap);
			end
		end
		if (~i2c_writing) begin
			i2c_readout = i2c_readmem[i2c_readptr];
			i2c_readptr = i2c_readptr + 1;
		end
		i2c_wordcap = 0;
	end else begin
		i2c_bitcursor = i2c_bitcursor + 1;
	end
	
end

// ACK
always @(negedge i2c_sclk) begin
	#`T_Slave_Delay;
	if (i2c_bitcursor == 8) begin
		i2c_sdout = 0;
	end
end

always @(negedge i2c_sclk) begin
	#`T_Slave_Delay;
	if (i2c_bitcursor == 8)
		i2c_dir = i2c_writing;
	else
		i2c_dir = ~i2c_writing;
end

//Clock Stretching
always @(posedge clk) begin
	if ( (1 == ENABLE_CLK_STRETCH) && 
	     (0 == i2c_sclk) &&
	     (1'b1 == i2c_clk_stretch[i2c_bitcursor]) ) begin
		if(i2c_clk_stretch_count < CLK_STRETCH_COUNT) begin
			i2c_sclk_intent = 1'b0;
			i2c_clk_stretch_count = i2c_clk_stretch_count + 1;
		end else begin
			i2c_sclk_intent = 1'b1;
			i2c_clk_stretch_count = 0;
		end
	end else begin
		i2c_sclk_intent = 1;
	end
end


endmodule