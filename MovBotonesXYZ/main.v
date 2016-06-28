module main(
	input [1:0] btn,
	input [4:0] sw,
	input clk,
	
	output [7:0] seg,
	output [3:0] an
//	output servo1,
//	output servo2,
//	output servo3,
//	output servo4,
//	output servo5
    );
	 
		wire [1:0] btnOut;
		wire [1:0] btnX;
		wire [1:0] btnY;
		wire [1:0] btnZ;
		wire [1:0] btnG;
		
		wire [7:0] dx; //contador posicionamiento en X
		wire [7:0] dy;
		wire [7:0] dz;
		wire [7:0] dg;
		wire [7:0] pos_out;

		assign btnX = sw[0] ? btnOut: 2'b0;
		assign btnY = sw[1] ? btnOut: 2'b0;
		assign btnZ = sw[2] ? btnOut: 2'b0;
		assign btnG = sw[3] ? btnOut: 2'b0;
		
		assign pos_out = sw[0] ? dx:
								(sw[1] ? dy :
								(sw[2] ? dz :
								(sw[3] ? dg : 0)));
		
		
		SevenSeg SevenSeg(
		.clk(clk),
		.decimal(pos_out),
		
		.an(an),
		.seg(seg)
		);
				
		debouncers debounce (
		.clk(clk),
		.btnIn(btn),
		.btnOut(btnOut)
		);
		
		coords_controller coords_controller (
		.clk(clk),
		.btnX(btnX),
		.btnY(btnY),
		.btnZ(btnZ),
		.btnG(btnG),
		
		.dx(dx),
		.dy(dy),
		.dz(dz),
		.dg(dg)
		);


endmodule
