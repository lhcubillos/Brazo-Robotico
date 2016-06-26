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
		output reg [8:0] distancia,
		output reg timeout,
		output reg [1:0] state,
		output [13:0] decimal
    );
	 
	 parameter ENVIANDO_PULSO = 2'b00, RECIBIENDO_PULSO = 2'b01, ESPERANDO_PULSO = 2'b10, EN_ESPERA = 2'b11;
	 parameter tiempo10us = 500, TIMEOUT = 5000000;
	 reg [30:0] contador_10us;
	 reg [30:0] contador_echo;
	 reg [23:0] contador_en_espera;
	 //reg [1:0] state;
	 reg [8:0] distancia_temporal;
	 reg [30:0] contador_timeout;
	 
	 reg [23:0] contador_extra;
	 
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
			else begin
				distancia = distancia_temporal - 1;
				distancia_temporal = 0;
				contador_echo = 0;
				contador_en_espera = 0;
				state = ENVIANDO_PULSO;
			end
		end
	end
	
	assign decimal = distancia;

endmodule
