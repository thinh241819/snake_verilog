

//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date:    00:30:38 03/19/2013 
//// Design Name: 
//// Module Name:    vga640x480 
//// Project Name: 
//// Target Devices: 
//// Tool versions: 
//// Description: 
////
//// Dependencies: 
////
//// Revision: 
//// Revision 0.01 - File Created
//// Additional Comments: 
////
////////////////////////////////////////////////////////////////////////////////////
//module vga_sync

//	(
//		input wire clk, reset,
//		input clk_25MHz,
//		input wire [599:0] snake_position,
//		input wire [9:0] snake_size,
//		input [10:0] vga_apple,
//		input game_over,
//	    output wire Hsync, Vsync,
//		output reg [3:0] vgaRed,
//		output reg [3:0] vgaGreen,
//		output reg [3:0] vgaBlue
//	);
//	reg [11:0] snake_position_array [0:49];
//	reg [9:0] x_left_border;
//	reg [9:0] x_right_border;
//	reg [9:0] y_top_border;
//	reg [9:0] y_bottom_border;
//	reg [9:0] i;
//	reg [9:0] j;
//	reg [9:0] k;
//	wire video_on;

	
//	// constant declarations for VGA sync parameters
//	localparam H_DISPLAY       = 640; // horizontal display area
//	localparam H_L_BORDER      =  48; // horizontal left border
//	localparam H_R_BORDER      =  16; // horizontal right border
//	localparam H_RETRACE       =  96; // horizontal retrace
//	localparam H_MAX           = H_DISPLAY + H_L_BORDER + H_R_BORDER + H_RETRACE - 1;		// 799
//	localparam START_H_RETRACE = H_DISPLAY + H_R_BORDER;																// 656
//	localparam END_H_RETRACE   = H_DISPLAY + H_R_BORDER + H_RETRACE - 1;								// 751
	
//	localparam V_DISPLAY       = 480; // vertical display area
//	localparam V_T_BORDER      =  10; // vertical top border
//	localparam V_B_BORDER      =  33; // vertical bottom border
//	localparam V_RETRACE       =   2; // vertical retrace
//	localparam V_MAX           = V_DISPLAY + V_T_BORDER + V_B_BORDER + V_RETRACE - 1; 	// 524
//    localparam START_V_RETRACE = V_DISPLAY + V_B_BORDER;																// 513							
//	localparam END_V_RETRACE   = V_DISPLAY + V_B_BORDER + V_RETRACE - 1;								// 514
	
	
	
//	// registers to keep track of current pixel location
//	reg [9:0] h_count_reg, h_count_next, v_count_reg, v_count_next;
	
//	// register to keep track of vsync and hsync signal states
//	reg vsync_reg, hsync_reg;
//	wire vsync_next, hsync_next;
 
//	// infer registers
//	reg game_over_reg;
//	always @(posedge clk_25MHz or posedge reset)
//		if(reset)
//		    begin
//                    v_count_reg <= 0;
//                    h_count_reg <= 0;
//                    vsync_reg   <= 0;
//                    hsync_reg   <= 0;
//                    game_over_reg <= 0;
//		    end
//		else
//		    begin
//                    v_count_reg <= v_count_next;
//                    h_count_reg <= h_count_next;
//                    vsync_reg   <= vsync_next;
//                    hsync_reg   <= hsync_next;
//		    end
			
//	// next-state logic of horizontal vertical sync counters
//	always @(posedge clk_25MHz or posedge reset) begin
//        if(reset) begin
//                h_count_next <= 0;
//                v_count_next <= 0;
//        end
//        else begin
//            h_count_next = (h_count_reg == H_MAX ? 0 : h_count_reg + 1);
//            v_count_next = h_count_reg == H_MAX ? (v_count_reg == V_MAX ? 0 : v_count_reg + 1) : v_count_reg;	
//        end
////		h_count_next = pixel_tick ? (h_count_reg == H_MAX ? 0 : h_count_reg + 1) : h_count_reg;

////        v_count_next = pixel_tick && h_count_reg == H_MAX ? (v_count_reg == V_MAX ? 0 : v_count_reg + 1) : v_count_reg;    
//	end
		
