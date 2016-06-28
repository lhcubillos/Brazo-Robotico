module btn_clk_divider(
	input clk, //50 MHz
	input enable,

	output reg out //128 Hz
    );

		parameter cfinal = 390625; //ciclos de clk 50MHz para alcanzar la mitad del periodo de 128 Hz
		reg [18:0] count;
		initial count = 0;

		always @(posedge(clk)) begin
			if (enable) begin
				if (count == cfinal - 1) begin
					count <= 19'b0;
					out <= ~out;
				end
				else begin
					count <= count + 1;
					out <= out;
				end
			end
			else begin
				count <= 0;
				out <= 0;
			end
		end


endmodule 