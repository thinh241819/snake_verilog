`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2023 01:28:59 AM
// Design Name: 
// Module Name: clock_1mhz_to_1hz
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module master_clock(
    input clk,
    input rst,
//    output clk_1Hz,
//    output clk_2Hz,
//    output clk_700Hz,
//    output clk_1_3Hz,
    output clk_25MHz
    );

reg [1:0] count_25MHz;
reg clk_25MHz_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
            count_25MHz <= 0;
            clk_25MHz_reg <= 0;
    end
    else begin
        if (count_25MHz == 2'b11) begin
            clk_25MHz_reg <= ~clk_25MHz_reg;
        end
        else
            count_25MHz <= count_25MHz + 1;

    end
end

assign clk_25MHz = clk_25MHz_reg;
endmodule
