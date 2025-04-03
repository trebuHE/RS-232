`timescale 1ns / 1ps

module rs232_transceiver(
    input clk_i,
    input rst_i,
    input RXD_i,
    output TXD_o
    );
    
    parameter BAUD_RATE = 9600;
    parameter CLK_FREQ = 100000000; // 100 MHz
    
    wire [7:0] rx_data;
    wire rx_ready;
    uart_rx rx (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .rx_i(RXD_i),
        .data_o(rx_data),
        .ready_o(rx_ready)
        );

    wire [7:0] modified_data;
    add_0x20 adder (
        .val_i(rx_data),
        .val_o(modified_data)
        );
   
    wire tx_ready;
    wire [7:0] tx_data;

    assign tx_data = rx_ready ? modified_data : 8'bZ;
    
    uart_tx tx (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(tx_data),
        .tx_o(TXD_o),
        .ready_o(tx_ready)
        );
        
        
endmodule
