`default_nettype none

module prescaler(input in_clk, output out_clk);
    // 1 @ 25 Mhz
    parameter counter_max = 25000000;
    // = math.ceil(math.log2( counter_max ))
    parameter counter_bits = 25;

    logic [counter_bits-1:0] devider;

    always_ff @(posedge in_clk)
    begin
        if(devider == counter_max)
        begin
            devider <= 0;
            out_clk <= 1;
        end
        else
        begin
            devider <= devider + 1;
            out_clk <= 0;
        end
    end
endmodule // prescaler

module top(
    input clkin, // input clock: 25 Mhz
    output  [0:3] led,
    );

logic clk1hz;
logic [0:3] ctr = 4'b0000;

assign led[0] = ctr[0];
assign led[1] = ctr[1];
assign led[2] = ctr[2];
assign led[3] = ctr[3];

// 25 Mhz => 1 Hz
prescaler #(.counter_max(25000000), .counter_bits(25))
    clk1hz_ps(
        .in_clk(clkin),
        .out_clk(clk1hz));

always_ff @(posedge clk1hz)
begin
    if(ctr == 4'b1111)
    begin
        ctr <= 4'b0000;
    end
    else
    begin
        ctr <= ctr + 1;
    end
end

endmodule
