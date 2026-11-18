`timescale 1ns / 1ps

module control_sim(); // Outputs are wires, inputs are reg

    reg clk = 0, rst;
    reg [5:0] opcode;
    
    wire [1:0] wb;
    wire [2:0] mem;
    wire [3:0] ex;

    control dut(clk, rst, opcode, wb, mem, ex);
    
    initial forever #5 clk = ~clk;
    
    initial begin
        rst = 0;
        opcode = 6'b100000;
    
        #20
        
        rst = 1;
    
        #20
    
        opcode = 6'b101011;
        
        #20
    
        opcode = 6'b100011;
        
        #20
    
        opcode = 6'b000100;
        
        #20
        
        opcode = 6'b111111;
        
        #20
        
        opcode = 6'b100011;
        
        #20
        
        rst = 0;
        
        #50
        
        $finish;
        
    end
    
endmodule
