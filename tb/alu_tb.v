'include "defs.v"

module alu_tb();

//alu inputs
reg [3:0] opcode; 
reg [31:0] a; 
reg [31:0] b;

//alu output
wire out; 

riscv_alu DUT(  .opcode (opcode),
                .a (a),
                .b (b),
                .out (out));


task test_alu;
    input [3:0] op; 
    input [31:0] rs_a; 
    input [31:0] rs_b;
    input [31:0] expected; 

    opcode = op; 
    a = rs_a; 
    b = rs_b; 
    #1;

    begin

    if (out != expected_out)
        $display("FAIL: opcode=%b a=%h b=%h --> out=%h (expected = %h)", 
        op, rs_a, rs_b, expected);

    else
        $display("PASS: opcode=%b a=%h b=%h --> out=%h", op, rs_a, rs_b, out);
    end
endtask 

//simulation

initial begin 
    $display("ALU TEST BEGIN...");

    //arithmetic operations

    test_alu(`ALU_ADD, 32'd10, 32'd15, 32'd25);
    
    test_alu('ALU_SUB, 32'd35, 32'd15, 32'd20);

    //bitwise operations

    test_alu('ALU_AND, 32'h0FFF000F, 32'hF0FF0F0F, 32'h00FF000F);
    test_alu('ALU_OR, 32'h0000FFFF, 32'hFFFF0000, 32'hFFFFFFFF);
    test_alu('ALU_XOR, 32'hAAAAAAAA, 32'h55555555, 32'hFFFFFFFF);

    //shift left

    test_alu(`ALU_SHIFTL, 32'h00000001, 32'd4, 32'h00000010);
    
    //shift right (logical)

    test_alu(`ALU_SHIFTR, 32'h10000000, 32'd4, 32'h01000000);

    //shift right (arithmetic)

    test_alu('ALU_SHIFTR_ARITH, 32'h80000000, 32'd4, 32'hF0000000);

    $display("ALU TEST END...");
    $finsih;

end
endmodule




    