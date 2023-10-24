module Sign_Extend (in, out);

    input [11:0] in;
    output reg [31:0] out;

    always @(*) begin
        if (in[11]) begin
            out = {{20{1'b1}}, in};
        end else begin
            out = {20'b0, in};
        end
    end

endmodule