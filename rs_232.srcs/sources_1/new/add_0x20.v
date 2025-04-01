`timescale 1ns / 1ps

module add_0x20(
    input wire [7:0] val_i,
    output reg [7:0] val_o
    );
    
    always @(*) begin
        val_o = val_i + 8'h20;
    end         
endmodule
