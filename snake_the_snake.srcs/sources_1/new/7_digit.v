module number_to_7_segment(
    input clk_100MHz,
    input [6:0] digit_1_encoded,
    input [6:0] digit_2_encoded,
    input [6:0] digit_3_encoded,
    input [6:0] digit_4_encoded,
    output [6:0] seg,
    output [3:0] an
    );
    
    reg [3:0] an_output;
    reg [6:0] seg_output;
    reg [3:0] temp1;
    reg [6:0] temp2;
    reg hello;
    
    reg [1:0] digit_select;
    reg [16:0] digit_timer;
    initial begin
        digit_select = 0;
        digit_timer = 0;
        seg_output = 7'b0000000;
    end
    
    always @(posedge clk_100MHz) begin
        if (digit_timer == 99_999) begin
            digit_timer <= 0;
            digit_select <= digit_select + 1;
        end
        else begin
            digit_timer <= digit_timer + 1;
        end
    end
    
    always @* begin
        case(digit_select)
            0: begin
                an_output = 4'b1110;
                seg_output = digit_1_encoded;
            end
            1: begin
                an_output = 4'b1101;
                seg_output = digit_2_encoded;
            end
            2: begin
                an_output = 4'b1011;
                seg_output = digit_3_encoded;
            end
            3: begin
                an_output = 4'b0111;
                seg_output = digit_4_encoded;
            end
        endcase
    end
    assign an = an_output;
    assign seg = seg_output;
endmodule
