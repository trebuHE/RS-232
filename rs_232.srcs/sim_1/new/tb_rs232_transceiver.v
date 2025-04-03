`timescale 1ns / 1ps

module tb_rs232_transceiver;

    parameter CLK_FREQ = 100000000; // 100 MHz
    parameter BAUD_RATE = 9600;
    parameter BIT_TIME = CLK_FREQ / BAUD_RATE; // Bit time in clock cycles (104.17)

    reg clk_i;
    reg rst_i;
    reg RXD_i;
    wire TXD_o;

    // Instantiate the DUT
    rs232_transceiver dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .RXD_i(RXD_i),
        .TXD_o(TXD_o)
    );
    
    // Clock generation: 100 MHz clock with a period of 10 ns
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i; // Toggle every 5 ns for 10 ns period
    end
    
    initial begin
        // Initialize signals
        clk_i = 0;
        rst_i = 1;
        RXD_i = 1;

        // Apply reset for 10 clock cycles
        #10 rst_i = 0;

        // Send a byte of data
        send_byte(8'h00);
        
        RXD_i = 1;
        
        // Wait for some time to observe the output
        #1000;

        $finish;
    end

    task send_byte(input [7:0] data);
        integer i;
        reg [9:0] frame; // Start + Data + Stop
    begin
        frame[0] = 0; // Start bit
        for (i = 0; i < 8; i = i + 1) begin
            frame[i+1] = data[i];
        end
        frame[9] = 1; // Stop bit

        // Send the frame bit by bit
        for (i = 0; i < 10; i = i + 1) begin
            RXD_i <= frame[i];
            #BIT_TIME;
        end
    end 
    endtask

endmodule
