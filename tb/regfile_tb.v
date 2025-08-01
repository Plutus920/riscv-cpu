module regfile_tb();

//regfile inputs

reg clk;
reg reset;
reg [4:0] rs_1;
reg [4:0] rs_2; 
reg writeEn;
reg [4:0] writeAddr; 
reg [31:0] writeData; 

//regfile output 

wire [31:0] rs1_data; 
wire [31:0] rs2_data; 

//instant 

register_file DUT(  .clk(clk),
                    .reset(reset),
                    .readAddr1(rs_1),
                    .readAddr2(rs_2),
                    .writeEnable(writeEn),
                    .writeData(writeData),
                    .rs1_data(rs1_data),
                    .rs2_data(rs2_data));



always #5 clk = ~clk;  

task test_read_write;
    input [4:0]
    


