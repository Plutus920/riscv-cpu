//inputs a, b operands, alu opcode, output
module riscv_alu(  
                    input [3:0] opcode, 
                    input [31:0] a,
                    input [31:0] b,
                    output reg [31:0] out);

`include "defs.v"

//control signals for shifter
reg shift_dir; 
reg shift_arith; 

//shifter output
wire [31:0] shift_result;


barrel_shifter shifter_inst( .in(a),
                            .n(b[4:0]),
                            .dir(shift_dir),
                            .arith(shift_arith),
                            .out(shift_result)
                            );

always @(opcode or a or b) begin 

    out = 32'b0; 
    shift_dir = 1'b0;
    shift_arith = 1'b0;


    case (opcode)

    `ALU_ADD: out = (a + b);

    `ALU_SUB: out = (a-b);

    `ALU_AND: out = (a&b);
    
    `ALU_OR: out = (a|b);

    `ALU_XOR: out =  (a^b);

    `ALU_SHIFTL: begin 
        shift_dir = 1'b0;   //left shift 
        shift_arith = 0;
        out = shift_result;
    end 

    `ALU_SHIFTR: begin
        shift_dir = 1'b1;   //right shiift - logical 
        shift_arith = 0; 
        out = shift_result;
    end

    `ALU_SHIFTR_ARITH: begin 
        shift_dir = 1'b1;   //right shift - arithmetic
        shift_arith = 1'b1; 
        out = shift_result;
    end 

    default: out = 32'b0; 
    endcase 
end
endmodule