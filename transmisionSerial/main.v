`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:35 06/26/2016 
// Design Name: 
// Module Name:    main 
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
module main(
	input clk,
	input clk_transmision,
	input canal_serial,
	input sw,
	
	input [1:0] sw2,
	
	input [3:0] sw3,
	
	output [7:0] seg,
	output [3:0] an,
	output [4:0] leds,
	
	output canal_serial_transmision,
	output clk_div_transmisor
    );
	 
	 wire [7:0] ang_servo_1;
	 wire [7:0] ang_servo_2;
	 wire [7:0] ang_servo_3;
	 wire [7:0] ang_servo_4;
	 
	 //wire clk_div_transmisor;
	 wire clk_div_receptor;
	 
	 wire [13:0] decimal;
	 
	 wire [7:0] x;
	 //assign x = sw3;
	 
	 assign decimal = sw2[1] ? (sw2[0] ? ang_servo_4: ang_servo_3): (sw2[0] ? ang_servo_2:ang_servo_1);
	 assign leds[4] = canal_serial;

	SevenSeg SevenSeg(
		.clk(clk),
		.decimal(decimal),
		
		.an(an),
		.seg(seg)
		);
	receptor_serial receptor_serial(
		.clk(clk_div_receptor),
		.canal_serial(canal_serial),
		
		.state(leds[2:0]),
		.angulo_servo_1(ang_servo_1),
		.angulo_servo_2(ang_servo_2),
		.angulo_servo_3(ang_servo_3),
		.angulo_servo_4(ang_servo_4)
		//.decimal(decimal)
	);
	
	transmisor_serial transmisor_serial(
		 .clk(clk_div_transmisor),
		 .x(8'd255),
		 .y(8'd0),
		 .z(8'd105),
		
		.canal_serial(canal_serial_transmision)
		
		//.decimal(decimal)
    );

	
	clockDivider clockDivider_transmisor(
		.clock(clk),
		.constante(1000),
		.clk(clk_div_transmisor)
	);
	
	clockDivider clockDivider_receptor(
		.clock(clk),
		.constante(50),
		.clk(clk_div_receptor)
	);
endmodule
