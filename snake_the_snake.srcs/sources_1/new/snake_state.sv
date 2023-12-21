`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2023 10:44:26 PM
// Design Name: 
// Module Name: snake_state
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


module snake_state(
    input clk,
    input rst,
    output reg [31:0] out_snake_position [0:6400],
    output wire [31:0] out_snake_size
    );

    reg [31:0] snake_size;
    reg [31:0] snake_position [0:6400];
    initial begin
        snake_size = 1;
        snake_position[0][31:16] = 0;
        snake_position[0][15:0] = 0;
    end

    reg [31:0] count_1Hz;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
                count_1Hz <= 0;
        end
        else begin
            if (count_1Hz == 50_000_000) begin
                count_1Hz <= 0;
            end
            else
                count_1Hz <= count_1Hz + 1;
        end
    end

	always @(posedge clk or posedge rst)
		if(rst)
		  snake_size <= 1;
		else if (count_1Hz == 50_000_000) begin
		  snake_position[0][31:16] <= snake_position[0][31:16] + 1;
          snake_position[0][15:0] <= snake_position[0][15:0] + 1;
        end
    assign out_snake_size = snake_size;
    assign out_snake_position = snake_position;
endmodule
