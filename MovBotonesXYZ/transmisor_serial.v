`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:30 06/26/2016 
// Design Name: 
// Module Name:    transmisor_serial 
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
module transmisor_serial(
		input clk, //25kHz
		input [7:0] x,
		input [7:0] y,
		input [7:0] z,
		
		output reg canal_serial,
		
		output [13:0] decimal
    );
	 
	 reg [5:0] cont_data;
	 
	 reg [18:0] cont_delay;
	 reg state;
	 
	 wire [29:0] data;
	 //assign data = {1'b1,z,2'b01,y,2'b01,x,1'b0};
	 //assign data = {'b11111111111111111111,1'b1,z,1'b0,'b11111111111111111111,1'b1,y,1'b0,'b11111111111111111111,1'b1,x,1'b0};
	 //assign data = {'b11111111111111111111,1'b1,x,1'b0};
	 
	 //Sin delays entre medio
	 assign data = {1'b1,z,1'b0,1'b1,y,1'b0,1'b1,x,1'b0};
	 parameter IDLE = 1'b0, TR = 1'b1;
	 
	 initial begin 
		state = TR;
		cont_data = 0;
		canal_serial = 0;
	 end
	 
	 always @(posedge clk) begin
		case(state)
			TR: begin
				canal_serial = data[cont_data];
				cont_data = cont_data + 1;
				if (cont_data ==30) begin
					cont_data = 0;
					state = IDLE;
				end
			end
			
			IDLE: begin
				canal_serial = 1;
				cont_delay = cont_delay + 1;
				if (cont_delay == 3000) begin //Delay curioso
					state = TR;
					cont_delay = 0;
				end
			end
		endcase
			
	 end
	 
	 assign decimal = cont_data;


endmodule
