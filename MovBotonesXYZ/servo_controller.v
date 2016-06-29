module servo_controller(
	input clk, 
	input [1:0] btn,

	output [7:0] pos,
	output servo_pulse
    );

		wire [7:0] servo_pos;
		
		assign pos = servo_pos;

		contador_8bits contador_8bits (
		  .cnt_up(btn[0]),
		  .cnt_down(btn[1]),
		  .clk(new_clk),

		  .pos(servo_pos) //8bits
		);

		servo_pwm servo_pwm (
			.pos(servo_pos), //8bits
			.clk(clk),

			.servo_pulse(servo_pulse)
		);


endmodule
