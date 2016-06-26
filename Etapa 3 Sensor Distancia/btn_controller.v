`timescale 1ns / 1ps

module btn_controller(
	input clk, //25 MHz
	input [1:0] btn,

	output add, //128 Hz
	output sub //128 Hz
    );

		btn_clk_divider btn_clk_divider1 (
		.clk(clk),
		.enable(btn[0]),

		.out(add)
		);

		btn_clk_divider btn_clk_divider2 (
		.clk(clk),
		.enable(btn[1]),

		.out(sub)
		);


endmodule