//    // hsync and vsync are active low signals
//    // hsync signal asserted during horizontal retrace
//    assign hsync_next = h_count_reg >= START_H_RETRACE				// START_H_RETRACE <= h_count_reg <= END_H_RETRACE
//                        && h_count_reg <= END_H_RETRACE;			// 656 <= h_count_reg <= 751

//    // vsync signal asserted during vertical retrace
//    assign vsync_next = v_count_reg >= START_V_RETRACE 				// START_V_RETRACE <= v_count_reg <= END_V_RETRACE
//                        && v_count_reg <= END_V_RETRACE;			// 513 <= v_count_reg <= 514

//    // video only on when pixels are in both horizontal and vertical display region
//    assign video_on = (h_count_reg < H_DISPLAY) 
//                      && (v_count_reg < V_DISPLAY);
        
////    snake_position_array[j][k] = snake_position[j*32+k];
//    always @(posedge clk) begin
//	    snake_position_array[i][j] <= snake_position[i*12 + j];    
//        if (i == 49 && j == 11) begin
//            i <= 0;
//            j <= 0;
//        end
//        else if (j == 11) begin
//            j <= 0;
//            i <= i + 1;
//        end
//        else begin
//            j <= j + 1;
//        end    
//    end
    
    
//    reg [9:0] temp;
//    reg [9:0] apple_left_border;
//    reg [9:0] apple_right_border;
//    reg [9:0] apple_top_border;
//    reg [9:0] apple_bottom_border;
//    always @(posedge clk_25MHz) begin
//        if (video_on) begin
//            if (game_over) begin
//                vgaRed = 4'b1111;
//                vgaGreen = 4'b00000;
//                vgaBlue = 4'b1111;
//            end
//            else begin
//                vgaRed = 0;
//                vgaGreen = 0;
//                vgaBlue = 0;            
//                if ((0 <= v_count_reg && v_count_reg < 32) || (464 <= v_count_reg && v_count_reg < 480) 
//                || (0 <= h_count_reg && h_count_reg < 16) || (624 <= h_count_reg && h_count_reg < 640)) begin
//                    vgaRed = 4'b0000;
//                    vgaGreen = 4'b1111;
//                    vgaBlue = 4'b0000;
//                end
//                else if ((((vga_apple[10:5] << 4) + 5'b10000) <= h_count_reg && h_count_reg < ((vga_apple[10:5] << 4) + 5'b10000 + 5'b10000))
//                && (((vga_apple[4:0] << 4) + 6'b100000) <= v_count_reg && v_count_reg < ((vga_apple[4:0] << 4) + 6'b100000 + 5'b10000))) begin
//                    vgaRed = 4'b1111;
//                    vgaGreen = 4'b0000;
//                    vgaBlue = 4'b0000;                        
//                end            
//                else if (((v_count_reg >= 32 && v_count_reg < V_DISPLAY) && (h_count_reg >= 16 && h_count_reg < H_DISPLAY))) begin
//                    for (k = 0; k < 50; k = k + 1) begin 
//                        if (snake_position_array[k][11] == 1) begin
//                            x_left_border = (snake_position_array[k][10:5] << 4) + 5'b10000;  // << 4 + 32 ms dung
//                            x_right_border = (snake_position_array[k][10:5] << 4) + 5'b10000 + 5'b10000;
//                            y_top_border = (snake_position_array[k][4:0] << 4) + 6'b100000;
//                            y_bottom_border = (snake_position_array[k][4:0] << 4) + 6'b100000 + 5'b10000; 
                            
//                            if ((x_left_border <= h_count_reg && h_count_reg < x_right_border)
//                            && (y_top_border <= v_count_reg && v_count_reg < y_bottom_border)) begin
//                                vgaRed = 4'b1111;
//                                vgaGreen = 4'b1111;
//                                vgaBlue = 4'b1111;                        
//                            end
//                        end
//                    end               
//                end  
//            end
       
//        end
//    end
//    // output signals
//    assign Hsync  = hsync_reg;
//    assign Vsync  = vsync_reg;
//    // assign x      = h_count_reg;
//    // assign y      = v_count_reg;
//    // assign p_tick = pixel_tick;
//endmodule
















































































