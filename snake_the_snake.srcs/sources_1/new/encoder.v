`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// This module is a combinatoric circuit that encode decimal number into encoding for 7 segment display
//////////////////////////////////////////////////////////////////////////////////


module encoder_x(
    input [5:0] decimal_number,
    output [6:0] encoded1,
    output [6:0] encoded2
    );
    
    reg [6:0] encode_result1;
    reg [6:0] encode_result2;
    reg [5:0] ten_digit;
    reg [5:0] normal_digit;
    always @* begin // always@* means always combinatorial block
        ten_digit = decimal_number / 10;
        normal_digit = decimal_number % 10;
        if (ten_digit == 0) begin
            encode_result1 = ~7'b1111110;
        end
        else if (ten_digit == 1)
            encode_result1 = ~7'b0110000;
        else if (ten_digit == 2)
            encode_result1 = ~7'b1101101;
        else if (ten_digit == 3)
            encode_result1 = ~7'b1111001;
        else if (ten_digit == 4)
            encode_result1 = ~7'b0110011;
        else if (ten_digit == 5)
            encode_result1 = ~7'b1011011;
        else if (ten_digit == 6)
            encode_result1 = ~7'b1011111;
        else if (ten_digit == 7)
            encode_result1 = ~7'b1110000;
        else if (ten_digit == 8)
            encode_result1 = ~7'b1111111;
        else if (ten_digit == 9)
            encode_result1 = ~7'b1111011;
        
        if (normal_digit == 0) begin
            encode_result2 = ~7'b1111110;
        end
        else if (normal_digit == 1)
            encode_result2 = ~7'b0110000;
        else if (normal_digit == 2)
            encode_result2 = ~7'b1101101;
        else if (normal_digit == 3)
            encode_result2 = ~7'b1111001;
        else if (normal_digit == 4)
            encode_result2 = ~7'b0110011;
        else if (normal_digit == 5)
            encode_result2 = ~7'b1011011;
        else if (normal_digit == 6)
            encode_result2 = ~7'b1011111;
        else if (normal_digit == 7)
            encode_result2 = ~7'b1110000;
        else if (normal_digit == 8)
            encode_result2 = ~7'b1111111;
        else if (normal_digit == 9)
            encode_result2 = ~7'b1111011;
    end
    
    assign encoded1 = encode_result1;
    assign encoded2 = encode_result2;
endmodule