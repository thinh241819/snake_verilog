//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 12/02/2023 10:44:26 PM
//// Design Name: 
//// Module Name: snake_state
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module snake_state(
//    input clk,
//    input rst,
//    input pause,
//    input [1:0] direction,
//    input [10:0] apple,
//    output reg [600:0] out_snake_position,
//    output wire [31:0] out_snake_size,
//    output wire generate_apple,
//    output wire [10:0] vga_apple
//    ,output [5:0] snake_x,
//    output [4:0] snake_y
//    ,output game_over
////    ,output [5:0] apple_x,
////    output [4:0] apply_y
////    , output [9:0] score
//    );

//    reg [9:0] snake_size;
//    reg [11:0] snake_position [0:49];
//    reg [9:0] i;
//    reg [9:0] j;
//    reg [1:0] snake_direction;

//    reg [31:0] count_1Hz;
//    always @(posedge clk or posedge rst) begin
//        if (rst) begin
//                count_1Hz <= 0;
//        end
//        else begin
//            if (count_1Hz == 50_000_001) begin
//                count_1Hz <= 0;
//            end
//            else
//                count_1Hz <= count_1Hz + 1;
//        end
//    end
    
//    reg update_snake;
//    reg [9:0] idx_upd_snake;
//    reg update_output;
//    reg grow_mode;
//    reg apple_eaten;
//    reg [10:0] apple_result;
//    reg reset_snake;
//    reg [9:0] idx_reset_snake;
//    reg game_over_reg;
//    reg [9:0] idx_collision_self;
//    reg check_self_collision;
//	always @(posedge clk or posedge rst) begin 
//	    apple_eaten <= 0;
//	    if (rst) begin
//	       snake_size <= 1;
//	       snake_position[0][10:5] <= 6'b001111;
//	       snake_position[0][4:0] <= 5'b01100;
//	       snake_position[0][11] <= 1;
//	       reset_snake <= 1;
//	       idx_reset_snake <= 1;
//	       game_over_reg <= 0;
//	    end
//	    else if (pause == 0) begin
//	    if (reset_snake == 1) begin
//            snake_position[idx_reset_snake][11] <= 0;
//            if (idx_reset_snake == 49) begin
//                reset_snake <= 0;
//                idx_reset_snake <= 0;
//                update_output <= 1;
//                i <= 0;
//                j <= 0;
//            end
//            else begin
//                idx_reset_snake <= idx_reset_snake + 1;
//            end
//        end
//        else if (update_output == 1) begin
//            out_snake_position[i*12 + j] <= snake_position[i][j];
//            if (i == 49 && j == 11) begin
//                update_output <= 0;
//                i <= 0;
//                j <= 0;
//            end
//            else if (j == 11) begin
//                j <= 0;
//                i <= i + 1;
//            end
//            else begin
//                j <= j + 1;
//            end
//        end 
//        else if(update_snake == 1) begin
//            if(idx_upd_snake == 0) begin
//                update_snake <= 0;
//                idx_upd_snake <= 0;
                
//                update_output <= 1;
                
//                check_self_collision <= 1;
//                idx_collision_self <= 1;
//                i <= 0;
//                j <= 0;
//                if (snake_direction == 2'b00) 
//                    snake_position[idx_upd_snake][10:5] <= snake_position[idx_upd_snake][10:5] - 1;
//                else if (snake_direction == 2'b01)
//                    snake_position[idx_upd_snake][10:5] <= snake_position[idx_upd_snake][10:5] + 1;
//                else if (snake_direction == 2'b11)
//                    snake_position[idx_upd_snake][4:0] <= snake_position[idx_upd_snake][4:0] + 1;
//                else if (snake_direction == 2'b10)
//                    snake_position[idx_upd_snake][4:0] <= snake_position[idx_upd_snake][4:0] - 1;
                    
//                if (snake_position[idx_upd_snake][10:0] == apple_result) begin
//                    apple_eaten <= 1;
//                    snake_size <= snake_size + 1;
//                    snake_position[snake_size - 1][11] = 1;
//                end

//                if (snake_position[idx_upd_snake][10:5] == 38 || snake_position[idx_upd_snake][10:5] == 63 || snake_position[idx_upd_snake][4:0] == 27 || snake_position[idx_upd_snake][4:0] == 31) begin
//                    reset_snake <= 1;
//                    idx_reset_snake <= 1;
//                    snake_position[0][11] <= 0;
//                    game_over_reg <= 1;
//                end

//            end
//            else begin
//                snake_position[idx_upd_snake] = snake_position[idx_upd_snake-1];
//                idx_upd_snake <= idx_upd_snake - 1;
//            end
//        end    
//        else if (check_self_collision == 1) begin
//            if (idx_collision_self == snake_size) begin
//                check_self_collision <= 0;
////                idx_collision_self <= 1;
//            end
//            else if (snake_position[0] == snake_position[idx_collision_self]) begin
//                game_over_reg <= 1;
//            end
//            else 
//                idx_collision_self = idx_collision_self + 1;
//        end
//        else if (count_1Hz == 50_000_000) begin
//            update_snake <= 1;
//            idx_upd_snake <= snake_size - 1;
//        end
//	    end

//    end
    
//    always@(posedge clk or posedge rst) begin
//        if(rst) begin
//            snake_direction <= 2'b01;
//        end
//        else begin
//            snake_direction <= direction;
//        end
//    end
    
//    reg generate_apple_reg;
    
//    always@(posedge clk or posedge rst) begin
//        if(rst) begin
//            generate_apple_reg <= 1;
//        end
//        else begin
//            if ((apple[10:5] <= 37 && apple[4:0] <= 26)) begin
//                generate_apple_reg <= 0;
//                apple_result <= apple;
//            end
//            if (apple[10:0] == apple_result[10:0]) begin
//                generate_apple_reg <= 1;
//            end
//            if(apple_eaten) begin
//                generate_apple_reg <= 1;
//            end
//        end
//    end
    
//    assign generate_apple = generate_apple_reg;
//    assign out_snake_size = snake_size;
//    assign vga_apple = apple_result;
////    assign score = snake_size;
//    assign snake_x = snake_position[0][10:5];
//    assign snake_y = snake_position[0][4:0];
//    assign game_over = game_over_reg;
//endmodule




























































































































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
    input pause,
    input [1:0] direction,
    input [10:0] apple,
    input [10:0] portal1,
    input [10:0] portal2,
    output reg [1799:0] out_snake_position,
    output wire [31:0] out_snake_size,
    output wire generate_apple,
    output wire generate_portal_1,
    output wire generate_portal_2,
    output wire [10:0] vga_apple,
    output wire [10:0] vga_portal1,
    output wire [10:0] vga_portal2
    ,output [5:0] snake_x,
    output [4:0] snake_y
    ,output game_over
//    ,output [5:0] apple_x,
//    output [4:0] apply_y
//    , output [9:0] score
    );

    reg [9:0] snake_size;
    reg [11:0] snake_position [0:149];
    reg [9:0] i;
    reg [9:0] j;
    reg [1:0] snake_direction;

    reg [31:0] count_1Hz;
    reg [31:0] max_speed;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
                count_1Hz <= 0;
                max_speed <= 0;
        end
        else begin
            if (snake_size <= 25) begin
                max_speed <= snake_size;
            end
            if (count_1Hz == 15_000_001 - (max_speed * 500_000)) begin
                count_1Hz <= 0;
            end
            else
                count_1Hz <= count_1Hz + 1;
        end
    end
    
    reg update_snake;
    reg [9:0] idx_upd_snake;
    reg update_output;
    reg grow_mode;
    reg apple_eaten;
    reg [10:0] apple_result;
    reg reset_snake;
    reg [9:0] idx_reset_snake;
    reg game_over_reg;
    reg [9:0] idx_collision_self;
    reg check_self_collision;
    
    reg [10:0] portal_1_result;
    reg [10:0] portal_2_result;
    reg [10:0] portal_1_corner;
    reg [10:0] portal_2_corner;
    reg portal_entered;
    
	always @(posedge clk or posedge rst) begin 
	    apple_eaten <= 0;
	    portal_entered <= 0;
	    if (rst) begin
	       snake_size <= 1;
	       snake_position[0][10:5] <= 6'b001111;
	       snake_position[0][4:0] <= 5'b01100;
	       snake_position[0][11] <= 1;
	       reset_snake <= 1;
	       idx_reset_snake <= 1;
	       game_over_reg <= 0;
	       
	    end
	    else if (pause == 0) begin
	    if (reset_snake == 1) begin
            snake_position[idx_reset_snake][11] <= 0;
            if (idx_reset_snake == 149) begin
                reset_snake <= 0;
                idx_reset_snake <= 0;
                update_output <= 1;
                i <= 0;
                j <= 0;
            end
            else begin
                idx_reset_snake <= idx_reset_snake + 1;
            end
        end
        else if (update_output == 1) begin
            out_snake_position[i*12 + j] <= snake_position[i][j];
            if (i == 149 && j == 11) begin
                update_output <= 0;
                i <= 0;
                j <= 0;
            end
            else if (j == 11) begin
                j <= 0;
                i <= i + 1;
            end
            else begin
                j <= j + 1;
            end
        end 
        else if(update_snake == 1) begin
            if(idx_upd_snake == 0) begin
                update_snake <= 0;
                idx_upd_snake <= 0;
                
                update_output <= 1;
                
                check_self_collision <= 1;
                idx_collision_self <= 2;
                i <= 0;
                j <= 0;
                if (snake_direction == 2'b00) 
                    snake_position[idx_upd_snake][10:5] <= snake_position[idx_upd_snake][10:5] - 1;
                else if (snake_direction == 2'b01)
                    snake_position[idx_upd_snake][10:5] <= snake_position[idx_upd_snake][10:5] + 1;
                else if (snake_direction == 2'b11)
                    snake_position[idx_upd_snake][4:0] <= snake_position[idx_upd_snake][4:0] + 1;
                else if (snake_direction == 2'b10)
                    snake_position[idx_upd_snake][4:0] <= snake_position[idx_upd_snake][4:0] - 1;
                    
                // Apple Eaten
                if (snake_position[idx_upd_snake][10:0] == apple_result) begin
                    apple_eaten <= 1;
                    snake_size <= snake_size + 1;
                    snake_position[snake_size - 1][11] = 1;
                end
                
                // Entered Portal
                if (snake_position[idx_upd_snake][10:0] == portal_1_corner) begin
                    portal_entered <= 1;
                    snake_position[idx_upd_snake][10:0] <= portal_2_corner;
                end
                else if (snake_position[idx_upd_snake][10:0] == portal_2_corner) begin
                    portal_entered <= 1;
                    snake_position[idx_upd_snake][10:0] <= portal_1_corner;
                end

                if (snake_position[idx_upd_snake][10:5] == 38 || snake_position[idx_upd_snake][10:5] == 63 || snake_position[idx_upd_snake][4:0] == 27 || snake_position[idx_upd_snake][4:0] == 31) begin
                    reset_snake <= 1;
                    idx_reset_snake <= 1;
                    snake_position[0][11] <= 0;
                    game_over_reg <= 1;
                end

            end
            else begin
                snake_position[idx_upd_snake] = snake_position[idx_upd_snake-1];
                idx_upd_snake <= idx_upd_snake - 1;
            end
        end    
        else if (check_self_collision == 1) begin
            if (idx_collision_self <= snake_size) begin
                if (idx_collision_self == snake_size) begin
                    check_self_collision <= 0;
    //                idx_collision_self <= 1;
                end
                else if (snake_position[0] == snake_position[idx_collision_self]) begin
                    game_over_reg <= 1;
                end
                else 
                    idx_collision_self = idx_collision_self + 1;            
            end
            else
                check_self_collision <= 0;

        end
        else if (count_1Hz == 15_000_000 - (max_speed * 500_000)) begin
            update_snake <= 1;
            idx_upd_snake <= snake_size - 1;
        end
	    end

    end
    
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            snake_direction <= 2'b01;
        end
        else begin
            snake_direction <= direction;
        end
    end
    
    reg generate_apple_reg;
    
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            generate_apple_reg <= 1;
        end
        else begin
            if ((apple[10:5] <= 37 && apple[4:0] <= 26)) begin
                generate_apple_reg <= 0;
                apple_result <= apple;
            end
            if (apple[10:0] == apple_result[10:0]) begin
                generate_apple_reg <= 1;
            end
            if(apple_eaten) begin
                generate_apple_reg <= 1;
            end
        end
    end
    
    reg generate_portal_1_reg;
    reg generate_portal_2_reg;
//    always@(posedge clk or posedge rst) begin
//        if(rst) begin
//            generate_portal_1_reg = 1;
//            generate_portal_2_reg = 1;
//        end
//        else begin
//            if ((portal1[10:5] <= 37 && portal1[4:0] <= 26) && (portal2[10:5] <= 37 && portal2[4:0] <= 26)) begin
//                generate_portal_1_reg = 0;
//                portal_1_result = portal1;
//                generate_portal_2_reg = 0;
//                portal_2_result = portal2;
//            end
//            if ((portal_1_result[10:0] == portal_2_result[10:0]) || (portal_1_result[10:0] == apple_result[10:0]) || (portal_2_result[10:0] == apple_result[10:0]) || 
//            (portal_1_result[10:0] == apple_result[10:0] && portal_2_result[10:0] == apple_result[10:0])
//            || (portal_1_result[10:5] == portal_2_result[10:5] + 1)
//            || (portal_1_result[10:5] == portal_2_result[10:5] - 1)
//            || (portal_1_result[4:0] == portal_2_result[4:0] + 1)
//            || (portal_1_result[4:0] == portal_2_result[4:0] - 1)) begin
//                generate_portal_1_reg = 1;
//                generate_portal_2_reg = 1;
//            end
//            if(portal_entered) begin
//                generate_portal_1_reg = 1;
//                generate_portal_2_reg = 1;
//            end
//        end
//    end

    always@(posedge clk or posedge rst) begin
        if (rst) begin
            portal_1_corner <= 11'b00000000000;
            portal_2_corner <= 11'b10010111010;
        end
        else if (portal_entered) begin
            if (portal_1_corner == 11'b00000000000) begin
                portal_1_corner <= 11'b10010100000;
                portal_2_corner <= 11'b00000011010;
            end
            else begin
                portal_1_corner <= 11'b00000000000;
                portal_2_corner <= 11'b10010111010;
            end
        end
    end
    
    assign generate_apple = generate_apple_reg;
    assign out_snake_size = snake_size;
    assign vga_apple = apple_result;
//    assign score = snake_size;
    assign snake_x = snake_position[0][10:5];
    assign snake_y = snake_position[0][4:0];
    assign game_over = game_over_reg;
    assign generate_portal_1 = generate_portal_1_reg;
    assign generate_portal_2 = generate_portal_2_reg;
    assign vga_portal1 = portal_1_corner;
    assign vga_portal2 = portal_2_corner;
endmodule