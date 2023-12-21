`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2023 10:40:41 PM
// Design Name: 
// Module Name: snake
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


module snake(
    input wire clk,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    input btnC,
    input pause_switch,
    output wire Hsync, Vsync,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output [6:0] seg,
    output [3:0] an
    );
    
    wire [1:0] move;
    wire pause;
    wire reset;
    wire clk_25MHz;
    buttons BUTTON(
        .clk (clk),
        .btnL (btnL),
        .btnR (btnR),
        .btnU (btnU),
        .btnD (btnD),
        .btnC (btnC),
        .pause_switch (pause_switch),
        .move (move),
        .pause (pause),
        .rst (reset)
    );
    

    wire [10:0] apple;
    wire [10:0] vga_apple;
    wire [1799:0] snake_position;
    wire [9:0] snake_size;
    wire generate_apple;
//    wire apple_done;
    wire game_over;
    wire [5:0] snake_x;
    wire [4:0] snake_y;
    
//    snake_state SNAKE_STATE(
//        .clk (clk),
//        .rst (reset),
//        .pause (pause_switch),
//        .direction (move),
//        .apple (apple),
//        .out_snake_position (snake_position),
//        .out_snake_size (snake_size),
//        .generate_apple (generate_apple),
//        .vga_apple (vga_apple)
//      , .snake_x (snake_x),
//        .snake_y (snake_y)   
//       ,.game_over (game_over)  
//    );
    
    wire generate_portal_1;
    wire generate_portal_2;
    wire [10:0] portal_1;
    wire [10:0] portal_2;
    wire [10:0] vga_portal1;
    wire [10:0] vga_portal2;
    snake_state SNAKE_STATE(
        .clk (clk),
        .rst (reset),
        .pause (pause_switch),
        .direction (move),
        .apple (apple),
        .portal1 (portal_1),
        .portal2 (portal_2),
        .out_snake_position (snake_position),
        .out_snake_size (snake_size),
        .generate_apple (generate_apple),
        .generate_portal_1 (generate_portal_1),
        .generate_portal_2 (generate_portal_2),
        .vga_apple (vga_apple),
        .vga_portal1 (vga_portal1),
        .vga_portal2 (vga_portal2)
      , .snake_x (snake_x),
        .snake_y (snake_y)   
       ,.game_over (game_over)  
    );
    
    random_portal_generator PORTAL_GENERATOR(
        .clk (clk),
        .rst (reset),
        .generate_portal_1 (generate_portal_1),
        .generate_portal_2 (generate_portal_2),
        .portal_1 (portal_1),
        .portal_2 (portal_2)
    );
    
    random_apple_generator APPLE_GENERATOR(
        .clk (clk),
        .rst (reset),
        .generate_apple (generate_apple),
        .apple (apple)    
    );

    
//    vga_sync VGA(
// 		.clk (clk), .reset(reset),
// 		.clk_25MHz (clk_25MHz),
// 		.snake_position (snake_position),
// 		.snake_size (snake_size),
// 		.vga_apple (vga_apple),
// 		.game_over (game_over),
//        .Hsync (Hsync), .Vsync (Vsync),
//        .vgaRed (vgaRed),
//        .vgaGreen (vgaGreen),
//        .vgaBlue (vgaBlue)       
//    );

    vga_sync VGA(
 		.clk (clk), .reset(reset),
 		.clk_25MHz (clk_25MHz),
 		.snake_position (snake_position),
 		.snake_size (snake_size),
 		.vga_apple (vga_apple),
 		.vga_portal1 (vga_portal1),
 		.vga_portal2 (vga_portal2),
 		.game_over (game_over),
        .Hsync (Hsync), .Vsync (Vsync),
        .vgaRed (vgaRed),
        .vgaGreen (vgaGreen),
        .vgaBlue (vgaBlue)       
    );
    
    master_clock CLOCK(
        .clk (clk),
        .rst(reset),
        .clk_25MHz (clk_25MHz)
    );
    
    wire [6:0] digit_1_encoded;
    wire [6:0] digit_2_encoded;
    wire [6:0] digit_3_encoded;
    wire [6:0] digit_4_encoded;
    assign digit_4_encoded = ~7'b1111110;
//    encoder_x SNAKE_X(
//        .decimal_number (snake_x),
//        .encoded1 (digit_4_encoded),
//        .encoded2 (digit_3_encoded)
//    );
    
//    encoder_y SNAKE_Y(
//        .decimal_number (snake_y),
//        .encoded1 (digit_2_encoded),
//        .encoded2 (digit_1_encoded)
//    );
    
    encode_score SCORE(
        .decimal_number (snake_size),
        .encoded1 (digit_3_encoded),
        .encoded2 (digit_2_encoded),
        .encoded3 (digit_1_encoded)
    );
    
    number_to_7_segment(
        .clk_100MHz (clk),
        .digit_1_encoded (digit_1_encoded),
        .digit_2_encoded (digit_2_encoded),
        .digit_3_encoded (digit_3_encoded),
        .digit_4_encoded (digit_4_encoded),
        .seg (seg),
        .an (an)
    );
endmodule
