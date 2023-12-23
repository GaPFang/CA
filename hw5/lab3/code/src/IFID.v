module IFID
(
    stall_i,
    flush_i,
    rst_i,
    clk_i,
    pc_i,
    instr_i,
    pc_o,
    instr_o
);

    input               stall_i;
    input               flush_i;
    input               rst_i;
    input               clk_i;
    input   [31:0]      pc_i;
    input   [31:0]      instr_i;
    output reg [31:0]   pc_o;
    output reg [31:0]   instr_o;

    initial begin
        pc_o = 32'b0;
        instr_o = 32'b0;
    end

    always@(posedge clk_i or negedge rst_i) begin
        if (~rst_i || flush_i == 1'b1) begin
            pc_o <= 32'b0;
            instr_o <= 32'b0;
        end else begin
            if (stall_i == 1'b0) begin
                pc_o <= pc_i;
                instr_o <= instr_i;
            end
        end
    end

endmodule