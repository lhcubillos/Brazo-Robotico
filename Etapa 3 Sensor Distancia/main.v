`timescale 1ns / 1ps

module main(
	input sw,
	input sw2,
	input clk,
	input echo,
	input canal_serial_receptor,
	
	output canal_serial_transmisor,
	output servo1,
	output servo2,
	output servo3,
	output servo4,
	output servo5,
	output [7:0] leds,
	output trig,
	output [7:0] seg,
	output [3:0] an
    );	
		

		wire [1:0] bn1;
		wire [1:0] btn2;
		wire [1:0] btn3;
		wire [1:0] btn4;
		wire [1:0] btn5;
		
		wire [7:0] pos1;
		wire [7:0] pos2;
		wire [7:0] pos3;
		wire [7:0] pos4;
		wire [7:0] pos5;
		
		wire [8:0] distancia;
		wire [13:0] decimal;
		
		
		wire [2:0] state;
		
		wire [7:0] ang_servo_1;
		wire [7:0] ang_servo_2;
		wire [7:0] ang_servo_3;
		wire [7:0] ang_servo_4;
		wire [7:0] ang_servo_5;
		
		assign leds = decimal[7:0];
		
		/*
		clockDivider clockDivider (
		.clock(clock),
			
		.clk(clk)
		);
		*/
		
		servo_pwm servo_pwm1 (
			.pos(ang_servo_1), //8bits
			.clk(clk),

			.servo_pulse(servo1)
		);
		servo_pwm servo_pwm2(
			.pos(ang_servo_2), //8bits
			.clk(clk),

			.servo_pulse(servo2)
		);
		servo_pwm servo_pwm3 (
			.pos(ang_servo_3), //8bits
			.clk(clk),

			.servo_pulse(servo3)
		);
		servo_pwm servo_pwm4 (
			.pos(ang_servo_4), //8bits
			.clk(clk),

			.servo_pulse(servo4)
		);
		servo_pwm servo_pwm5 (
			.pos(ang_servo_5), //8bits
			.clk(clk),

			.servo_pulse(servo5)
		);
		
		controlador_sensor_distancia controlador_sensor_distancia(
			.echo(echo),
			.clk(clk),
			
			.distancia(distancia),
			.trig(trig)
			//.state(leds[5:4])
			//.decimal(decimal)
		);
		
		controlador_etapa controlador_etapa(
			.distancia(distancia),
			.clk(clk),
			.canal_serial_receptor(canal_serial_receptor),
			
			.decimal(decimal),
			.canal_serial_transmisor(canal_serial_transmisor),
			.ang_servo_1(ang_servo_1),
			.ang_servo_2(ang_servo_2),
			.ang_servo_3(ang_servo_3),
			.ang_servo_4(ang_servo_4),
			.ang_servo_5(ang_servo_5)
		);
		
		
		SevenSeg SevenSeg(
			.clk(clk),
			.decimal(distancia),
			
			.an(an),
			.seg(seg)
			);
		


endmodule
