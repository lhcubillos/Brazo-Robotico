module debouncers(
		input clk,
		input [1:0] btnIn,
		output [1:0] btnOut
    );

	 	debouncer debouncer0(
			.PB(btnIn[0]),
			.clk(clk),
			.PB_state(btnOut[0])
		);

		debouncer debouncer1(
			.PB(btnIn[1]),
			.clk(clk),
			.PB_state(btnOut[1])
		);


endmodule
