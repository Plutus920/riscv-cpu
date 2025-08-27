module regfile_tb();

//regfile inputs

reg clk;
reg reset;
reg [4:0] rs_1;
reg [4:0] rs_2; 
reg writeEn;
reg [4:0] wDest; 
reg [31:0] wData; 

//regfile output 

wire [31:0] rs1_data; 
wire [31:0] rs2_data; 

//instant 

register_file DUT(  .clk(clk),
                    .reset(reset),
                    .readAddr1(rs_1),
                    .readAddr2(rs_2),
                    .writeEnable(writeEn),
                    .writeAddr(wDest),
                    .writeData(wData),
                    .rs1_data(rs1_data),
                    .rs2_data(rs2_data));


initial clk = 0;
always #5 clk = ~clk; 

//reset logic 
initial begin 
    reset = 1;
    writeEn = 0;
    wData = 0; 
    wDest = 0;
    #12 reset = 0; //reset deasserted at t=15 
end


initial begin 
   $dumpfile("waveforms/regfile.vcd");
   $dumpvars(0,regfile_tb);

    @(negedge reset); //waits until reset 

    writeEn = 1; 
    wDest = 5'b00100;
    wData = 32'h0000FFFF;
    $display(">>> t=%0t | WRITE: x%d <= 0x%h", $time, wDest, wData);
    #1;
    @(posedge clk); //t=15 (first rising edge after reset)

   
    wDest = 5'b01000;
    wData = 32'hFFFF0000;
    $display(">>> t=%0t | WRITE: x%d <= 0x%h", $time, wDest, wData);
    #1;
    @(posedge clk); //t=25 (next rising edge)

    
    writeEn = 0; 
    @(posedge clk); //t=35 (next rising edge)
    
    rs_1 = 5'b00100; 
    rs_2 = 5'b01000;

    @(posedge clk); //t=45 (next rising edge)
    #1;

   // $display("writeEn = %b, wData = %h, rs1 = %h, rs2 = %h, rs1_data = %h, rs2_data = %h \n", writeEn, wData, rs_1, rs_2, rs1_data, rs2_data);
    
    $display("readAdd1 = %b, readAdd2 = %b, readData1 = %h, readData2 = %h\n", rs_1, rs_2, rs1_data, rs2_data); 

    $finish;

end
endmodule