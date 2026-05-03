`timescale 1 ns / 10 ps
`default_nettype none

module sensor_sim(
	input  wire        reset_b,
	input  wire        extclk,

	output reg         frame_valid,
	output reg         line_valid,
	
	output reg         pixclk,
	output reg  [11:0] dout   
	);

parameter image_file = "srcimg.dat";
parameter ROWS       = 12;
parameter COLUMNS    = 14;
integer i,j;

// Actual 
/*
`define HORIZ_BLANK     1
`define VERT_BLANK      26 * COLUMNS // 9 Rows
`define ROWS            1944
`define COLUMNS         2592
`define FV_LEAD         609   //p55 Figure 29
`define FV_TRAIL        16 
*/

//Shortened for Resonable Simulation Time
`define HORIZ_BLANK     1
`define VERT_BLANK      10 
//`define ROWS            12   //60
//`define COLUMNS         14   //80
`define FV_LEAD         8   //p55 Figure 29
`define FV_TRAIL        4 


reg [11:0] image [COLUMNS-1:0][ROWS-1:0];

// Clock Generation
	parameter tCLK = 13.8;
	initial pixclk = 0;
	always #(tCLK/2.0) pixclk = ~pixclk;
	
//assign pixclk = extclk; 

// Initialize ouputs
initial begin
	frame_valid = 1'b0;
	line_valid = 1'b0;
	dout = 12'b0;
end

// Initialize our image data
initial begin
	//$readmemb(image_file, image);
	for (i=0; i<ROWS; i=i+1) begin
		for (j=0; j<COLUMNS; j=j+1) begin
			image[j][i] = (i * COLUMNS) + j;
		end
	end
	
end

// MT9P031 Simulation
//
// Micron MT9P031 5MP CMOS image sensor (2592x1944) in default mode

integer row_count;
integer col_count;
integer lead_count;
integer trail_count;

always @(posedge pixclk or negedge reset_b) begin
	if (reset_b == 0) begin
		row_count = 1;
		col_count = 1;
		lead_count = 1;
		trail_count = 1;
		frame_valid = 1'b0;
		line_valid = 1'b0;
		dout = 12'b0;
	end else begin
		
		//Generate frame_valid
		if ((row_count >= 1) && (row_count <= ROWS + `FV_TRAIL)) begin
			frame_valid = #4.3 1; //tPFH Typical p55
		end else begin
			frame_valid = #4.2 0; //tPFL Typical p55
		end
		
		//Generate line_valid
		if (frame_valid && (col_count > `FV_LEAD) && (col_count <= COLUMNS + `FV_LEAD) && row_count <= ROWS) begin
			line_valid = #3.5 1; //tPLH Typical p55
		end else begin
			line_valid = #4.1 0; //tPLL Typical p55
		end
		
		//Output Valid Pixels
		if (line_valid && frame_valid) begin
			dout = #2.1 image[col_count-`FV_LEAD-1][row_count-1]; //tPD Typical p55
		end

    //Blanking
		if (col_count == (COLUMNS + `HORIZ_BLANK + `FV_LEAD)) begin
			col_count = 1;
			row_count = row_count + 1;
			if (row_count == ROWS + `VERT_BLANK + `FV_TRAIL) begin
				row_count = 1;
			end
		end else begin
			col_count = col_count + 1;
		end
		
	end
end


endmodule

