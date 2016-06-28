module servo_controller(
	input clk, //25 MHz
	input [1:0] btn,

	output [7:0] pos,
	output servo_pulse
    );

		wire [7:0] servo_pos;
		wire new_clk;
		parameter uno = 1;
		
		assign pos = servo_pos;

		contador_8bits contador_8bits (
		  .cnt_up(btn[0]),
		  .cnt_down(btn[1]),
		  .clk(new_clk),
		  //.rst(0),

		  .pos(servo_pos) //8bits
		);

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
