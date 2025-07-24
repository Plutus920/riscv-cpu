 module register_file(
                        input clk,
                        input readEnable,
                        input [4:0] readAddr1,
                        input [4:0] readAddr2,
                        input writeEnable,
                        input [4:0] writeAddr,
                        input [31:0] writeData  );

    reg [31:0] register [31:0];
    
    always @(posedge  clk) begin 
        if(readEnable) begin

