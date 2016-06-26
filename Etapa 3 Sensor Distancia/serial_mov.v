`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:58 06/23/2016 
// Design Name: 
// Module Name:    serial_mov 
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
module serial_mov(
    input sw,
	 input clk,
	 input [7:0] pos1,
	 input [7:0] pos2,
	 input [7:0] pos3,
	 input [7:0] pos4,
	 input [7:0] pos5,
	 
	 output reg [1:0] btn1, //btn[0]: add, btn[1]: sub
	 output reg [1:0] btn2,
	 output reg [1:0] btn3,
	 output reg [1:0] btn4,
	 output reg [1:0] btn5
    );
	
	parameter sub = 2'b10;
	parameter add = 2'b01;
	parameter zero = 2'b00;
	
	parameter point1 = 8'b10000000;
	parameter point2 = 8'b11000000;
	
	reg EST; //Estado 0: mov1, Estado 1: mov2
	initial begin
		EST = 1;
		btn1 = zero;
		btn2 = zero;
		btn3 = zero;
		btn4 = zero;
		btn5 = zero;
	end

	always @(posedge(clk)) begin
		if (sw) begin
			if (pos1 == point1 && pos4 == point1) begin
				EST <= 1;
			end
			else if (pos1 == point2 && pos4 == point2) begin
				EST <= 0;
			end
		
			if (EST) begin
				if (pos1 < point2) begin
					btn1 <= add;
				end
				else if (pos1 > point2) begin
					btn1 <= sub;
				end
				else begin
					btn1 <= zero;
				end

				if (pos2 < point2) begin
					btn2 <= add;
				end
				else if (pos2 > point2) begin
					btn2 <= sub;
				end
				else begin
					btn2 <= zero;
				end
				
				if (pos3 < point2) begin
					btn3 <= add;
				end
				else if (pos3 > point2) begin
					btn3 <= sub;
				end
				else begin
					btn3 <= zero;
				end
				
				if (pos4 < point2) begin
					btn4 <= add;
				end
				else if (pos4 > point2) begin
					btn4 <= sub;
				end
				else begin
					btn4 <= zero;
				end
				
				if (pos5 < point2) begin
					btn5 <= add;
				end
				else if (pos5 > point2) begin
					btn5 <= sub;
				end
				else begin
					btn5 <= zero;
				end

			end
			else begin
				if (pos1 < point1) begin
					btn1 <= add;
				end
				else if (pos1 > point1) begin
					btn1 <= sub;
				end
				else begin
					btn1 <= zero;
				end

				if (pos2 < point1) begin
					btn2 <= add;
				end
				else if (pos2 > point1) begin
					btn2 <= sub;
				end
				else begin
					btn2 <= zero;
				end
				
				if (pos3 < point1) begin
					btn3 <= add;
				end
				else if (pos3 > point1) begin
					btn3 <= sub;
				end
				else begin
					btn3 <= zero;
				end
				
				if (pos4 < point1) begin
					btn4 <= add;
				end
				else if (pos4 > point1) begin
					btn4 <= sub;
				end
				else begin
					btn4 <= zero;
				end
				
				if (pos5 < point1) begin
					btn5 <= add;
				end
				else if (pos5 > point1) begin
					btn5 <= sub;
				end
				else begin
					btn5 <= zero;
				end

			end
		end
		else begin
			btn1 <= zero;
			btn2 <= zero;
			btn3 <= zero;
			btn4 <= zero;
			btn5 <= zero;
		end
	
	end

//	always @(posedge(clk)) begin
//		if (sw) begin
//			
//			if (pos1 == point1 && pos2 == point1 && pos3 == point1 && pos4 == point1 && pos5 == point1) begin
//				EST <= 1;
//			end
//			else if (pos1 == point2 && pos2 == point2 && pos3 == point2 && pos4 == point2 && pos5 == point2) begin
//				EST <= 0;
//			end
//			else begin
//				EST <= EST;
//			end
//			
//			//Mov1
//			if (EST) begin 
//				/*
//				case (pos1)
//					pos1 > point2: btn1 <= sub;
//					pos1 < point2: btn1 <= add;
//					default: btn1 <= zero;
//				endcase
//				case (pos2)
//					pos2 > point2: btn2 <= sub;
//					pos2 < point2: btn2 <= add;
//					default: btn2 <= zero;
//				endcase
//				case (pos3)
//					pos3 > point2: btn3 <= sub;
//					pos3 < point2: btn3 <= add;
//					default: btn3 <= zero;
//				endcase
//				case (pos4)
//					pos4 > point2: btn4 <= sub;
//					pos4 < point2: btn4 <= add;
//					default: btn4 <= zero;
//				endcase
//				case (pos5)
//					pos5 > point2: btn5 <= sub;
//					pos5 < point2: btn5 <= add;
//					default: btn5 <= zero;
//				endcase
//				*/
//				if (pos1 > point2) begin
//					btn1 <= sub;
//				end
//				else if (pos1 < point2) begin
//					btn1 <= add;
//				end
//				else begin
//					btn1 <= zero;
//				end
//				
//				if (pos2 > point2) begin
//					btn2 <= sub;
//				end
//				else if (pos2 < point2) begin
//					btn2 <= add;
//				end
//				else begin
//					btn2 <= zero;
//				end
//				
//				if (pos3 > point2) begin
//					btn3 <= add;
//				end
//				else if (pos3 < point2) begin
//					btn3 <= sub;
//				end
//				else begin
//					btn3 <= zero;
//				end
//				
//				if (pos4 > point2) begin
//					btn4 <= sub;
//				end
//				else if (pos4 < point2) begin
//					btn4 <= add;
//				end
//				else begin
//					btn4 <= zero;
//				end
//				
//				if (pos5 > point2) begin
//					btn5 <= sub;
//				end
//				else if (pos5 < point2) begin
//					btn5 <= add;
//				end
//				else begin
//					btn5 <= zero;
//				end
//				
//			end
//			
//			//Mov2
//			else begin 
//				/*
//				case (pos1)
//					pos1 > point1: btn1 <= sub;
//					pos1 < point1: btn1 <= add;
//					default: btn1 <= zero;
//				endcase
//				case (pos2)
//					pos2 > point1: btn2 <= sub;
//					pos2 < point1: btn2 <= add;
//					default: btn2 <= zero;
//				endcase
//				case (pos3)
//					pos3 > point1: btn3 <= sub;
//					pos3 < point1: btn3 <= add;
//					default: btn3 <= zero;
//				endcase
//				case (pos4)
//					pos4 > point1: btn4 <= sub;
//					pos4 < point1: btn4 <= add;
//					default: btn4 <= zero;
//				endcase
//				case (pos5)
//					pos5 > point1: btn5 <= sub;
//					pos5 < point1: btn5 <= add;
//					default: btn5 <= zero;
//				endcase
//				*/
//				
//				if (pos1 > point1) begin
//					btn1 <= sub;
//				end
//				else if (pos1 < point1) begin
//					btn1 <= add;
//				end
//				else begin
//					btn1 <= zero;
//				end
//				
//				if (pos2 > point1) begin
//					btn2 <= sub;
//				end
//				else if (pos2 < point1) begin
//					btn2 <= add;
//				end
//				else begin
//					btn2 <= zero;
//				end
//				
//				if (pos3 > point1) begin
//					btn3 <= sub;
//				end
//				else if (pos3 < point1) begin
//					btn3 <= add;
//				end
//				else begin
//					btn3 <= zero;
//				end
//				
//				if (pos4 > point1) begin
//					btn4 <= sub;
//				end
//				else if (pos4 < point1) begin
//					btn4 <= add;
//				end
//				else begin
//					btn4 <= zero;
//				end
//				
//				if (pos5 > point1) begin
//					btn5 <= sub;
//				end
//				else if (pos5 < point1) begin
//					btn5 <= add;
//				end
//				else begin
//					btn5 <= zero;
//				end 
//				
//			end
//		end
//		
//		//sw=0
//		else begin 
//			
//			btn1 <= zero;
//			btn2 <= zero;
//			btn3 <= zero;
//			btn4 <= zero;
//			btn5 <= zero;
//		end
//
//	
//	end
	 

endmodule