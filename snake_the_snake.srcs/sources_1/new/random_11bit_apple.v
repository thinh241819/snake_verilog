module random_11bit_apple (
    input clk,
    input rst,
    input generate_apple,
    output [10:0] apple ,
    output [3:0] count_shift
    );

wire feedback; 

reg [10:0] random, random_next, random_done;
reg [3:0] count, count_next; //to keep track of the shifts
reg apple_done_reg;
assign feedback = random[10] ^ random[8];

always @ (posedge clk or posedge rst) begin
	if (rst) begin
		random <= 11'b00011111111; //An LFSR cannot have an all 0 state, thus reset to FF
		count <= 0;
		apple_done_reg <= 0;
	end
    else if (generate_apple) begin
        count <= 0;
        apple_done_reg <= 0;
    end
    else begin
//        if (count != 12) begin
//            random_next = random; //default state stays the same
//            count_next = count;
                
//            random_next = {random[9:0], feedback}; //shift left the xor'd every posedge clk
//            count_next = count + 1;
//        end	   
//        if (count <= 11) begin
//            random <= random_next;
//            count <= count_next;
//        end
//        if (count == 11) begin
//            count = 12;
//            random_done = random; //assign the random number to output after 13 shifts
//            apple_done_reg = 1'b1;
//        end
	end
end

//always @ (*) begin
//    if (count != 12) begin
//        random_next = random; //default state stays the same
//        count_next = count;
            
//        random_next = {random[9:0], feedback}; //shift left the xor'd every posedge clk
//        count_next = count + 1;
//    end

//	if (count == 11) begin
//		count = 12;
//		random_done = random; //assign the random number to output after 13 shifts
//		apple_done_reg = 1'b1;
//	end
//end


assign apple = random_done;
assign apple_done = apple_done_reg;

endmodule