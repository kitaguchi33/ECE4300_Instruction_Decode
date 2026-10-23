`timescale 1ns / 1ps

module ifExLatch_sim();
    
    reg [1:0] ctl_wb;
    reg [2:0] ctl_mem;
    reg [3:0] ctl_ex;
    reg [31:0] npc, readdat1, readdat2, sign_ext;
    reg [4:0] instr_bits_20_16, instr_bits_15_11;
    
    reg clk = 0, clr;
    
    wire [1:0] wb_out;
    wire [2:0] mem_out;
    wire [3:0] ctl_ex_out;
    wire [31:0] npc_out, readdat1_out, readdat2_out, sign_ext_out;
    wire [4:0] instr_bits_20_16_out, instr_bits_15_11_out;

    idExLatch dut(
    wb_out,
    mem_out,
    ctl_ex_out,
    npc_out, readdat1_out, readdat2_out, sign_ext_out,
    instr_bits_20_16_out, instr_bits_15_11_out,
    
    ctl_wb,
    ctl_mem,
    ctl_ex,
    npc, readdat1, readdat2, sign_ext,
    instr_bits_20_16, instr_bits_15_11,
    
    clk, clr
    );
    
    initial forever #5 clk = ~clk;

    initial begin
    
        clr = 0;
        ctl_wb = 2'b01;
        ctl_mem = 3'b100;
        ctl_ex = 4'b1111;
        npc = 32'hFFFFFFFF;
        readdat1 = 32'hFFFFFFF0;
        readdat2 = 32'h1FFFFFFF;
        sign_ext = 32'hFFFF8000;
        instr_bits_20_16 = 5'b01010;
        instr_bits_15_11 = 5'b10101;
      
        #20;

        clr = 1;
        ctl_wb = 2'b01;
        ctl_mem = 3'b100;
        ctl_ex = 4'b1111;
        npc = 32'hFFFFFFFF;
        readdat1 = 32'hFFFFFFF0;
        readdat2 = 32'h1FFFFFFF;
        sign_ext = 32'hFFFF8000;
        instr_bits_20_16 = 5'b01010;
        instr_bits_15_11 = 5'b10101;

        #20;

        ctl_wb = 2'b00;
        ctl_mem = 3'b110;
        ctl_ex = 4'b1001;
        npc = 32'hFF000FFF;
        readdat1 = 32'hFF00FFF0;
        readdat2 = 32'h1453FFFF;
        sign_ext = 32'h00004000;
        instr_bits_20_16 = 5'b11010;
        instr_bits_15_11 = 5'b00101;

        #20;

        ctl_wb = 2'b11;
        ctl_mem = 3'b111;
        ctl_ex = 4'b0101;
        npc = 32'hFFF123FF;
        readdat1 = 32'h56FFFFF0;
        readdat2 = 32'h1FF02FFF;
        sign_ext = 32'hFFFF9110;
        instr_bits_20_16 = 5'b11111;
        instr_bits_15_11 = 5'b00000;

        #20;

        clr = 0;

        #50;

        $finish;
    end

endmodule