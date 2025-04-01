`timescale 1ns / 1ps

module rs232_transceiver(
    input clk_i,
    input rst_i,
    input RXD_i,
    output TXD_o
    );
    
    parameter BAUD_RATE = 9600;
    parameter CLK_FREQ = 100000000; // 100 MHz

    reg [7:0] rx_data;
    reg [7:0] modified_data;
    reg [7:0] tx_data;
    reg rx_ready;
    reg tx_ready;
    
endmodule
