module barrel_shifter(
                        input [31:0] in, 
                        input [4:0] n,
                        input dir,
                        input arith,
                        output wire [31:0] out);

reg [31:0] shift_left_1;
reg [31:0] shift_left_2;
reg [31:0] shift_left_4;
reg [31:0] shift_left_8;
reg [31:0] shift_left_16;

reg [31:0] shift_right_1;
reg [31:0] shift_right_2;
reg [31:0] shift_right_4;
reg [31:0] shift_right_8;
reg [31:0] shift_right_16;
reg [31:0] shift_right_fill; 

reg [31:0] result; 

always @(in or n or dir or arith) begin 
    
    $display("SHIFTER DEBUG: in=%h, n=%d, dir=%b, arith=%b", in, n, dir, arith);

    result = 32'b0;
    
    shift_left_1 = 32'b0;
    shift_left_2 = 32'b0;
    shift_left_4 = 32'b0;
    shift_left_8 = 32'b0;
    shift_left_16 = 32'b0;

    shift_right_1 = 32'b0;
    shift_right_2 = 32'b0;
    shift_right_4 = 32'b0;
    shift_right_8 = 32'b0;
    shift_right_16 = 32'b0; 
    shift_right_fill = 32'b0;

    
    
    if(dir==0) begin //left shift

        if(n[0] == 1'b1)
            shift_left_1 = {in[30:0],1'b0};
        else
            shift_left_1 = in; 
            
        if(n[1] == 1'b1)
            shift_left_2 = {shift_left_1[29:0], 2'b00};
        else 
            shift_left_2 = shift_left_1; 
        
        if (n[2] == 1'b1)
            shift_left_4 = {shift_left_2[27:0], 4'b0000};
        else 
            shift_left_4 = shift_left_2;
        
        if (n[3] == 1'b1)
            shift_left_8 = {shift_left_4[23:0], 8'b00000000};
        else
            shift_left_8 = shift_left_4;
        
        if(n[4] == 1'b1)
            shift_left_16 = {shift_left_8[15:0], 16'b0000000000000000};
        else
            shift_left_16 = shift_left_8;
        
        result = shift_left_16; 

        $display("SHIFTL DEBUG: in=%h, n=%d", in, n);
        $display("stages: 1:%h, 2:%h, 4:%h, 8:%h, 16:%h, final:%h\n\n",
                    shift_left_1, shift_left_2, shift_left_4, shift_left_8,
                    shift_left_16, result);


    end else begin  //right shift

        if (in[31] == 1 && arith == 1) 
            shift_right_fill = 32'b1;
        else
            shift_right_fill = 32'b0;

        if(n[0] == 1'b1)
            shift_right_1 = {shift_right_fill[31], in[31:1]};
        else 
            shift_right_1 = in;

        if(n[1] == 1'b1)
            shift_right_2 = {shift_right_fill[31:30], shift_right_1[31:2]};
        else
            shift_right_2 = shift_right_1;
        
        if(n[2] == 1'b1)
            shift_right_4 = {shift_right_fill[31:28], shift_right_2[31:4]};
        else
            shift_right_4 = shift_right_2;
            
        if(n[3] == 1'b1)
            shift_right_8 = {shift_right_fill[31:24], shift_right_4[31:8]};
        else 
            shift_right_8 = shift_right_4;

        if(n[4] == 1'b1)
            shift_right_16 = {shift_right_fill[15:0], shift_right_8[31:16]};
        else 
            shift_right_16 = shift_right_8; 

        result = shift_right_16; 
        end
    end

    assign out = result; 

endmodule