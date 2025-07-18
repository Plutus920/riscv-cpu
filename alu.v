//inputs a, b operands, alu opcode, output
module riscv_alu(  
                    input [3:0] opcode, 
                    input [31:0] a,
                    input [31:0] b,
                    output reg [31:0] out);

`include "defs.v"

always @(opcode or a or b) begin 
     
    case (opcode)

    ALU_ADD: out = (a + b);

    ALU_SUB: out = (a-b);

    ALU_AND: out = (a&b);
    
    ALU_OR: out = (a|b);

    ALU_XOR: out =  (a^b);

    ALU_SHIFTL: 

