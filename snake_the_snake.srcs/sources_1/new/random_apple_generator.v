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


module random_apple_generator(
    input clk,
    input rst,
    input generate_apple,
    output [10:0] apple
    );
    
    reg [10:0] random;
    wire feedback;
    assign feedback = random[10] ^ random[8];
    
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            random <= 11'b10011011001;
        end
        else begin
            if (generate_apple) begin  
                random <= {random[9:0], feedback};
            end
        end
    end
    
    assign apple = random;
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
