`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:31 06/26/2016 
// Design Name: 
// Module Name:    receptor_serial 
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
module receptor_serial(
		input clk,
		input canal_serial,
		
		output reg [7:0] angulo_servo_1,
		output reg [7:0] angulo_servo_2,
		output reg [7:0] angulo_servo_3,
		output reg [7:0] angulo_servo_4,
		
		output reg [2:0] state,
		
		output [13:0] decimal
		
    );
	 
	 reg [7:0] inicio_transmision;
	 reg [5:0] cont_data;
	 
	 reg [6:0] cont_nivelacion;
	 reg [5:0] cont_50;
	 
	 reg [1:0] cont_servo;
	 
	 reg [7:0] data1;
	 reg [7:0] data2;
	 reg [7:0] data3;
	 reg [7:0] data4;
	 
	 reg [31:0] data;
	 
	 reg listo;
	 //reg [2:0] state;
	 
	 parameter STAND_BY = 3'b000, LEVELING_CLOCK = 3'b011, RECEIVING = 3'b001;
	 parameter ciclo = 10;
	 parameter nivelacion = 14;
	 
	 parameter num_datos = 8;
	 
	 initial begin
		state = STAND_BY;
		cont_data = 0;
		data1 = 0;
		cont_nivelacion = 1;
		cont_50 =ciclo;
		listo = 0;
		cont_servo =0;
		
		angulo_servo_1 = 0;
		angulo_servo_2 = 0;
		angulo_servo_3 = 0;
		angulo_servo_4 = 0;
	 end
	 
	 always @(posedge clk) begin
		 if (listo) begin
			case(cont_servo)
				1: angulo_servo_1 = data[7:0];
				2: angulo_servo_2 = data[7:0];
				3: angulo_servo_3 = data[7:0];
				0: angulo_servo_4 = data[7:0];
			endcase
		 end
		 
		 case(state)
			STAND_BY: begin
				if (!canal_serial) state = LEVELING_CLOCK;
			end
			
			LEVELING_CLOCK: begin
				if (cont_nivelacion == nivelacion) begin
					state = RECEIVING;
					cont_nivelacion = 1;
					cont_50 = ciclo;
				end else cont_nivelacion = cont_nivelacion + 1;
			end	
			
			RECEIVING: begin
				if (cont_50 == ciclo) begin
					cont_50 = 1;
//					if (cont_data == num_datos) begin
//						state = STAND_BY;
//						cont_data = 0;
//						listo = 1;
//					end //else 
					if (cont_data == num_datos) begin//8 || cont_data == 16 || cont_data == 24) begin
						cont_servo = cont_servo + 1;
						state = STAND_BY;
						listo = 1;
						cont_data = 0;
					end else if (cont_data < num_datos) begin
						listo = 0;
						data[cont_data] = canal_serial;
						cont_data = cont_data + 1;
					end  
				end else cont_50 = cont_50 + 1;

			end

		 endcase

	 end
	 
	


endmodule
