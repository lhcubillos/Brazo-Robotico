`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:09 06/26/2016 
// Design Name: 
// Module Name:    coords_controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module coords_controller(
	input clk,
	
	input [1:0] btnX,
	input [1:0] btnY,
	input [1:0] btnZ,
	input [1:0] btnG,
	
	output [7:0] dx,
	output [7:0] dy,
	output [7:0] dz,
	output [7:0] dg
	
    );
	 
	wire new_clk;
	parameter uno = 1;
	
	wire [7:0] dx_wire;
	wire [7:0] dy_wire;
	wire [7:0] dz_wire;
	wire [7:0] dg_wire;
	
	btn_clk_divider btn_clk_dividerP (
		.clk(clk),
		.enable(uno),

		.out(new_clk)
	);
	
	contador_8bits contX (
	  .cnt_up(btnX[0]),
	  .cnt_down(btnX[1]),
	  .clk(new_clk),

	  .pos(dx_wire) //8bits
	);
	
	contador_8bits contY (
	  .cnt_up(btnY[0]),
	  .cnt_down(btnY[1]),
	  .clk(new_clk),

	  .pos(dy_wire) //8bits
	);
	
	contador_8bits contZ (
	  .cnt_up(btnZ[0]),
	  .cnt_down(btnZ[1]),
	  .clk(new_clk),

	  .pos(dz_wire) //8bits
	);
	
	contador_8bits contG (
	  .cnt_up(btnG[0]),
	  .cnt_down(btnG[1]),
	  .clk(new_clk),

	  .pos(dg_wire) //8bits
	);
	
	assign dx = dx_wire;
	assign dy = dy_wire;
	assign dz = dz_wire;
	assign dg = dg_wire;


endmodule
