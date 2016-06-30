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
	
	parameter pos_gripper = 8'b10000000;
	
	//pointx_y -> x: estado, y: servo
	parameter point1_1 = 8'b01010101;
	parameter point1_2 = 8'b11010101;
	parameter point1_3 = 8'b01001110;
	parameter point1_4 = 8'b11011011;
	
	parameter point2_1 = 8'b01001100;
	parameter point2_2 = 8'b11011101;
	parameter point2_3 = 8'b00100000;
	parameter point2_4 = 8'b11111111;
	
	parameter point3_1 = 8'b10110010;
	parameter point3_2 = 8'b10110110;
	parameter point3_3 = 8'b10010110;
	parameter point3_4 = 8'b10000000;
	
	parameter point4_1 = 8'b10110010;
	parameter point4_2 = 8'b11001010;
	parameter point4_3 = 8'b11010001;
	parameter point4_4 = 8'b01111111;
	
	reg [7:0] point_s1;
	reg [7:0] point_s2;
	reg [7:0] point_s3;
	reg [7:0] point_s4;
	
	//reg [24:0] cont;
	//reg delay;
	
	reg [2:0] EST;
	initial begin
		//cont = 25'd0;
		//delay = 0;
		EST = 3'b000;
		point_s1 = point2_1;
		point_s2 = point2_2;
		point_s3 = point2_3;
		point_s4 = point2_4;
		btn1 = zero;
		btn2 = zero;
		btn3 = zero;
		btn4 = zero;
		btn5 = zero;
	end

	always @(posedge(clk)) begin
		if (sw) begin
			
//			if (cont == 25'b1111111111111111111111111) begin
//				delay = 0;
//			end
//
//			if (delay) begin
//				cont = cont + 25'd1;
//			end
//			else begin
			if (EST == 3'b001 && pos1 == point1_1 && pos2 == point1_2 && pos3 == point1_3 && pos4 == point1_4 && pos5 == pos_gripper) begin
				EST = 3'b010;
				//delay = 1;
			end
			else if (EST == 3'b000 && pos1 == point2_1 && pos2 == point2_2 && pos3 == point2_3 && pos4 == point2_4 && pos5 == pos_gripper) begin
				EST = 3'b001;
				//delay = 1;
			end
			else if (EST == 3'b010 && pos1 == point2_1 && pos2 == point2_2 && pos3 == point2_3 && pos4 == point2_4 && pos5 == pos_gripper) begin
				EST = 3'b011;
				//delay = 1;
			end
			else if (EST == 3'b011 && pos1 == point3_1 && pos2 == point3_2 && pos3 == point3_3 && pos4 == point3_4 && pos5 == pos_gripper) begin
				EST = 3'b100;
				//delay = 1;
			end
			else if (EST == 3'b101 && pos1 == point3_1 && pos2 == point3_2 && pos3 == point3_3 && pos4 == point3_4 && pos5 == pos_gripper) begin
				EST = 3'b000;
				//delay = 1;
			end
			else if (EST == 3'b100 && pos1 == point4_1 && pos2 == point4_2 && pos3 == point4_3 && pos4 == point4_4 && pos5 == pos_gripper) begin
				EST = 3'b101;
				//delay = 1;
			end
			else if (EST == 3'b110 || EST == 3'b111) begin
				EST = 3'b000;
			end
		
			if (EST == 3'b000 || EST == 3'b010) begin
				point_s1 = point2_1;
				point_s2 = point2_2;
				point_s3 = point2_3;
				point_s4 = point2_4;
			end
			else if (EST == 3'b001) begin
				point_s1 = point1_1;
				point_s2 = point1_2;
				point_s3 = point1_3;
				point_s4 = point1_4;
			end
			else if (EST == 3'b011 || EST == 3'b101) begin
				point_s1 = point3_1;
				point_s2 = point3_2;
				point_s3 = point3_3;
				point_s4 = point3_4;
			end
			else if (EST == 3'b100) begin
				point_s1 = point4_1;
				point_s2 = point4_2;
				point_s3 = point4_3;
				point_s4 = point4_4;
			end
			
			//ejecutar mov
			if (pos1 < point_s1) begin
				btn1 = add;
			end
			else if (pos1 > point_s1) begin
				btn1 = sub;
			end
			else begin
				btn1 = zero;
			end

			if (pos2 < point_s2) begin
				btn2 = add;
			end
			else if (pos2 > point_s2) begin
				btn2 = sub;
			end
			else begin
				btn2 = zero;
			end

			if (pos3 < point_s3) begin
				btn3 = add;
			end
			else if (pos3 > point_s3) begin
				btn3 = sub;
			end
			else begin
				btn3 = zero;
			end

			if (pos4 < point_s4) begin
				btn4 = add;
			end
			else if (pos4 > point_s4) begin
				btn4 = sub;
			end
			else begin
				btn4 = zero;
			end

			if (pos5 < pos_gripper) begin
				btn5 = add;
			end
			else if (pos5 > pos_gripper) begin
				btn5 = sub;
			end
			else begin
				btn5 = zero;
			end

//			end
		end
		else begin
			btn1 = zero;
			btn2 = zero;
			btn3 = zero;
			btn4 = zero;
			btn5 = zero;
		end
	
	end	 

endmodule