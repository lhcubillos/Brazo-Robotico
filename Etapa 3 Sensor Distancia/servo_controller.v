`timescale 1ns / 1ps

module servo_controller(
	input clk, //25 MHz
	input [1:0] btn,

	output [7:0] pos,
	output servo_pulse
    );

		wire [7:0] servo_pos;
		wire adder;
		wire substractor;
		wire new_clk;
		parameter uno = 1;
		
		assign pos = servo_pos;

		btn_controller btn_controller(
			.clk(clk),
			.btn(btn),

			.add(adder),
			.sub(substractor)
		);

		contador_8bits contador_8bits (
		  .cnt_up(adder),
		  .cnt_down(substractor),
		  .clk(new_clk),
		  //.rst(0),

		  .pos(servo_pos) //8bits
		);

//		nuevo_contador_8_bits contador_8bits (
//		  .btn_up(btn[0]),
//		  .btn_down(btn[1]),
//		  .clk(adder),
//		  //.rst(0),
//
//		  .pos(servo_pos) //8bits
//		);

		servo_pwm servo_pwm (
			.pos(servo_pos), //8bits
			.clk(clk),

			.servo_pulse(servo_pulse)
		);
		
		btn_clk_divider btn_clk_dividerP (
		.clk(clk),
		.enable(uno),

		.out(new_clk)
		);


endmodule
