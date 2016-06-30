`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:02:07 06/25/2016 
// Design Name: 
// Module Name:    controlador_sensor_distancia 
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
module controlador_sensor_distancia(
		input echo,
		input clk,
		
		output reg trig,
		output reg [18:0] distancia,
		output reg timeout,
		output reg [2:0] state,
		output [13:0] decimal
    );
	 
	 parameter ENVIANDO_PULSO = 0, RECIBIENDO_PULSO = 1, ESPERANDO_PULSO = 2, EN_ESPERA = 3, DELAY= 4;
	 parameter tiempo10us = 500, TIMEOUT = 500000;
	 reg [35:0] contador_10us;
	 reg [35:0] contador_echo;
	 reg [35:0] contador_en_espera;
	 //reg [1:0] state;
	 reg [18:0] distancia_temporal;
	 reg [30:0] contador_timeout;
	 
	 reg [5:0] cont_distancias;
	 reg [32:0] suma_distancias;
	 
	 reg [23:0] contador_extra;
	 
	 reg [30:0] cont_delay;
	 
	 reg [31:0] distancias_anteriores[18:0];
	 
	 
	 initial begin
		state = ENVIANDO_PULSO;
		contador_10us = 0;
		contador_echo = 0;
		contador_en_espera = 0;
		trig = 0;
		contador_timeout = 0;
	 end
//	 
	 always @(posedge clk) begin
		if (state == ENVIANDO_PULSO) begin
			//distancia_temporal <= 0;
			trig = 1;
			contador_10us = contador_10us + 1;
			if (contador_10us >= tiempo10us) begin
				trig = 0;
				contador_10us = 0;
				contador_timeout = 0;
				state = ESPERANDO_PULSO;
			end
		end else if (state == ESPERANDO_PULSO) begin
			contador_timeout = contador_timeout + 1;
			if (echo) begin
				state = RECIBIENDO_PULSO;
				contador_echo = 0;
			end else if (contador_timeout >= TIMEOUT) begin
				state = ENVIANDO_PULSO;
			end 
		end else if (state == RECIBIENDO_PULSO) begin
			contador_echo = contador_echo + 1;
			if (!echo) begin
				state = EN_ESPERA;
				contador_en_espera = 0;
			end
		end else if (state == EN_ESPERA) begin
			//División contando.
			if(contador_en_espera < contador_echo) begin
				contador_en_espera = contador_en_espera + 2900; //2900 = 50ciclos*58 para dejarlo en centimetros
				distancia_temporal = distancia_temporal + 1;
			end
			else if (distancia_temporal < 35 && distancia_temporal >4) begin
				distancias_anteriores[0] = distancias_anteriores[1];
				distancias_anteriores[1] = distancias_anteriores[2];
				distancias_anteriores[2] = distancias_anteriores[3];
				distancias_anteriores[3] = distancias_anteriores[4];
				distancias_anteriores[4] = distancia_temporal - 1;
				
//				if (distancias_anteriores[1] > distancias_anteriores[0] &&
//					distancias_anteriores[1] - distancias_anteriores[0] <=3) begin
//					distancias_anteriores[1] = distancia_temporal - 1;
//					distancia = distancias_anteriores[1]; 	
//				end else if (distancias_anteriores[1] <= distancias_anteriores[0] &&
//					distancias_anteriores[0] - distancias_anteriores[1] <=3) begin
//					distancias_anteriores[1] = distancia_temporal - 1;
//					distancia = distancias_anteriores[1];
//				end
//				
				if (distancias_anteriores[0] == distancias_anteriores[1] && 
					distancias_anteriores[1] == distancias_anteriores[2] && 
					distancias_anteriores[2] == distancias_anteriores[3] && 
					distancias_anteriores[3] == distancias_anteriores[4]) begin
					distancia = distancias_anteriores[4];
				end		

				distancia_temporal = 0;
				contador_echo = 0;
				contador_en_espera = 0;
				state = DELAY;
				
				
//				if (cont_distancias == 16) begin
//					distancia = suma_distancias >> 4;
//					suma_distancias = 0;
//					cont_distancias = 0;
//					distancia_temporal = 0;
//					contador_echo = 0;
//					contador_en_espera = 0;
//					state = ENVIANDO_PULSO;
//					
//				end else begin
//					suma_distancias = suma_distancias + distancia_temporal - 1;
//					cont_distancias = cont_distancias + 1;
//					distancia_temporal = 0;
//					contador_echo = 0;
//					contador_en_espera = 0;
//					state = ENVIANDO_PULSO;
//				end
				
//				distancia = distancia_temporal - 1;
//				distancia_temporal = 0;
//				contador_echo = 0;
//				contador_en_espera = 0;
//				state = DELAY;
				
			end else begin
				distancia_temporal = 0;
				contador_echo = 0;
				contador_en_espera = 0;
				state = DELAY;
			end
		end
		
		else if (state == DELAY) begin
			if (cont_delay == 500000) begin
				state = ENVIANDO_PULSO;
				cont_delay = 0;
			end else cont_delay = cont_delay + 1;
		end
	end
	
	assign decimal = distancia;

endmodule