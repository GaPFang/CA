module Flush (
    RS1,
    RS2,
    Branch,
    flush
);

    input [31:0] RS1;
    input [31:0] RS2;
    input Branch;
    output reg flush;

    initial begin
        flush = 1'b0;
    end

    always @(*) begin
        if (Branch == 1'b1 && (RS1 == RS2)) begin
            flush = 1'b1;
        end else begin
            flush = 1'b0;
        end
    end

endmodule