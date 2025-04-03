`timescale 1ns / 1ps

module tb_rs232_transceiver;

    parameter CLK_FREQ = 100000000; // 100 MHz
    parameter BAUD_RATE = 9600;
    parameter BIT_TIME = (CLK_FREQ / BAUD_RATE) * 10;

    reg clk_i;
    reg rst_i;
    reg RXD_i;
    wire TXD_o;

    rs232_transceiver dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .RXD_i(RXD_i),
        .TXD_o(TXD_o)
    );
    

    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i; 
    end
    
    initial begin
        clk_i = 0;
        rst_i = 1;
        RXD_i = 1;

        #10 rst_i = 0;

        send_byte(8'h01);
        #2e6;
        send_byte(8'h55);
        #2e6;

        $finish;
    end

    task send_byte(input [7:0] data);
        integer i;
        reg [9:0] frame;
    begin
        frame[0] = 0;
        for (i = 0; i < 8; i = i + 1) begin
            frame[i+1] = data[i];
        end
        frame[9] = 1;

        for (i = 0; i < 10; i = i + 1) begin
            RXD_i <= frame[i];
            #BIT_TIME;
        end
        RXD_i = 1;
    end 
    endtask

endmodule
