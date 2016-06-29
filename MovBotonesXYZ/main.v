module main(
	input [1:0] btn,
	input [5:0] sw,
	input clk,
	input canal_serial_receptor,

	
	output [7:0] seg,
	output [3:0] an,
	output servo1,
	output servo2,
	output servo3,
	output servo4,
	output [2:0] leds,
	//output servo5,
	output canal_serial_transmisor
    );
		
		wire [7:0] ang_servo_1;
		wire [7:0] ang_servo_2;
		wire [7:0] ang_servo_3;
		wire [7:0] ang_servo_4;

		wire clk_div_transmisor;
		wire clk_div_receptor;
	 
		wire [1:0] btnOut;
		wire [1:0] btnX;
		wire [1:0] btnY;
		wire [1:0] btnZ;
		wire [1:0] btnG;
		
		wire [7:0] dx; //contador posicionamiento en X
		wire [7:0] dy;
		wire [7:0] dz;
		wire [7:0] dg;
		wire [7:0] pos_out;

		assign btnX = sw[0] ? btnOut: 2'b0;
		assign btnY = sw[1] ? btnOut: 2'b0;
		assign btnZ = sw[2] ? btnOut: 2'b0;
		assign btnG = sw[3] ? btnOut: 2'b0;
		
		assign pos_out = sw[0] ? dx:
								(sw[1] ? dy :
								(sw[2] ? dz :
								(sw[3] ? dg : 0)));
		wire [7:0] decimal;
		
		assign decimal = sw[5] ? (sw[4] ? ang_servo_4: ang_servo_3): (sw[4] ? ang_servo_2:ang_servo_1);
		
		SevenSeg SevenSeg(
		.clk(clk),
		.decimal(decimal),
		
		.an(an),
		.seg(seg)
		);
				
		debouncers debounce (
		.clk(clk),
		.btnIn(btn),
		.btnOut(btnOut)
		);
		
		coords_controller coords_controller (
			.clk(clk),
			.btnX(btnX),
			.btnY(btnY),
			.btnZ(btnZ),
			.btnG(btnG),
			
			.dx(dx),
			.dy(dy),
			.dz(dz),
			.dg(dg)
		);
		
		receptor_serial receptor_serial(
			.clk(clk_div_receptor),
			.canal_serial(canal_serial_receptor),
			
			.state(leds[2:0]),
			.angulo_servo_1(ang_servo_1),
			.angulo_servo_2(ang_servo_2),
			.angulo_servo_3(ang_servo_3),
			.angulo_servo_4(ang_servo_4)
		//.decimal(decimal)
		);
	
		transmisor_serial transmisor_serial(
		 .clk(clk_div_transmisor),
		 .x(dx),
		 .y(dy),
		 .z(dz),
		
		.canal_serial(canal_serial_transmisor)
		
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
		
		servo_pwm servo_1(
			.pos(ang_servo_1),
			.clk(clk),
			
			.servo_pulse(servo1)
		);
		
		servo_pwm servo_2(
			.pos(ang_servo_2),
			.clk(clk),
			
			.servo_pulse(servo2)
		);
		servo_pwm servo_3(
			.pos(ang_servo_3),
			.clk(clk),
			
			.servo_pulse(servo3)
		);
		
		servo_pwm servo_4(
			.pos(ang_servo_4),
			.clk(clk),
			
			.servo_pulse(servo4)
		);
		
		

endmodule
