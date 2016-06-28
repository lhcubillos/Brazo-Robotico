`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:38:51 06/06/2016 
// Design Name: 
// Module Name:    nuevo_contador_8_bits 
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
module nuevo_contador_8_bits(
		input btn_up,
		input btn_down,
		input clk,
		//input rst,

		output reg [7:0] pos
    );
	 
	 parameter IDLE = 2'b00, SUBIENDO = 2'b01, BAJANDO = 2'b10;
	 
	 reg [1:0] state;
	 initial state = IDLE;
	 initial pos = 50;
	 always @(posedge clk)
	 begin
		if (btn_up) state <= SUBIENDO;
		else if (btn_down) state <= BAJANDO;
		else state <= IDLE;
	 end
	 
	 always @(posedge clk)
	 begin
		if (state == SUBIENDO && pos < 180) pos <= pos + 1;
		else if (state == BAJANDO && pos > 0) pos <= pos - 1;
	 end
	 


endmodule
