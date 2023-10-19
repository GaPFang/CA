module MUX32 (
    input [31:0] a,
    input [31:0] b,
    input ctl,
    output [31:0] out
);
    assign out = ctl ? a : b;

endmodule