`timescale 1ns / 10ps

module ALU (
    opcode_E , shamt_E , funct_E , next_PC_E ,  read_data_E1 , read_data_E2 , ALU_resultM , write_data , imme_E , sign_extE, rs_source , rt_source , ALUSrcE , Flag , ALU_result 
);
    input[31:0] read_data_E1 , read_data_E2 , ALU_resultM , write_data , next_PC_E;
    input[5:0] opcode_E , funct_E;
    input[4:0] shamt_E;
    input[15:0] imme_E;
    input ALUSrcE , sign_extE;
    input[1:0] rs_source , rt_source;
    output[31:0] ALU_result;
    output reg[2:0] Flag;

    reg[31:0] RS , RT , imme , Result;
    wire[31:0] result1 , result2 , result3 , result4 , result5 , result6 , result7 , result8 , result9 , result10;
    wire[31:0] result11 , result12 , result13 , result14 , result15 , result16 , result17 , result18 , result19 , result20;
    wire[31:0] result21 , result22 , result23 , result24 , result25 , result26 , result27 , result28 , result29 , result30;
    wire[2:0] flag1 , flag2 , flag3 , flag4 , flag5 , flag6 , flag7 , flag8 , flag9 , flag10;
    wire[2:0] flag11 , flag12 , flag13 , flag14 , flag15 , flag16 , flag17 , flag18 , flag19 , flag20;
    wire[2:0] flag21, flag22 , flag23 , flag24 , flag25 , flag26 , flag27 , flag28 , flag29 , flag30;
    

    always @(rs_source , read_data_E1 , ALU_resultM , write_data) begin
        if (rs_source == 2'b00) begin
            RS <= read_data_E1;
        end
        else if(rs_source == 2'b10)begin
            RS <= ALU_resultM;
        end
        else if(rs_source == 2'b01)begin
            RS <= write_data;
        end
    end

    reg[31:0] ext_imme;
    wire[31:0] sign_extend_imme;
    wire[31:0] unsign_extend_imme;
    assign sign_extend_imme = $signed(imme_E);
    assign unsign_extend_imme = imme_E;

    always @(imme_E) begin        //extend the imme number accorfing to the instruction requirment
        if(sign_extE == 1)begin
            ext_imme <= sign_extend_imme;
        end
        else if(sign_extE == 0) begin
            ext_imme <= unsign_extend_imme;
        end
    end

    always @(ALUSrcE , rt_source , read_data_E1 , ALU_resultM , write_data , ext_imme) begin
        if(ALUSrcE == 0) begin
            if (rt_source == 2'b00) begin
                RT <= read_data_E2;
            end
            else if(rt_source == 2'b10)begin
                RT <= ALU_resultM;
            end
            else if(rt_source == 2'b01)begin
                RT <= write_data;
            end
        end
        else if(ALUSrcE == 1) begin
            RT <= ext_imme;
        end
    end

    add Add(RS , RT , result1 , flag1);
    addu Addu(RS , RT , result2 , flag2);
    And AND(RS , RT , result3 , flag3);
    Nor NOR(RS , RT , result4 , flag4);
    Or OR(RS , RT , result5 , flag5);
    sll Sll(RT , result6 , shamt_E , flag6);
    sllv Sllv(RS , RT , result7 , flag7);
    sra Sra(RT , result8 , shamt_E , flag8);
    srav Srav(RS , RT , result9 , flag9);
    srl Srl(RT , result10 , shamt_E , flag10);
    srlv Srlv(RS , RT , result11 , flag11);
    sub Sub(RS , RT , result12 , flag12);
    subu Subu(RS , RT , result13 , flag13);
    Xor XOR(RS , RT , result14 , flag14);
    slt Slt(RS , RT , result15 , flag15);
    sltu Sltu(RS , RT , result16 , flag16);
    addi Addi(RS , RT , result17 , flag17);
    addiu Addiu(RS , RT , result18 , flag18);
    andi Andi(RS , RT , result19 , flag19);
    ori Ori(RS , RT , result20 , flag20);
    xori Xori(RS , RT , result21 , flag21);
    beq Beq(RS , RT , result22 , flag22);
    bne Bne(RS , RT , result23 , flag23);
    slti Slti(RS , RT , result24 , flag24);
    sltiu Sltiu(RS , RT , result25 , flag25);
    lw Lw(RS , RT , result26 , flag26);
    sw Sw(RS , RT , result27 , flag27);
    jal Jal(next_PC_E , result28 , flag28);


    always @(*) begin
        case (opcode_E)
        6'b000000: begin
            case (funct_E)
            6'b100000: begin      //add function
                Result = result1;
                Flag = flag1;
            end
            6'b100001: begin      //addu function
                Result = result2;
                Flag = flag2;
            end
            6'b100100: begin      //and function
                Result = result3;
                Flag = flag3;
            end
            6'b100111: begin      //nor function
                Result = result4;
                Flag = flag4;
            end
            6'b100101: begin      //or function
                Result = result5;
                Flag = flag5;
            end
            6'b000000: begin      //sll function
                Result = result6;
                Flag = flag6;
            end
            6'b000100: begin      //sllv function
                Result = result7;
                Flag = flag7;
            end
            6'b000011: begin      //sra function
                Result = result8;
                Flag = flag8;
            end
            6'b000111: begin      //srav function
                Result = result9;
                Flag = flag9;
            end
            6'b000010: begin      //srl function
                Result = result10;
                Flag = flag10;
            end
            6'b000110: begin      //srlv function
                Result = result11;
                Flag = flag11;
            end  
            6'b100010: begin      //sub function
                Result = result12;
                Flag = flag12;
            end
            6'b100011:begin       //subu function
                Result = result13;
                Flag = flag13;
            end
            6'b100110:begin       //xor function
                Result = result14;
                Flag = flag14;
            end
            6'b101010:begin       //slt function
                Result = result15;
                Flag = flag15;
            end
            6'b101011:begin       //sltu function
                Result = result16;
                Flag = flag16;
            end
            6'b001000:begin       //jr function
                Result = 0;
                Flag = flag2;
            end
            default: Result = 0;
            endcase
        end
        6'b001000: begin          //addi function
                Result = result17;
                Flag = flag17;
        end
        6'b001001: begin          //addiu function
                Result = result18;
                Flag = flag18;
        end
        6'b001100: begin          //andi function
                Result = result19;
                Flag = flag19;
        end
        6'b001101: begin          //ori function
                Result = result20;
                Flag = flag20;
        end
        6'b001110: begin          //xori function
                Result = result21;
                Flag = flag21;
        end
        6'b000100: begin          //beq function
                Result = result22;
                Flag = flag22;
        end
        6'b000101: begin          //bne function
                Result = result23;
                Flag = flag23;
        end
        6'b001010: begin          //slti function
                Result = result24;
                Flag = flag24;
        end
        6'b001011: begin          //sltiu function
                Result = result25;
                Flag = flag25;
        end
        6'b100011: begin          //lw function
                Result = result26;
                Flag = flag26;
        end
        6'b101011: begin          //sw function
                Result = result27;
                Flag = flag27;
        end
        6'b000010: begin          //j function
                Result = 0;
                Flag = flag2;
        end
        6'b000011: begin          //jal function
                Result = result28;
                Flag = flag28;
        end
        default: Result = 0;
        endcase
    end
    assign ALU_result = Result;
endmodule

module add_checkoverflow (
    rs , rt , overflow
);
    input[31:0] rs , rt;
    output overflow;

    reg c;
    integer result , RS , RT;
    always @(*)begin
        RS = rs;
        RT = rt;
        result = rs + rt;
    end
    
    always @(*) begin
        if (RS > 0 && RT > 0 && (result <= 0)) c = 1;
        else if (RS < 0 && RT < 0 && (result >= 0)) c = 1;
        else c = 0;
    end
    assign overflow = c;
endmodule

module sub_checkoverflow (
    rs , rt , overflow
);
    input[31:0] rs , rt;
    output overflow;

    reg c;
    integer result , RS , RT;
    always @(*)begin
        RS = rs;
        RT = rt;
        result = rs - rt;
    end
    
    always @(*) begin
        if (RS > 0 && RT < 0 && (result <= 0)) c = 1;
        else if (RS < 0 && RT > 0 && (result >= 0)) c = 1;
        else c = 0;
    end
    assign overflow = c;
endmodule

module add (
    rs, rt, result , flag
);
   input[31:0] rs , rt;
   output[31:0] result;
   output[2:0] flag;
   wire over_flow;
   add_checkoverflow Overflow(rs , rt , over_flow);
   assign flag[2] = over_flow;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign result = rs + rt;
endmodule

module addi (
    rs , rt_imme , result , flag
);
   input[31:0] rs , rt_imme;
   output[31:0] result;
   output[2:0] flag;
   wire over_flow;
   add_checkoverflow Overflow(rs , rt_imme , over_flow);
   assign flag[2] = over_flow;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign result = rs + rt_imme;
endmodule

module addu (
    rs, rt, result , flag
);
   input[31:0] rs , rt;
   output[31:0] result;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign result = rs + rt;
endmodule

module addiu (
    rs , rt_imme , result , flag
);
   input[31:0] rs , rt_imme;
   output[31:0] result;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign result = rs + rt_imme;
endmodule

module sub (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   wire over_flow;
   sub_checkoverflow Overflow(rs , rt , over_flow);
   assign flag[2] = over_flow;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs - rt;
endmodule

module subu (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs - rt;
endmodule

module And (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs & rt;
endmodule

module andi (
    rs , rt_imme , reuslt, flag
);
   input[31:0] rs , rt_imme;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs & rt_imme;
endmodule

module Or (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs | rt;
endmodule

module ori (
    rs , rt_imme , reuslt , flag
);
   input[31:0] rs , rt_imme;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs | rt_imme;
endmodule

module Xor (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs ^ rt;
endmodule

module xori (
    rs , rt_imme , reuslt , flag
);
   input[31:0] rs , rt_imme;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs ^ rt_imme;
endmodule

module Nor (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = ~(rs | rt);
endmodule

module beq (
    rs, rt , result , flag
);
   input[31:0] rs , rt;
   input[15:0] imme;
   output[2:0] flag;
   output[31:0] result;
   reg c;
   always @(rs or rt) begin
        if (rs == rt) c = 1;
        else c = 0;
    end
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = c;
   assign result = flag[0];
endmodule

module bne (
    rs, rt , result , flag
);
   input[31:0] rs , rt;
   input[15:0] imme;
   output[2:0] flag;
   output[31:0] result;
   reg c;
   always @(rs or rt) begin
        if (rs == rt) c = 1;
        else c = 0;
    end
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = c;
   assign result = 1-flag[0];
endmodule

module slt (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output reg[31:0] reuslt;
   output[2:0] flag;
   wire over_flow;
   reg negative;
   integer RS , RT;
   sub_checkoverflow Overflow(rs , rt , over_flow);
   assign flag[2] = over_flow;
   always @(rs or rt) begin
       RS = rs;
       RT = rt;
       if ($signed(RS - RT) < 0) begin
           negative = 1;
           reuslt = 1;
       end 
       else begin
           negative = 0;
           reuslt = 0;
       end  
   end
   assign flag[1] = negative;
   assign flag[0] = 0;
endmodule

module slti (
    rs, rt_imme, reuslt , flag
);
   input[31:0] rs , rt_imme;
   output reg[31:0] reuslt;
   output[2:0] flag;
   wire over_flow;
   reg negative;
   integer RS , RT;
   sub_checkoverflow Overflow(rs , rt_imme , over_flow);
   assign flag[2] = over_flow;
   always @(rs or rt_imme) begin
       RS = rs;
       RT = rt_imme;
       if ($signed(RS - RT) < 0) begin
           negative = 1;
           reuslt = 1;
       end 
       else begin
           negative = 0;
           reuslt = 0;
       end  
   end
   assign flag[1] = negative;
   assign flag[0] = 0;
endmodule

module sltu (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output reg[31:0] reuslt;
   output[2:0] flag;
   reg negative;
   always @(rs or rt) begin
       if ($signed($unsigned(rs) - $unsigned(rt)) < 0) begin
           negative = 1;
           reuslt = 1;
       end 
       else begin
           negative = 0;
           reuslt = 0;
       end  
   end
   assign flag[2] = 0;
   assign flag[1] = negative;
   assign flag[0] = 0;
endmodule

module sltiu (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output reg[31:0] reuslt;
   output[2:0] flag;
   reg negative;
   always @(rs or rt) begin
       if ($signed($unsigned(rs) - $unsigned(rt)) < 0) begin
           negative = 1;
           reuslt = 1;
       end 
       else begin
           negative = 0;
           reuslt = 0;
       end  
   end
   assign flag[2] = 0;
   assign flag[1] = negative;
   assign flag[0] = 0;
endmodule

module lw (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs + rt;
endmodule

module sw (
    rs, rt, reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rs + rt;
endmodule

module sll (
    rt , reuslt , shamt , flag
);
   input[31:0] rt;
   input[4:0] shamt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rt << shamt;
endmodule

module sllv (
   rs , rt , reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rt << ($unsigned(rs) & 32'b00000000000000000000000000011111);
endmodule

module srl (
    rt , reuslt , shamt , flag
);
   input[31:0] rt;
   input[4:0] shamt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rt >> shamt;
endmodule

module srlv (
   rs , rt , reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = rt >> ($unsigned(rs) & 32'b00000000000000000000000000011111);
endmodule

module sra (
    rt , reuslt , shamt , flag
);
   input[31:0] rt;
   input[4:0] shamt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = $signed(rt) >>> shamt;
endmodule

module srav (
   rs , rt , reuslt , flag
);
   input[31:0] rs , rt;
   output[31:0] reuslt;
   output[2:0] flag;
   assign flag[2] = 0;
   assign flag[1] = 0;
   assign flag[0] = 0;
   assign reuslt = $signed(rt) >>> ($unsigned(rs) & 32'b00000000000000000000000000011111);
endmodule

module jal (next_PC_E, result , flag);
    input[31:0] next_PC_E;
    output[31:0] result;
    output[2:0] flag;
    assign flag[2] = 0;
    assign flag[1] = 0;
    assign flag[0] = 0;
    assign result = next_PC_E;
endmodule


