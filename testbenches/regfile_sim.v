`timescale 1ns / 1ps

module regfile_sim;

    wire [31:0] A_readdat1,
                B_readdat2;

    reg clk,
        rst,
        regwrite;
    reg [4:0] rs,
              rt,
              rd;
    reg [31:0] writedata;

    regfile DUT (
        .A_readdat1(A_readdat1),
        .B_readdat2(B_readdat2),
        .clk(clk),
        .rst(rst),
        .regwrite(regwrite),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .writedata(writedata)
    );

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        regwrite  = 0;
        rst       = 1;
        rs        = 0;
        rt        = 2;
        rd        = 2;
        writedata = 32'hAAAAAAAA;

        #10;        

        rst = 0;

        #10;        
                    

        regwrite = 1;

        #10;        
                    

        regwrite = 0;

        #10;        
        
        $display("Test Complete");

        $finish;
    end

endmodule
