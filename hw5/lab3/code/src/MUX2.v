module MUX2 (a, b, c, d, ctl, out);

    input [31:0] a;
    input [31:0] b;
    input [31:0] c;
    input [31:0] d;
    input [1:0] ctl;
    output [31:0] out;

    assign out = ctl[1] ? (ctl[0] ? d : c) : (ctl[0] ? b : a);

endmodule