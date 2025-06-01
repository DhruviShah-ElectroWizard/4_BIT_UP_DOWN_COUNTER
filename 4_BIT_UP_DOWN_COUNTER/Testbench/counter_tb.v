`timescale 1ns / 1ps
`include "counter_rtl.v"

module tb_up_down_counter;

reg clk;
reg reset;
reg up_down;
wire [3:0] count;

up_down_counter uut (
    .clk(clk),
    .reset(reset),
    .up_down(up_down),
    .count(count)
);

// Clock generation: 10 ns period
always #5 clk = ~clk;

initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    up_down = 1;

    // Hold reset for a while
    #10;
    reset = 0;

    // Count up for 16 cycles
    up_down = 1;
    repeat (16) #10;

    // Count down for 16 cycles
    up_down = 0;
    repeat (16) #10;

    // Apply reset in between
    reset = 1;
    #10;
    reset = 0;

    // Count up again
    up_down = 1;
    repeat (8) #10;

    $stop; // End of simulation
end

endmodule



