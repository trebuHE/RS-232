`timescale 1ns / 1ps

module uart_rx(
    input wire clk_i,
    input wire rst_i,
    input wire rx_i,
    output reg [7:0] data_o,
    output reg ready_o
    );
    
    parameter BAUD_RATE = 9600;
    parameter CLK_FREQ = 100000000; // 100MHz
    
    localparam CLK_PER_BIT = CLK_FREQ / BAUD_RATE;
    
    reg [15:0] counter;
    reg [7:0] shift_reg;
    reg [4:0] bits;
    reg started;
    
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            data_o <= 8'b0;
            counter <= 15'b0;
            shift_reg <= 8'b0;
            bits <= 5'b0;
            ready_o <= 0;
            started <= 0;
        end else begin     
            if (!rx_i && !started) begin
                // data line low and no ongoing transmission
                started <= 1;
                counter <= CLK_PER_BIT * 2;
                bits <= 0;
            end
            
            if (started) begin
                if (counter > 0) begin
                    counter <= counter - 1;
                end else begin
                    bits <= bits + 1;
                    counter <= CLK_PER_BIT;
                end
                
                if (bits < 8) begin
                    ready_o <= 0;
                end else if (bits == 9) begin
                    started <= 0;
                    data_o <= {shift_reg[0], shift_reg[1], shift_reg[2], shift_reg[3], shift_reg[4], shift_reg[5], shift_reg[6], shift_reg[7]};
                    ready_o <= 1;
                    bits <= 0;
                end    
            end             
        end           
    end
    
    always @(posedge clk_i) begin
        if (started && counter == CLK_PER_BIT / 2) begin
            shift_reg[7:0] <= {shift_reg[6:0], rx_i};
        end
    end 
endmodule
