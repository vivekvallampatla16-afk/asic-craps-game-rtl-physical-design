module dg_tb();

reg clock, rst, roll;
reg [3:0] dice1, dice2;
wire win, lose;
wire [3:0] point;

dice_game d1 (
    .clock(clock),
    .rst(rst),
    .roll(roll),
    .dice1(dice1),
    .dice2(dice2),
    .win(win),
    .lose(lose),
    .point(point)
);

initial begin
    clock = 1'b0;
    rst = 1'b1;
    dice1 = 0;
    dice2 = 0;
    #10 rst = 0;

    $monitor($time,
        " clock=%b rst=%b roll=%b dice1=%d dice2=%d win=%b lose=%b point=%b",
        clock, rst, roll, dice1, dice2, win, lose, point);
end

always #5 clock = ~clock;

initial begin
    #10 roll = 1; dice1 = 4; dice2 = 3;
    #10 roll = 1; dice1 = 1; dice2 = 1;
    #10 roll = 1; dice1 = 3; dice2 = 3;
    #10 roll = 1; dice1 = 3; dice2 = 3;
    #10 roll = 1; dice1 = 5; dice2 = 4;
    #10 roll = 1; dice1 = 3; dice2 = 4;
    #10 roll = 1; dice1 = 6; dice2 = 5;
end

endmodule
