module riscv_alu(
                    input [3:0] alu_control,
                    input [31:0] a,
                    input [31:0] b, 
                    output reg [31:0] out 
);

'include "defs.v"
