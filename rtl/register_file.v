 module register_file(
                        input clk,
                        input reset,
                        input [4:0] readAddr1,
                        input [4:0] readAddr2,
                        input writeEnable,
                        input [4:0] writeAddr,
                        input [31:0] writeData,
                        output reg [31:0] rs1_data,
                        output reg [31:0] rs2_data );

    reg [31:0] register [31:0];

    assign rs_1 = (readAddr1 == 0)? 32'b0 : register[readAddr1];
    assign rs_2 = (readAddr2 == 0)? 32'b0 : register[readAddr2];

    
    always @(posedge  clk) begin 
        if(writeEnable && writeAddr != 5'b0) begin
            register[writeAddr] <= writeData; 
        end
    end
 endmodule