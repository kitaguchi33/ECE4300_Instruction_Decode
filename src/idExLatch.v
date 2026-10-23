`timescale 1ns / 1ps

module idExLatch(
    output reg [1:0] wb_out,
    output reg [2:0] mem_out,
    output reg [3:0] ctl_ex_out,
    output reg [31:0] npc_out, readdat1_out, readdat2_out, sign_ext_out,
    output reg [4:0] instr_bits_20_16_out, instr_bits_15_11_out,
    
    input [1:0] ctl_wb,
    input [2:0] ctl_mem,
    input [3:0] ctl_ex,
    input [31:0] npc, readdat1, readdat2, sign_ext,
    input [4:0] instr_bits_20_16, instr_bits_15_11,
    
    input clk, clr
);

    always @(posedge clk or negedge clr) begin
        if (!clr) begin // All outputs are 0 on clr
            wb_out                  <= 2'd0;
            mem_out                 <= 3'd0;
            ctl_ex_out              <= 4'd0;
            npc_out                 <= 32'd0;
            readdat1_out            <= 32'd0;
            readdat2_out            <= 32'd0;
            sign_ext_out            <= 32'd0;
            instr_bits_20_16_out    <= 5'd0;
            instr_bits_15_11_out    <= 5'd0;
        end
        else begin  // else assign all outputs to respective inputs
            wb_out                  <= ctl_wb;
            mem_out                 <= ctl_mem;
            ctl_ex_out              <= ctl_ex;
            npc_out                 <= npc;
            readdat1_out            <= readdat1;
            readdat2_out            <= readdat2;
            sign_ext_out            <= sign_ext;
            instr_bits_20_16_out    <= instr_bits_20_16;
            instr_bits_15_11_out    <= instr_bits_15_11;
        end
    end
endmodule
