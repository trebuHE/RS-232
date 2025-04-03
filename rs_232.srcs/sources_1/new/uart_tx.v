`timescale 1ns / 1ps

module uart_tx (
    input wire clk_i,
    input wire rst_i,
    input wire [7:0] data_i,
    output reg tx_o,
    output reg ready_o
);

parameter BAUD_RATE = 9600;
parameter CLK_FREQ = 100000000; // 100MHz
    
localparam CLK_PER_BIT = CLK_FREQ / BAUD_RATE;

reg [15:0] counter;
reg [9:0] shift_reg;
reg [4:0] bits;

always @(posedge clk_i or posedge rst_i) begin
    if(rst_i) begin
        tx_o <= 1;
        ready_o <= 1;
        counter <= CLK_PER_BIT;
        shift_reg <= {1'b1, 9'b0};
        bits <= 5'b0;
    end else begin
        if(ready_o && (shift_reg != {1'b1, data_i, 1'b0})) begin // ready and input data changed
            ready_o <= 0;
            shift_reg <= {1'b1, data_i, 1'b0};
            bits <= 5'b0;
        end
        
        if(!ready_o) begin
            if(counter > 0) begin
                counter <= counter -1;
            end else begin
                bits <= bits + 1;
                counter <= CLK_PER_BIT;
            end
            
            if(bits < 10) begin
                ready_o <= 0;
                tx_o <= shift_reg[bits];
            end else if (bits >= 10) begin
                tx_o <= 1;
                ready_o <= 1;
                bits <= 5'b0;
            end
        end
    end
end

endmodule