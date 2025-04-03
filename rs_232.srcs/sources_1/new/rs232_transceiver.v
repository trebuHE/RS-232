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
    reg [7:0] received_data;
    uart_rx rx (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .rx_i(RXD_i),
        .data_o(rx_data),
        .ready_o(rx_ready)
        );

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            received_data <= 8'b0;
        end else if (rx_ready) begin
            received_data <= rx_data;
        end
    end

    wire [7:0] modified_data;
    add_0x20 adder (
        .val_i(recived_data),
        .val_o(modified_data)
        );
   
    wire tx_ready;
    uart_tx tx (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(modified_data),
        .tx_o(TXD_o),
        .ready_o(tx_ready)
        );
        
        
endmodule
