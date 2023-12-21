`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2023 10:16:39 PM
// Design Name: 
// Module Name: buttons
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


module buttons(
    input clk,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    input btnC,
    input pause_switch,
    output [1:0] move,
    output pause,
    output rst
    );
    
    // Asynchronous Reset Button
    reg reset;
    wire arst;
    assign arst = btnC;
    // Asynchronous Reset
    always @(posedge clk or posedge arst) begin 
        if(arst)
            reset <= 1;
        else
            reset <= 0;
    end    
    
    reg [31:0] count_700Hz;
    always@(posedge clk or posedge arst) begin
        if (arst) begin
            count_700Hz <= 0;
        end
        else begin
            if (count_700Hz == 71_501) begin
                count_700Hz <= 0;                           
            end
            else
                count_700Hz <= count_700Hz + 1;
        end
    end
    
    wire left_button;
    wire right_button;
    wire up_button;
    wire down_button;
    reg pause_status;
    assign left_button = btnL;
    assign right_button = btnR;
    assign up_button = btnU;
    assign down_button = btnD;
    
    reg left_button_pressed_1;
    reg left_button_pressed_2;
    reg left_button_pressed_3;
    
    reg right_button_pressed_1;
    reg right_button_pressed_2;
    reg right_button_pressed_3;
    
    reg up_button_pressed_1;
    reg up_button_pressed_2;
    reg up_button_pressed_3;
    
    reg down_button_pressed_1;
    reg down_button_pressed_2;
    reg down_button_pressed_3;
    
    reg [1:0] move_result;
    always@(posedge clk) begin
        if (count_700Hz == 71_500) begin
            left_button_pressed_1 <= left_button;
            left_button_pressed_2 <= left_button_pressed_1;
            left_button_pressed_3 <= left_button_pressed_2;
            
            right_button_pressed_1 <= right_button;
            right_button_pressed_2 <= right_button_pressed_1;
            right_button_pressed_3 <= right_button_pressed_2;
            
            up_button_pressed_1 <= up_button;
            up_button_pressed_2 <= up_button_pressed_1;
            up_button_pressed_3 <= up_button_pressed_2;
            
            down_button_pressed_1 <= down_button;
            down_button_pressed_2 <= down_button_pressed_1;
            down_button_pressed_3 <= down_button_pressed_2;     
            
            if (!left_button_pressed_1 && left_button_pressed_2) begin
                move_result = 2'b00;
            end
            if (!right_button_pressed_1 && right_button_pressed_2) begin
                move_result = 2'b01;
            end
            if (!up_button_pressed_1 && up_button_pressed_2) begin
                move_result = 2'b10;
            end
            if (!down_button_pressed_1 && down_button_pressed_2) begin
                move_result = 2'b11;
            end
            
            // Separate Pause result
            pause_status <= pause_switch;     
        end
        
        
    end
    
    assign pause = pause_status;
    assign rst = reset;
    assign move = move_result;
endmodule