`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_sync

	(
		input wire clk, reset,
		input clk_25MHz,
		input wire [1799:0] snake_position,
		input wire [9:0] snake_size,
		input [10:0] vga_apple,
		input [10:0] vga_portal1,
		input [10:0] vga_portal2,
		input game_over,
	    output wire Hsync, Vsync,
		output reg [3:0] vgaRed,
		output reg [3:0] vgaGreen,
		output reg [3:0] vgaBlue
	);
	reg [11:0] snake_position_array [0:149];
	reg [9:0] x_left_border;
	reg [9:0] x_right_border;
	reg [9:0] y_top_border;
	reg [9:0] y_bottom_border;
	reg [9:0] i;
	reg [9:0] j;
	reg [9:0] k;
	wire video_on;

	
	// constant declarations for VGA sync parameters
	localparam H_DISPLAY       = 640; // horizontal display area
	localparam H_L_BORDER      =  48; // horizontal left border
	localparam H_R_BORDER      =  16; // horizontal right border
	localparam H_RETRACE       =  96; // horizontal retrace
	localparam H_MAX           = H_DISPLAY + H_L_BORDER + H_R_BORDER + H_RETRACE - 1;		// 799
	localparam START_H_RETRACE = H_DISPLAY + H_R_BORDER;																// 656
	localparam END_H_RETRACE   = H_DISPLAY + H_R_BORDER + H_RETRACE - 1;								// 751
	
	localparam V_DISPLAY       = 480; // vertical display area
	localparam V_T_BORDER      =  10; // vertical top border
	localparam V_B_BORDER      =  33; // vertical bottom border
	localparam V_RETRACE       =   2; // vertical retrace
	localparam V_MAX           = V_DISPLAY + V_T_BORDER + V_B_BORDER + V_RETRACE - 1; 	// 524
    localparam START_V_RETRACE = V_DISPLAY + V_B_BORDER;																// 513							
	localparam END_V_RETRACE   = V_DISPLAY + V_B_BORDER + V_RETRACE - 1;								// 514
	
	
	
	// registers to keep track of current pixel location
	reg [9:0] h_count_reg, h_count_next, v_count_reg, v_count_next;
	
	// register to keep track of vsync and hsync signal states
	reg vsync_reg, hsync_reg;
	wire vsync_next, hsync_next;
 
	// infer registers
	reg game_over_reg;
	always @(posedge clk_25MHz or posedge reset)
		if(reset)
		    begin
                    v_count_reg <= 0;
                    h_count_reg <= 0;
                    vsync_reg   <= 0;
                    hsync_reg   <= 0;
                    game_over_reg <= 0;
		    end
		else
		    begin
                    v_count_reg <= v_count_next;
                    h_count_reg <= h_count_next;
                    vsync_reg   <= vsync_next;
                    hsync_reg   <= hsync_next;
		    end
			
	// next-state logic of horizontal vertical sync counters
	always @(posedge clk_25MHz or posedge reset) begin
        if(reset) begin
                h_count_next <= 0;
                v_count_next <= 0;
        end
        else begin
            h_count_next = (h_count_reg == H_MAX ? 0 : h_count_reg + 1);
            v_count_next = h_count_reg == H_MAX ? (v_count_reg == V_MAX ? 0 : v_count_reg + 1) : v_count_reg;	
        end
//		h_count_next = pixel_tick ? (h_count_reg == H_MAX ? 0 : h_count_reg + 1) : h_count_reg;

//        v_count_next = pixel_tick && h_count_reg == H_MAX ? (v_count_reg == V_MAX ? 0 : v_count_reg + 1) : v_count_reg;    
	end
		
    // hsync and vsync are active low signals
    // hsync signal asserted during horizontal retrace
    assign hsync_next = h_count_reg >= START_H_RETRACE				// START_H_RETRACE <= h_count_reg <= END_H_RETRACE
                        && h_count_reg <= END_H_RETRACE;			// 656 <= h_count_reg <= 751

    // vsync signal asserted during vertical retrace
    assign vsync_next = v_count_reg >= START_V_RETRACE 				// START_V_RETRACE <= v_count_reg <= END_V_RETRACE
                        && v_count_reg <= END_V_RETRACE;			// 513 <= v_count_reg <= 514

    // video only on when pixels are in both horizontal and vertical display region
    assign video_on = (h_count_reg < H_DISPLAY) 
                      && (v_count_reg < V_DISPLAY);
        
//    snake_position_array[j][k] = snake_position[j*32+k];
    always @(posedge clk) begin
	    snake_position_array[i][j] <= snake_position[i*12 + j];    
        if (i == 149 && j == 11) begin
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
    
    
    reg [9:0] temp;
    reg [9:0] apple_left_border;
    reg [9:0] apple_right_border;
    reg [9:0] apple_top_border;
    reg [9:0] apple_bottom_border;
    always @(posedge clk_25MHz) begin
        if (video_on) begin
            if (game_over) begin
                vgaRed = 4'b1111;
                vgaGreen = 4'b00000;
                vgaBlue = 4'b1111;
            end
            else begin
                vgaRed = 0;
                vgaGreen = 0;
                vgaBlue = 0; 
                //vga_portal1           
                if ((0 <= v_count_reg && v_count_reg < 32) || (464 <= v_count_reg && v_count_reg < 480) 
                || (0 <= h_count_reg && h_count_reg < 16) || (624 <= h_count_reg && h_count_reg < 640)) begin
                    vgaRed = 4'b0000;
                    vgaGreen = 4'b1111;
                    vgaBlue = 4'b0000;
                end
                else if ((((vga_apple[10:5] << 4) + 5'b10000) <= h_count_reg && h_count_reg < ((vga_apple[10:5] << 4) + 5'b10000 + 5'b10000))
                && (((vga_apple[4:0] << 4) + 6'b100000) <= v_count_reg && v_count_reg < ((vga_apple[4:0] << 4) + 6'b100000 + 5'b10000))) begin
                    vgaRed = 4'b1111;
                    vgaGreen = 4'b0000;
                    vgaBlue = 4'b0000;                        
                end   
                else if ((((vga_portal1[10:5] << 4) + 5'b10000) <= h_count_reg && h_count_reg < ((vga_portal1[10:5] << 4) + 5'b10000 + 5'b10000))
                && (((vga_portal1[4:0] << 4) + 6'b100000) <= v_count_reg && v_count_reg < ((vga_portal1[4:0] << 4) + 6'b100000 + 5'b10000))) begin
                    vgaRed = 4'b0000;
                    vgaGreen = 4'b0000;
                    vgaBlue = 4'b1111;                        
                end   
                else if ((((vga_portal2[10:5] << 4) + 5'b10000) <= h_count_reg && h_count_reg < ((vga_portal2[10:5] << 4) + 5'b10000 + 5'b10000))
                && (((vga_portal2[4:0] << 4) + 6'b100000) <= v_count_reg && v_count_reg < ((vga_portal2[4:0] << 4) + 6'b100000 + 5'b10000))) begin
                    vgaRed = 4'b0000;
                    vgaGreen = 4'b0000;
                    vgaBlue = 4'b1111;                        
                end    
                else if (((v_count_reg >= 32 && v_count_reg < V_DISPLAY) && (h_count_reg >= 16 && h_count_reg < H_DISPLAY))) begin
                    for (k = 0; k < 150; k = k + 1) begin 
                        if (snake_position_array[k][11] == 1) begin
                            x_left_border = (snake_position_array[k][10:5] << 4) + 5'b10000;  // << 4 + 32 ms dung
                            x_right_border = (snake_position_array[k][10:5] << 4) + 5'b10000 + 5'b10000;
                            y_top_border = (snake_position_array[k][4:0] << 4) + 6'b100000;
                            y_bottom_border = (snake_position_array[k][4:0] << 4) + 6'b100000 + 5'b10000; 
                            
                            if ((x_left_border <= h_count_reg && h_count_reg < x_right_border)
                            && (y_top_border <= v_count_reg && v_count_reg < y_bottom_border)) begin
                                vgaRed = 4'b1111;
                                vgaGreen = 4'b1111;
                                vgaBlue = 4'b1111;                        
                            end
                        end
                    end               
                end  
            end
        end
    end
    // output signals
    assign Hsync  = hsync_reg;
    assign Vsync  = vsync_reg;
    // assign x      = h_count_reg;
    // assign y      = v_count_reg;
    // assign p_tick = pixel_tick;
endmodule