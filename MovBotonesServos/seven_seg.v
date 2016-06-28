// BCD to four 7-segment diplay output

module seven_seg(
	  clk,
	  bcd_in,
	  seg,
	  an
	);
	  
  // Declare input output
  
  input 	[15:0]	bcd_in;
  input clk;
  
  output reg [7:0] seg;
  output [3:0] an;
  
  // Declare internal variables
  
	//reg [1:0] Q;
	
	reg [15:0] disp_ctr = 0;
	reg [6:0] sseg;
	reg [3:0] an_temp;
	
  	always @ (posedge(clk))   // When will Always Block Be Triggered
	begin
		disp_ctr = disp_ctr + 1;
		if (disp_ctr >= 49999) begin
			an_temp = 4'b1110;
			sseg = bcd_in[3:0];
		end else if (disp_ctr <= 12499) begin
			an_temp = 4'b1101;
			sseg = bcd_in[7:4];
		end else if (disp_ctr <= 24999) begin
			an_temp = 4'b1011;
			sseg = bcd_in[11:8];
		end else if (disp_ctr <= 37499) begin
			an_temp = 4'b0111;
			sseg = bcd_in[15:12];
		end
	
		begin
		case(sseg)
			0:		seg = 8'b11000000;
			1:		seg = 8'b11111001;
			2:		seg = 8'b10100100;
			3:		seg = 8'b10110000;
			4:		seg = 8'b10011001;
			5:		seg = 8'b10010010;
			6:		seg = 8'b10000010;
			7:		seg = 8'b11111000;
			8:		seg = 8'b10000000;
			9:		seg = 8'b10011000;
			default:	seg = 8'b11111111;
		  endcase
		end

	end
	
	
	assign an = an_temp;
  
endmodule
