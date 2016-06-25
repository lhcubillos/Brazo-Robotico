`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:17:38 06/24/2016
// Design Name:   serial_mov
// Module Name:   C:/Users/Vicente/Desktop/Lab Digitales/Proyecto2/tb_serial_mov.v
// Project Name:  Proyecto2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: serial_mov
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_serial_mov;

	// Inputs
	reg sw;
	reg clk;
	reg [7:0] pos1;
	reg [7:0] pos2;
	reg [7:0] pos3;
	reg [7:0] pos4;
	reg [7:0] pos5;

	// Outputs
	wire [1:0] btn1;
	wire [1:0] btn2;
	wire [1:0] btn3;
	wire [1:0] btn4;
	wire [1:0] btn5;

	// Instantiate the Unit Under Test (UUT)
	serial_mov uut (
		.sw(sw), 
		.clk(clk), 
		.pos1(pos1), 
		.pos2(pos2), 
		.pos3(pos3), 
		.pos4(pos4), 
		.pos5(pos5), 
		.btn1(btn1), 
		.btn2(btn2), 
		.btn3(btn3), 
		.btn4(btn4), 
		.btn5(btn5)
	);

	initial begin
		// Initialize Inputs
		sw = 0;
		clk = 0;
		pos1 = 8'b01000000;
		pos2 = 8'b01000000;
		pos3 = 8'b01000000;
		pos4 = 8'b01000000;
		pos5 = 8'b01000000;

		// Wait 100 ns for global reset to finish
		#100;
      clk = 1; 
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		clk = 1;
		#50;
		clk = 0;
		#50;
		// Add stimulus here

	end
	
	initial begin
		$monitor("clk = %d, pos1 = %b, btn1 = %b",clk,pos1[7:0],btn1[1:0]);
	end
	
      
endmodule

