`timescale 1ns / 10ps

module IF_ID_buffer(
    input [31:0] INSTRUCTION,
    input [31:0] NEW_PC,
    input IF_flush,
    input IF_ID_write,
    input CLK,
    input ENABLE,
    output reg [31:0] next_PC,
    output reg [31:0] instruction_F
    );

    always @(posedge CLK) begin
        if (ENABLE == 1) begin
            if(IF_flush == 1) begin
                next_PC <= NEW_PC;
                instruction_F <= 0;
            end
            else if(IF_ID_write == 1) begin
                next_PC <= NEW_PC;
                instruction_F <= INSTRUCTION;
            end
            else begin
                next_PC <= next_PC;
                instruction_F <= instruction_F;
            end
        end
    end
endmodule

module ID_EX_buffer (
    CLK , read_data1 , read_data2 , rs , rt , rd , imme , opcode , shamt , funct , target , next_PC , 
    RegDstD , MemreadD , MemtoRegD , ALUopD , MemwriteD , ALUSrcD , RegwriteD  , sign_extD,
    RegDstE , MemreadE , MemtoRegE , ALUopE , MemwriteE , ALUSrcE , RegwriteE  , sign_extE,
    read_data_E1 , read_data_E2 , imme_E , rs_E , rt_E , rd_E , opcode_E , shamt_E , funct_E , target_E , next_PC_E);
    input[31:0] read_data1 , read_data2 , next_PC;
    input[5:0] opcode , funct;
    input[4:0] rs , rt , rd , shamt;
    input CLK;
    input RegDstD , MemreadD , MemtoRegD , ALUopD , MemwriteD , ALUSrcD , RegwriteD , sign_extD;
    input[15:0] imme;
    input[25:0] target;
    output reg[31:0] read_data_E1 , read_data_E2 , next_PC_E;
    output reg[5:0] opcode_E , funct_E;
    output reg[4:0] rs_E , rt_E , rd_E , shamt_E;
    output reg RegDstE , MemreadE , MemtoRegE , ALUopE , MemwriteE , ALUSrcE , RegwriteE , sign_extE;
    output reg[15:0] imme_E;
    output reg[25:0] target_E;

    always @(posedge CLK) begin
        read_data_E1 <= read_data1;
        read_data_E2 <= read_data2;
        imme_E <= imme;
        opcode_E <= opcode;
        shamt_E <= shamt;
        funct_E <= funct;
        rs_E <= rs;
        rt_E <= rt;
        rd_E <= rd;
        RegDstE <= RegDstD;
        MemreadE <= MemreadD;
        MemtoRegE <= MemtoRegD;
        ALUopE <= ALUopD;
        MemwriteE <= MemwriteD;
        ALUSrcE <= ALUSrcD;
        RegwriteE <= RegwriteD;
        sign_extE <= sign_extD;
        target_E <= target;
        next_PC_E <= next_PC;
    end
endmodule

module EX_MEM_buffer (CLK , ALU_result , MemreadE , MemtoRegE , MemwriteE , RegwriteE , write_register , read_data_E2 , 
                            ALU_resultM , MemreadM , MemtoRegM , MemwriteM , RegwriteM , write_registerM , read_data_M2);
    input CLK;
    input MemreadE , MemtoRegE , MemwriteE , RegwriteE;
    input[31:0] ALU_result;
    input[4:0] write_register;
    input[31:0] read_data_E2;
    output reg MemreadM , MemtoRegM , MemwriteM , RegwriteM;
    output reg[31:0] ALU_resultM;
    output reg[4:0] write_registerM;
    output reg[31:0] read_data_M2;

    always @(negedge CLK) begin
        ALU_resultM <= ALU_result;
        write_registerM <= write_register;
        MemreadM <= MemreadE;
        MemtoRegM <= MemtoRegE;
        MemwriteM <= MemwriteE;
        RegwriteM <= RegwriteE;
        read_data_M2 <= read_data_E2;
    end
endmodule

module MEM_WB_buffer (CLK , MemtoRegM , RegwriteM , write_registerM , ALU_resultM , Memdata,
                            MemtoRegW , RegwriteW , write_registerW , ALU_resultW , MemdataW);
    input CLK;
    input MemtoRegM , RegwriteM;
    input[31:0] ALU_resultM , Memdata;
    input[4:0] write_registerM;
    output reg MemtoRegW , RegwriteW;
    output reg[31:0] ALU_resultW , MemdataW;
    output reg[4:0] write_registerW;
    always @(negedge CLK) begin
        MemtoRegW <= MemtoRegM;
        RegwriteW <= RegwriteM;
        ALU_resultW <= ALU_resultM;
        MemdataW <= Memdata;
        write_registerW <= write_registerM;
    end
endmodule