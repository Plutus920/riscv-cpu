 module register_file(
                        input clk,
                        input reset,
                        input [4:0] readAddr1,
                        input [4:0] readAddr2,
                        input writeEnable,
                        input [4:0] writeAddr,
                        input [31:0] writeData,
                        output wire [31:0] rs1_data,
                        output wire [31:0] rs2_data );

    reg [31:0] register [31:0];

    assign rs1_data = (readAddr1 == 0)? 32'b0 : register[readAddr1];
    assign rs2_data = (readAddr2 == 0)? 32'b0 : register[readAddr2];

    integer i; 

    always @(posedge  clk) begin 
        
        if (reset) begin
            for (i=0; i<32; i=i+1) begin 
                register[i] <= 32'b0; 
            end
        end

        else if(writeEnable && writeAddr != 5'b0) begin
            register[writeAddr] <= writeData; 
            $display("WRITE @ t=%0t: reg[%0d] <= 0x%h", $time, writeAddr, writeData);
        end
    end
 endmodule