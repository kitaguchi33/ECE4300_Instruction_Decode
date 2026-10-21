`timescale 1ns / 1ps

module signExtend_sim();

    reg  [15:0] imm;
    wire [31:0] ext;

    signExtend DUT(
        .immediate(imm),
        .extended(ext)
    );

    initial begin

        imm = 16'b1000000000000011;
        #10;

        imm = 16'b1000000000110000;
        #10;

        imm = 16'b0000000000111111;
        #10;

        imm = 16'b0000000000111011;
        #10;

        $finish;
    end

endmodule
