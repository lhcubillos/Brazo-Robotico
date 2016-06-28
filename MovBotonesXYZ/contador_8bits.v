module contador_8bits(
  input cnt_up,
  input cnt_down,
  input clk,

  output reg [7:0] pos
    );
	
	initial begin
		pos = 8'b10000000;
	end

  always @(posedge clk) begin
	 if (cnt_up && pos < 255) begin
		pos <= pos + 1;
    end
    else if (cnt_down && pos > 0) begin
		pos <= pos - 1;
    end
	 
  end
  


endmodule
