module dice_game(clock, rst, roll, dice1, dice2, win, lose, point);

input clock, rst, roll;
input [3:0] dice1, dice2;
output reg win, lose;
output reg [3:0] point;

parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10;

reg [3:0] sum;
reg [1:0] ps, ns;

always @(posedge clock) begin
    if (rst)
        ps <= s0;
    else
        ps <= ns;
end

always @(ps, roll, dice1, dice2, sum, point) begin
    win = 0;
    lose = 0;
    ns = ps;

    case (ps)
        s0: begin
            win = 0;
            lose = 0;
            point = 0;
            if (roll) begin
                sum = dice1 + dice2;
                ns = s1;
            end
        end

        s1: begin
            if (sum == 4'b0111 || sum == 4'b1011) begin
                win = 1;
                ns = s0;
            end
            else if (sum == 4'b0010 || sum == 4'b0011 || sum == 4'b1100) begin
                lose = 1;
                ns = s0;
            end
            else begin
                point = sum;
                ns = s2;
            end
        end

        s2: begin
            if (roll) begin
                sum = dice1 + dice2;
                if (sum == point) begin
                    win = 1;
                    ns = s0;
                end
                else if (sum == 4'b0111) begin
                    lose = 1;
                    ns = s0;
                end
            end
        end
    endcase
end

endmodule
