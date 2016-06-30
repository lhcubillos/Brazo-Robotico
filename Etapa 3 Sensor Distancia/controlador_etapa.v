`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:48 06/29/2016 
// Design Name: 
// Module Name:    controlador_etapa 
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
module controlador_etapa(
		input [8:0] distancia, //falta hacer alguna transformacion
		input clk,
		input canal_serial_receptor,
		
		output [13:0] decimal,
		output canal_serial_transmisor,
		output [7:0] ang_servo_1,
		output [7:0] ang_servo_2,
		output [7:0] ang_servo_3,
		output [7:0] ang_servo_4,
		output [7:0] ang_servo_5
    );
	 
	 wire [7:0] recepcion_ang_2, recepcion_ang_3, recepcion_ang_4;
	 
	 wire [8:0] distancia_para_mapear;
	 wire [7:0] distancia_mapeada;
	 
	 assign distancia_para_mapear = (distancia >= 5) ?  distancia - 5: 0;
	 
	 parameter x5cm = 0, z5cm = 110, x0cm = 0, z0cm = 0, y0cm = 0;
	 
	 parameter xpunto = 127;
	 wire [7:0] ypunto;
	 
	 parameter tiempo_espera = 1000000;
	 parameter limite_distancia_superior = 14;
	 parameter limite_distancia_inferior = 4;
	 
	 parameter BUSCANDO_SUBIENDO = 0, BUSCANDO_BAJANDO = 1, PESCANDO_OBJETO = 2, LEVANTANDO_OBJETO = 3,DEJANDO_OBJETO = 4, IDLE = 5;

	 
	 //Ver bien qué valores tienen que tener.
	 reg [7:0] x, y, z;
	 
	 
	 reg [25:0] cont_x, cont_y;
	 
	 reg [7:0] cont_angulo_y;
	 reg [25:0] cont_divider;
	 assign ang_servo_1 = cont_angulo_y;
	 assign ang_servo_2 = recepcion_ang_2;
	 assign ang_servo_3 = recepcion_ang_3;
	 assign ang_servo_4 = recepcion_ang_4;
	 assign ang_servo_5 = 128;
	 
	 assign ypunto = cont_angulo_y > 128 ? 64 : 192;
	 
	 wire clk_div_transmisor;
	 wire clk_div_receptor;
	 
	 reg [3:0] state;
	 
	 assign decimal = state;
	 
	 initial begin
		x = 0;
		y = 0;
		z = 90;
		
		state = BUSCANDO_SUBIENDO;
		
		cont_divider = 0;
		cont_angulo_y = 0;
		
		cont_x = 0;
		cont_y = 0;
	 end
	 
	 receptor_serial receptor_serial(
			.clk(clk_div_receptor),
			.canal_serial(canal_serial_receptor),
			
			//.angulo_servo_1(recepcion_ang_1),
			.angulo_servo_2(recepcion_ang_2),
			.angulo_servo_3(recepcion_ang_3),
			.angulo_servo_4(recepcion_ang_4)
		//.decimal(decimal)
		);
	
	transmisor_serial transmisor_serial(
		 .clk(clk_div_transmisor),
		 .x(x),
		 .y(y),
		 .z(z),
		
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
		
		ROM_mapeo_distancia ROM_mapeo_distancia(
			.distancia(distancia_para_mapear),
			.distancia_mapeada(distancia_mapeada)
			
		);
	 
	 
	 always @(posedge clk) begin
		case(state)
			BUSCANDO_SUBIENDO: begin
				cont_divider = cont_divider + 1;
				if (distancia <= limite_distancia_superior && distancia >= limite_distancia_inferior) begin
					state = PESCANDO_OBJETO;
					x = distancia_mapeada;
				end
				else if (cont_divider == tiempo_espera) begin
					cont_divider = 0;
					cont_angulo_y = cont_angulo_y + 1;
					if (cont_angulo_y == 255) state = BUSCANDO_BAJANDO;
				end
			end
			
			BUSCANDO_BAJANDO: begin
				cont_divider = cont_divider + 1;
				if (distancia <= limite_distancia_superior && distancia >= limite_distancia_inferior) begin
					state = PESCANDO_OBJETO;
					x = distancia_mapeada;
				end
				else if (cont_divider == tiempo_espera) begin
					cont_divider = 0;
					cont_angulo_y = cont_angulo_y - 1;
					if (cont_angulo_y == 0) state = BUSCANDO_SUBIENDO;
				end
			end
			
			PESCANDO_OBJETO: begin
				//Llegar a (distancia, 0 , 0)
				if (cont_x == tiempo_espera) begin
					cont_x = 0;
					if (x == distancia_mapeada) begin
						if (z == z0cm) begin
							//Apretar gripper
							state = LEVANTANDO_OBJETO;
						end else z = z - 1;
					end else x = x + 1;
				end else cont_x = cont_x + 1;
			end
			
			LEVANTANDO_OBJETO: begin
				//Llegar a (5, 0 , 5)
				if (cont_x == tiempo_espera) begin
					cont_x = 0;
					if (z == z5cm) begin
						if (x == x5cm) begin
							state = DEJANDO_OBJETO;
						end else x = x - 1;
					end else z = z + 1;
				end else cont_x = cont_x + 1;
			end
			
			DEJANDO_OBJETO: begin
				//llegar a otro punto especifico.
				if (cont_x == tiempo_espera) begin
					if (x == xpunto) begin
						//if (cont_angulo_y == ypunto) begin
//							if (z == z0cm) begin
//								//abrir gripper
								state = IDLE;
//							end else z = z - 1;
						//end else if (cont_angulo_y < ypunto) cont_angulo_y = cont_angulo_y + 1;
						//else cont_angulo_y = cont_angulo_y - 1;
					end else if (x < xpunto) x = x + 1;
					else x = x -1;
				end else cont_x = cont_x + 1;
			end
			
			IDLE: begin
				//Llegar a (5,0,5)
				if (cont_x == tiempo_espera) begin
					cont_x = 0;
					if (z == z5cm) begin
						if (x == x5cm) begin
							z = 90;
							state = BUSCANDO_SUBIENDO;
						end else x = x - 1;
					end else z = z + 1;
				end else cont_x = cont_x + 1;
			end
		endcase
	 end


endmodule
