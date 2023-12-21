`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 10:45:52 PM
// Design Name: 
// Module Name: random_apple_generator
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


module random_portal_generator(
    input clk,
    input rst,
    input generate_portal_1,
    input generate_portal_2,
    output [10:0] portal_1,
    output [10:0] portal_2
    );
    
    reg [10:0] random_portal_1;
    reg [10:0] random_portal_2;
    wire feedback1;
    wire feedback2;
    assign feedback1 = random_portal_1[10] ^ random_portal_1[8];
    assign feedback2 = random_portal_2[10] ^ random_portal_2[8];
    
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            random_portal_1 <= 11'b11110110011;
            random_portal_2 <= 11'b10000110011;
        end
        else begin
            if (generate_portal_1) begin   
                random_portal_1 <= {random_portal_1[9:0], feedback1};
            end
            if (generate_portal_2) begin   
                random_portal_2 <= {random_portal_2[9:0], feedback2};
            end
        end
    end
    
    assign portal_1 = random_portal_1;
    assign portal_2 = random_portal_2;
endmodule



















































//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 12/04/2023 10:45:52 PM
//// Design Name: 
//// Module Name: random_apple_generator
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


//module random_apple_generator(
//    input clk,
//    input rst,
//    input generate_apple,
//    input [1:0] button_pressed,
//    output [10:0] apple
//    );
    
//    reg [10:0] random;
//    reg [1:0] xorButton;
//    wire feedback;
//    assign feedback = random[10] ^ random[8];
    
//    always@(posedge clk or posedge rst) begin
//        if (rst) begin
//            random <= 11'b10100010100;
//        end
//        else begin
////            xorButton[0] = xorButton[0] ^ button_pressed[0];
////            xorButton[1] = xorButton[1] ^ button_pressed[1];
//            if (generate_apple) begin
////                random[0] <= random[1];
////                random[1] <= random[0] ^ random[2];
////                random[2] <= random[0] ^ random[3];
////                random[3] <= random[0] ^ random[4];
////                random[4] <= random[5];
////                random[5] <= random[6];
////                random[6] <= random[7];
////                random[7] <= random[8];
////                random[8] <= random[9];
////                random[9] <= random[10];
////                random[10] <= random[0];   
//                random <= {random[9:0], feedback};
//            end
//        end
//    end
    
//    assign apple = random;
//endmodule
