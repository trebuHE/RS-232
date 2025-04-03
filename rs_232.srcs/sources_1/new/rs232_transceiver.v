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
    reg rx_ready;
    uart_rx rx (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .rx_i(RXD_i),
        .data_o(rx_data),
        .ready_o(rx_ready)
        );

    reg [7:0] modified_data;
    add_0x20 adder (
        .val_i(rx_data),
        .val_o(modified_data)
        );
   
    reg tx_ready;
    uart_tx tx (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(modified_data),
        .tx_o(TXD_o),
        .ready_o(tx_ready)
        );
        
        
endmodule
