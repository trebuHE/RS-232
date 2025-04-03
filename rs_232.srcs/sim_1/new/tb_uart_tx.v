`timescale 1ns / 1ps

module uart_tx_tb;

// Parameters
parameter BAUD_RATE = 9600;
parameter CLK_FREQ = 100000000; // 100MHz
localparam CLK_PER_BIT = CLK_FREQ / BAUD_RATE;

reg clk_i;
reg rst_i;
reg [7:0] data_i;
wire tx_o;
wire ready_o;

// Instantiate the UART transmitter module
uart_tx uut (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i(data_i),
    .tx_o(tx_o),
    .ready_o(ready_o)
);

// Clock generation process
initial begin
    clk_i = 0;
    forever #5 clk_i = ~clk_i; // Generate a 100MHz clock
end

// Test process
initial begin
    // Initialize inputs
    rst_i <= 0;
    data_i <= 8'b0;

    // Apply reset
    #10 rst_i <= 1;
    #10 rst_i <= 0;

    // Wait for ready_o to go high after reset
    @(posedge clk_i);
    while (!ready_o) begin
        @(posedge clk_i);
    end

    // Test sending data
    test_data(8'b00000001); // Send byte 1
    test_data(8'b00000010); // Send byte 2
    test_data(8'b00000100); // Send byte 3

    // Finish simulation
    #100 $finish;
end

// Helper function to send a single byte of data
task test_data(input [7:0] data);
    begin
    // Wait for a clock edge
    @(posedge clk_i);
    // Wait until ready_o is true
    wait (ready_o);
    data_i <= data;
    @(posedge clk_i);
    while (!ready_o) begin
        @(posedge clk_i);
    end
    end
endtask


endmodule
