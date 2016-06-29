`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:25:43 05/26/2016 
// Design Name: 
// Module Name:    clockDivider 
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
module clockDivider(
    input clock,
	 input [15:0] constante,
	 
    output reg clk
    );
	 
	reg [25:0] count;
	initial count = 0;
	
	//parameter constante = 50;
	 
	always @(posedge(clock)) begin
		
		if (count == constante) begin
			count <= 0;
			clk <= ~clk;
		end
		else begin
			count <= count + 1;
		end
	end


endmodule
