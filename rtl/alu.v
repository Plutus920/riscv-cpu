//inputs a, b operands, alu opcode, output

`include "defs.v"

module riscv_alu(  
                    input [3:0] opcode, 
                    input [31:0] a,
                    input [31:0] b,
                    output reg [31:0] out);


//control signals for shifter
wire shift_dir = (opcode == `ALU_SHIFTR || opcode == `ALU_SHIFTR_ARITH);
wire shift_arith = (opcode == `ALU_SHIFTR_ARITH); 

wire [31:0] shift_output;

barrel_shifter shifter_inst( .in(a),
                            .n(b[4:0]),
                            .dir(shift_dir),
                            .arith(shift_arith),
                            .out(shift_output)
                            );




always @(*) begin 

    out = 32'b0; 
  
    case (opcode)

    `ALU_ADD: out = (a + b);

    `ALU_SUB: out = (a-b);

    `ALU_AND: out = (a&b);
    
    `ALU_OR: out = (a|b);

    `ALU_XOR: out =  (a^b);

    `ALU_SHIFTL: out = shift_output; 

    `ALU_SHIFTR: out = shift_output; 

    `ALU_SHIFTR_ARITH: out = shift_output;

    default: out = 32'b0; 
    endcase 
end
endmodule