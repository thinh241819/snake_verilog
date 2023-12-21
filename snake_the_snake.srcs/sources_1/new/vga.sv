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
		output wire Hsync, Vsync,
		output reg [3:0] vgaRed,
		output reg [3:0] vgaGreen,
		output reg [3:0] vgaBlue
	);
	reg [31:0] myArray [0:2];
	reg [31:0] x_left_border;
	reg [31:0] x_right_border;
	reg [31:0] y_top_border;
	reg [31:0] y_bottom_border;
	reg [31:0] i;


	initial begin
//	    i = 0;
//		x_left_border = 0;
//		x_right_border = 0;
//		y_top_border = 0;
//		y_bottom_border = 0;
		myArray[0][15:0] = 3'b111;
		myArray[0][31:16] = 3'b111;
		
		myArray[1][15:0] = 3;
		myArray[1][31:16] = 4;

		myArray[2][15:0] = 5;
		myArray[2][31:16] = 6;
	end
	
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
	
	// mod-4 counter to generate 25 MHz pixel tick
	reg [1:0] pixel_reg;
	wire [1:0] pixel_next;
	wire pixel_tick;
	
	always @(posedge clk, posedge reset)
		if(reset)
		  pixel_reg <= 0;
		else
		  pixel_reg <= pixel_next;
	
	assign pixel_next = pixel_reg + 1; // increment pixel_reg 
	
	assign pixel_tick = (pixel_reg == 0); // assert tick 1/4 of the time
	
	// registers to keep track of current pixel location
	reg [9:0] h_count_reg, h_count_next, v_count_reg, v_count_next;
	
	// register to keep track of vsync and hsync signal states
	reg vsync_reg, hsync_reg;
	wire vsync_next, hsync_next;
 
	// infer registers
	always @(posedge clk, posedge reset)
		if(reset)
		    begin
                    v_count_reg <= 0;
                    h_count_reg <= 0;
                    vsync_reg   <= 0;
                    hsync_reg   <= 0;
		    end
		else
		    begin
                    v_count_reg <= v_count_next;
                    h_count_reg <= h_count_next;
                    vsync_reg   <= vsync_next;
                    hsync_reg   <= hsync_next;
		    end
			
	// next-state logic of horizontal vertical sync counters
	always @*
		begin
		h_count_next = pixel_tick ? 
		               h_count_reg == H_MAX ? 0 : h_count_reg + 1
			       : h_count_reg;
		
		v_count_next = pixel_tick && h_count_reg == H_MAX ? 
		               (v_count_reg == V_MAX ? 0 : v_count_reg + 1) 
			       : v_count_reg;
		end
		
        // hsync and vsync are active low signals
        // hsync signal asserted during horizontal retrace
        assign hsync_next = h_count_reg >= START_H_RETRACE				// START_H_RETRACE <= h_count_reg <= END_H_RETRACE
                            && h_count_reg <= END_H_RETRACE;			// 656 <= h_count_reg <= 751
   
        // vsync signal asserted during vertical retrace
        assign vsync_next = v_count_reg >= START_V_RETRACE 				// START_V_RETRACE <= v_count_reg <= END_V_RETRACE
                            && v_count_reg <= END_V_RETRACE;			// 513 <= v_count_reg <= 514

        // video only on when pixels are in both horizontal and vertical display region
        //assign video_on = (h_count_reg < H_DISPLAY) 
        //                  && (v_count_reg < V_DISPLAY);
		always @(*)
		begin
			// first check if we're within vertical active video range
			myArray[0][15:0] = 3;
			myArray[0][31:16] = 3;
			myArray[1][15:0] = 4;
            myArray[1][31:16] = 4;
			myArray[2][15:0] = 5;
            myArray[2][31:16] = 5;            
			if ((v_count_reg >= 0 && v_count_reg < V_DISPLAY))
			begin
				// now display different colors every 80 pixels
				// while we're within the active horizontal range
				// -----------------
				// display white bar
				for (i = 0; i < 3; i = i + 1) begin
					x_left_border = myArray[i][15:0] << 3;
					x_right_border = (myArray[i][15:0] << 3) + 4'b1000;
					y_top_border = (myArray[i][31:16] << 3) + 6'b100000;
					y_bottom_border = (myArray[i][31:16] << 3) + 6'b100000 + 4'b1000;
					if ((x_left_border <= h_count_reg && h_count_reg < x_right_border)
					&& (y_top_border <= v_count_reg && v_count_reg < y_bottom_border)) begin
						vgaRed = 4'b1111;
						vgaGreen = 4'b1111;
						vgaBlue = 4'b1111;						
					end
				end
				// // we're outside active horizontal range so display black
				// else
				// begin
				// 	vgaRed = 0;
				// 	vgaGreen = 0;
				// 	vgaBlue = 0;
				// end
			end
			// we're outside active vertical range so display black
			else
			begin
				vgaRed = 0;
				vgaGreen = 0;
				vgaBlue = 0;
			end
		end
        // output signals
        assign Hsync  = hsync_reg;
        assign Vsync  = vsync_reg;
        // assign x      = h_count_reg;
        // assign y      = v_count_reg;
        // assign p_tick = pixel_tick;
endmodule