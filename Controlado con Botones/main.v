module main(
	input [1:0] btn,
	input [4:0] sw,
	input clk,
	
	output [7:0] seg,
	output [3:0] an,
	//output clock2,
	output servo1,
	output servo2,
	output servo3,
	output servo4,
	output servo5
    );
		//wire clk;
		
		//assign clock2 = clk;
		
		
		
		wire [1:0] btnOut;
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
		wire [7:0] pos_out;

		assign btn1 = sw[0] ? btnOut: 2'b0;
		assign btn2 = sw[1] ? btnOut: 2'b0;
		assign btn3 = sw[2] ? btnOut: 2'b0;
		assign btn4 = sw[3] ? btnOut: 2'b0;
		assign btn5 = sw[4] ? btnOut: 2'b0;
		
		assign pos_out = sw[0] ? pos1:
								(sw[1] ? pos2 :
								(sw[2] ? pos3 :
								(sw[3] ? pos4 :
								(sw[4] ? pos5 :
								0))));
		
		
		/*
		clockDivider clockDivider (
		.clock(clock),
			
		.clk(clk)
		);
		*/
		
		SevenSeg SevenSeg(
		.clk(clk),
		.decimal(pos_out),
		
		.an(an),
		.seg(seg)
		);
		
		
		
		debouncers debounce (
		.clk(clk),
		.btnIn(btn),
		.btnOut(btnOut)
		);
		
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



endmodule
