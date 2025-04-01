`timescale 1ns / 1ps

module tb_uart_rx;

    // Testbench signals
    reg clk_i;
    reg rst_i;
    reg rx_i;
    wire [7:0] data_o;
    wire ready_o;

    // Instantiate the UART receiver module
    uart_rx uut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .rx_i(rx_i),
        .data_o(data_o),
        .ready_o(ready_o)
    );

    // Clock generation: 100 MHz clock with a period of 10 ns
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i; // Toggle every 5 ns for 10 ns period
    end

    // Reset and rx_i initialization
    initial begin
        rst_i = 1;  // Assert reset
        rx_i = 1;   // Idle state is high
        #100;       // Hold reset for 100 ns
        rst_i = 0;  // Deassert reset
    end

    // Define clock cycles per bit based on 100 MHz clock and 9600 baud
    localparam CLK_PER_BIT = 100000000 / 9600; // ≈ 10416 cycles per bit

    // Task to send a byte over rx_i
    task send_byte(input [7:0] data);
        integer i;
        begin
            // Start bit: low
            rx_i = 0;
            repeat(CLK_PER_BIT) @(posedge clk_i);
            // Data bits: LSB first
            for (i = 0; i < 8; i = i + 1) begin
                rx_i = data[i];
                repeat(CLK_PER_BIT) @(posedge clk_i);
            end
            // Stop bit: high
            rx_i = 1;
            repeat(CLK_PER_BIT) @(posedge clk_i);
        end
    endtask

    // Test sequence: send multiple bytes
    initial begin
        // Wait for reset to deassert
        #100;
        // Send test bytes
        send_byte(8'h55); // 01010101 - alternating bits
        send_byte(8'hAA); // 10101010 - alternating bits
        send_byte(8'h00); // 00000000 - all zeros
        send_byte(8'hFF); // 11111111 - all ones
        // Wait to ensure all data is processed
        #100000;
        $finish; // End simulation
    end

    // Monitor received data when ready_o is asserted
    always @(posedge ready_o) begin
        $display("Received data: %h at time %t", data_o, $time);
    end

endmodule