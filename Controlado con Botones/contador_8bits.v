module contador_8bits(
  input cnt_up,
  input cnt_down,
  input clk,
  //input rst,

  output reg [7:0] pos
    );
	
	/*	
	reg activador1;
	reg activador2;
	initial activador1 = 1;
	initial activador2 = 1;
	*/

  always @(posedge clk) begin
    //if (rst) begin
    //  pos <= 8'b0;
    //end
    
	 /*
	 if (cnt_up && activador1) begin
		if (pos < 255) begin
			activador1 <= 0;
			pos <= pos + 1;
		end
    end
    else if (cnt_down && activador2) begin
		if (pos > 0) begin
			activador2 <= 0;
			pos <= pos - 1;
		end
    end
	 else if (cnt_up == 0) begin
		activador1 <= 1;
	 end
	 else if (cnt_down == 0) begin
		activador2 <= 1;
	 end
	 */
	 if (cnt_up && pos < 255) begin
		pos <= pos + 1;
    end
    else if (cnt_down && pos > 0) begin
		pos <= pos - 1;
    end
	 
  end
  


endmodule
