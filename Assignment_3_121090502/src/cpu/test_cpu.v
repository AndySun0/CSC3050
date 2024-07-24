`timescale 1ns / 10ps
`include "cpu.v"
module tb_cpu();

    reg CLK;
    initial CLK = 1'b0;
    always #5 CLK = ~CLK;
    
    CPU cpu1(
        .CLK (CLK)
    );

endmodule

