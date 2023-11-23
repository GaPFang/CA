module IDEX
(
    rst_i,
    clk_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i,
    ALUOp_i,
    ALUSrc_i,
    RS1_i,
    RS2_i,
    immed_i,
    fun10_i,
    RS1addr_i,
    RS2addr_i,
    RDaddr_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUOp_o,
    ALUSrc_o,
    RS1_o,
    RS2_o,
    immed_o,
    fun10_o,
    RS1addr_o,
    RS2addr_o,
    RDaddr_o
);

    input    clk_i;
    input    rst_i;
    input    RegWrite_i;
    input    MemtoReg_i;
    input    MemRead_i;
    input    MemWrite_i;
    input [1:0]   ALUOp_i;
    input    ALUSrc_i;
    input [31:0]   RS1_i;
    input [31:0]   RS2_i;
    input [31:0]   immed_i;
    input [9:0]   fun10_i;
    input [4:0]   RS1addr_i;
    input [4:0]   RS2addr_i;
    input [4:0]   RDaddr_i;
    output reg   RegWrite_o;
    output reg   MemtoReg_o;
    output reg   MemRead_o;
    output reg   MemWrite_o;
    output reg [1:0]  ALUOp_o;
    output reg   ALUSrc_o;
    output reg [31:0]  RS1_o;
    output reg [31:0]  RS2_o;
    output reg [31:0]  immed_o;
    output reg [9:0]  fun10_o;
    output reg [4:0]  RS1addr_o;
    output reg [4:0]  RS2addr_o;
    output reg [4:0]  RDaddr_o;

    initial begin
        RegWrite_o = 1'b0;
        MemtoReg_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        ALUOp_o = 2'b0;
        ALUSrc_o = 1'b0;
        RS1_o = 32'b0;
        RS2_o = 32'b0;
        immed_o = 32'b0;
        fun10_o = 10'b0;
        RS1addr_o = 5'b0;
        RS2addr_o = 5'b0;
        RDaddr_o = 5'b0;
    end

    always@(posedge clk_i or negedge rst_i) begin
        if (~rst_i) begin
            RegWrite_o <= 1'b0;
            MemtoReg_o <= 1'b0;
            MemRead_o <= 1'b0;
            MemWrite_o <= 1'b0;
            ALUOp_o <= 2'b0;
            ALUSrc_o <= 1'b0;
            RS1_o <= 32'b0;
            RS2_o <= 32'b0;
            immed_o <= 32'b0;
            fun10_o <= 10'b0;
            RS1addr_o <= 5'b0;
            RS2addr_o <= 5'b0;
            RDaddr_o <= 5'b0;
        end else begin
            RegWrite_o <= RegWrite_i;
            MemtoReg_o <= MemtoReg_i;
            MemRead_o <= MemRead_i;
            MemWrite_o <= MemWrite_i;
            ALUOp_o <= ALUOp_i;
            ALUSrc_o <= ALUSrc_i;
            RS1_o <= RS1_i;
            RS2_o <= RS2_i;
            immed_o <= immed_i;
            fun10_o <= fun10_i;
            RS1addr_o <= RS1addr_i;
            RS2addr_o <= RS2addr_i;
            RDaddr_o <= RDaddr_i;
        end
    end

endmodule