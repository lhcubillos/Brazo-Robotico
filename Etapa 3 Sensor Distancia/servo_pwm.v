`timescale 1ns / 1ps

module servo_pwm(
  input [7:0] pos,
  input clk, //50MHz

  output reg [7:0] servo_pulse
    );

  //asumimos que el clk es de 50MHz --> periodo de 20ns
  parameter ClkDiv = 195;    // 3900ns/20ns = 195
  parameter init = 12'b000010001100; //140

  reg [7:0] ClkCount; //8 bits to reach 195
  reg ClkTick;
  reg [12:0] PulseCount;
  
  reg [11:0] count;
  initial count = init;

  always @(posedge clk) ClkTick <= (ClkCount==ClkDiv-2);
  always @(posedge clk) if(ClkTick) ClkCount <= 0; else ClkCount <= ClkCount + 1;
  //always @(posedge clk) if(ClkTick) PulseCount <= PulseCount + 1;
	
  always @(posedge clk) begin
	if(ClkTick) begin
		PulseCount <= PulseCount + 1;
		if (PulseCount == 5128) begin //5128
			PulseCount <= 0;
		end
	end
  end
  

  always @(posedge clk) begin
	count = init +  {4'b0000, pos} +  {4'b0000, pos} ;//- 12'b000000100000;
	servo_pulse = (PulseCount < count);
	//servo_pulse = (PulseCount < {4'b0001, pos});
  end

endmodule
