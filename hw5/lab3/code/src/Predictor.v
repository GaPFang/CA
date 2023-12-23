module Predictor (
    clk_i,
    rst_i,
    Branch_i,       // IFID
    IDEX_Branch,    // IDEX
    zero_i,         // IDEX
    flush_IFID,
    flush_IDEXE,
    predict_o,
    predict_PCWrite_o
);

    input clk_i;
    input rst_i;
    input Branch_i;
    input IDEX_Branch;
    input zero_i;
    reg [1:0] state;
    output reg flush_IFID;
    output reg flush_IDEXE;
    output reg predict_o;
    output reg predict_PCWrite_o;

    initial begin
        state = 2'b11;
    end

    always@(posedge clk_i or negedge rst_i) begin
        if(~rst_i) begin
            state <= 2'b11;
        end else begin
            if (IDEX_Branch == 1'b1) begin
                if (zero_i == 1'b1) begin
                    if (state != 2'b11) begin
                        state <= state + 1'b1;
                    end
                end else begin
                    if (state != 2'b00) begin
                        state <= state - 1'b1;
                    end
                end
            end
        end
    end

    always @(*) begin  
        if (IDEX_Branch == 1'b1) begin
            if (zero_i == 1'b1) begin
                if (state[1] != 1'b1) begin
                    flush_IFID = 1'b1;
                    flush_IDEXE = 1'b1;
                    predict_PCWrite_o = 1'b1;
                end else begin
                    flush_IFID = 1'b0;
                    flush_IDEXE = 1'b0;
                    predict_PCWrite_o = 1'b0;
                end
            end else begin
                if (state[1] != 1'b0) begin
                    flush_IFID = 1'b1;
                    flush_IDEXE = 1'b0;
                    predict_PCWrite_o = 1'b1;
                end else begin
                    flush_IFID = 1'b0;
                    flush_IDEXE = 1'b0;
                    predict_PCWrite_o = 1'b0;
                end
            end
        end else if (Branch_i == 1'b1) begin
            if (state[1] == 1'b1) begin
                flush_IFID = 1'b1;
            end else begin
                flush_IFID = 1'b0;
            end
            flush_IDEXE = 1'b0;
            predict_PCWrite_o = 1'b0;
        end else begin
            flush_IFID = 1'b0;
            flush_IDEXE = 1'b0;
            predict_PCWrite_o = 1'b0;
        end
        predict_o = state[1];
    end

endmodule