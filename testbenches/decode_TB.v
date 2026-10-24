`timescale 1ns / 1ps

module decode_TB();

    reg clk_tb, clr_tb, regwrite_tb;
    reg [4:0] wb_write_reg_location_tb;
    reg [31:0] npc_tb, instr_from_ifId_tb, mem_wb_write_data_tb; 
    
    wire [1:0] wb_out_tb;
    wire [2:0] mem_out_tb;
    wire [3:0] ctl_ex_out_tb;
    wire [31:0] npc_out_tb, readdat1_out_tb, readdat2_out_tb, sign_ext_out_tb;
    wire [4:0] instr_bits_20_16_out_tb, instr_bits_15_11_out_tb;
    
    decode dut(
        .clk(clk_tb),
        .clr(clr_tb),
        .wb_reg_write(regwrite_tb),
        .wb_write_reg_location(wb_write_reg_location_tb),
        .mem_wb_write_data(mem_wb_write_data_tb),
        .if_id_instr(instr_from_ifId_tb),
        .if_id_npc(npc_tb),
        
        .id_ex_wb(wb_out_tb),
        .id_ex_mem(mem_out_tb),
        .id_ex_execute(ctl_ex_out_tb),
        .id_ex_npc(npc_out_tb),
        .id_ex_readdat1(readdat1_out_tb),
        .id_ex_readdat2(readdat2_out_tb),
        .id_ex_sign_ext(sign_ext_out_tb),
        .id_ex_instr_bits_20_16(instr_bits_20_16_out_tb),
        .id_ex_instr_bits_15_11(instr_bits_15_11_out_tb)
    );

    initial clk_tb <= 0;
    always #5 clk_tb = ~clk_tb;

    initial begin
        clr_tb = 0;
        regwrite_tb = 0;
        wb_write_reg_location_tb = 5'd2; // $v0
        mem_wb_write_data_tb = 32'h64;
        npc_tb = 32'h00000001;
        
        // Add $v0 (reg[2]), $a2 (reg[6]), $a3 (reg[7])
        instr_from_ifId_tb = 32'h00c71020; // 00000000110001110001000000100000
        
        #50; // clr enabled, initializing values
        
        clr_tb = 1;
        
        #50 // clr disabled, regwrite disabled, decode RFORMAT
        
        npc_tb = 32'h00000002;
        
        // BEQ $zero, $zero, 0x11
        instr_from_ifId_tb = 32'h10000011; // 00010000000000000000000000010001
        
        #50; // decode BEQ
        
        npc_tb = 32'h00000003;
        
        // LW $v0, 2($a1)
        instr_from_ifId_tb = 32'h8ca20002; // 10001100101000100000000000000010
        
        #50; // decode LW
        
        npc_tb = 32'h00000004;
        
        // SW $v0, 2($a1)
        instr_from_ifId_tb = 32'haca20002; // 10101100101000100000000000000010
        
        #50; // decode SW
        
        npc_tb = 32'h00000005;
        regwrite_tb = 1;
        
        
        #50 // write to regfile REG[2] <= h'64
        
        npc_tb = 32'h00000006;
        regwrite_tb = 0;
    
        // Add $v0, $v0, $v0
        instr_from_ifId_tb = 32'h00421020; // 00000000010000100001000000100000
        
        #50
        $finish;
    end



endmodule
