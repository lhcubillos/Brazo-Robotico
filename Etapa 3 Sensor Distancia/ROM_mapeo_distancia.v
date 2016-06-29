`timescale 1ns / 1ps
`default_nettype none

module ROM_mapeo_distancia(distancia, distancia_mapeada);

input [8:0] distancia;
output reg [7:0] distancia_mapeada;

reg [7:0] Mem[10:0];

always @ (address)
begin


Mem[0] = 0;
Mem[1] = 26;
Mem[2] = 51;
Mem[3] = 77;
Mem[4] = 102;
Mem[5] = 128;
Mem[6] = 153;
Mem[7] = 179;
Mem[8] = 204;
Mem[9] = 230;
Mem[10] = 255;




distancia_mapeada = Mem[distancia];
end

endmodule
