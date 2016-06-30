`timescale 1ns / 1ps
`default_nettype none

module ROM_mapeo_distancia(distancia, distancia_mapeada);

input [8:0] distancia;
output reg [7:0] distancia_mapeada;

reg [7:0] Mem[10:0];

always @ (distancia)
begin


Mem[0] = 0; //5cm
Mem[1] = 26; //6 cm
Mem[2] = 51; //7 cm
Mem[3] = 77; //8cm
Mem[4] = 102; //9cm
Mem[5] = 128; //10cm
Mem[6] = 153; //11cm
Mem[7] = 179; //12 cm
Mem[8] = 204; //13 cm
Mem[9] = 230; //14 cm
Mem[10] = 255; //15cm




distancia_mapeada = Mem[distancia];
end

endmodule
