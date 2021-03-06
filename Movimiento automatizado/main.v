`timescale 1ns / 1ps

module main(
	input sw,
	input clk,
	
	output servo1,
	output servo2,
	output servo3,
	output servo4,
	output servo5
    );	
		

		wire [1:0] btn1;
		wire [1:0] btn2;
		wire [1:0] btn3;
		wire [1:0] btn4;
		wire [1:0] btn5;
		
		wire [7:0] pos1;
		wire [7:0] pos2;
		wire [7:0] pos3;
		wire [7:0] pos4;
		wire [7:0] pos5;
		
		
		/*
		clockDivider clockDivider (
		.clock(clock),
			
		.clk(clk)
		);
		*/
		
		servo_controller servo_controller1(
			.clk(clk),
			.btn(btn1),

			.pos(pos1),
			.servo_pulse(servo1)
		);

		servo_controller servo_controller2(
			.clk(clk),
			.btn(btn2),

			.pos(pos2),
			.servo_pulse(servo2)
		);

		servo_controller servo_controller3(
			.clk(clk),
			.btn(btn3),
			
			.pos(pos3),
			.servo_pulse(servo3)
		);

		servo_controller servo_controller4(
			.clk(clk),
			.btn(btn4),

			.pos(pos4),
			.servo_pulse(servo4)
		);

		servo_controller servo_controller5(
			.clk(clk),
			.btn(btn5),
			
			.pos(pos5),
			.servo_pulse(servo5)
		);
		
		serial_mov serial_mov(
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



endmodule
