
module SevenSeg(
		input clk,
		input [13:0] decimal,
		output [3:0] an,
		output [7:0] seg
    );
	 
	 wire [15:0] bcd_out;
	 
	 
	 bcd decToBCD (
		.decimal(decimal),
		.bcd_out(bcd_out)
	 );
	 
	 seven_seg BCDTo7Seg(
		.clk(clk),
		.bcd_in(bcd_out),
		.seg(seg),
		.an(an)
	 );


endmodule
