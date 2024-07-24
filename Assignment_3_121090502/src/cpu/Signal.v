`timescale 1ns / 10ps
module control_signal (opcode , funct , ID_EX_flush , zero_flag , RegDst , Branch , Memread , MemtoReg , ALUop , Memwrite , ALUSrc , Regwrite , sign_ext , IF_flush , PC_BRCH_INTO , JUMPSIGN);
    input[5:0] opcode , funct;
    input ID_EX_flush , zero_flag;
    output reg RegDst , Branch , Memread , MemtoReg , ALUop , Memwrite , ALUSrc , Regwrite , sign_ext , IF_flush , PC_BRCH_INTO , JUMPSIGN;

    initial begin
        IF_flush = 0;
    end
    always @(opcode , funct , ID_EX_flush) begin
        case (ID_EX_flush)
        1'b0: begin
            RegDst <= 0;
            Branch <= 0;
            Memread <= 0;
            MemtoReg <= 0;
            ALUop <= 0;
            Memwrite <= 0;
            ALUSrc <= 0;
            Regwrite <= 0;
            sign_ext <= 0;
            JUMPSIGN <= 0;
        end
        1'b1: begin
            case(opcode)
            6'b000000: begin
                case (funct)
                6'b100000: begin      //add function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b100001: begin      //addu function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b100100: begin      //and function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b100111: begin      //nor function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b100101: begin      //or function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b000000: begin      //sll function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b000100: begin      //sllv function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b000011: begin      //sra function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b000111: begin      //srav function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b000010: begin      //srl function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b000110: begin      //srlv function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end  
                6'b100010: begin      //sub function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b100011:begin       //subu function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b100110:begin       //xor function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b101010:begin       //slt function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b101011:begin       //sltu function
                    RegDst <= 1;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 1;
                    sign_ext <= 0;
                    JUMPSIGN <= 0;
                end
                6'b001000:begin       //jr function
                    RegDst <= 0;
                    Branch <= 0;
                    Memread <= 0;
                    MemtoReg <= 0;
                    ALUop <= 0;
                    Memwrite <= 0;
                    ALUSrc <= 0;
                    Regwrite <= 0;
                    sign_ext <= 0;
                    JUMPSIGN <= 1;
                end
                default:;
                endcase
            end
            6'b001000: begin          //addi function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 1;
                Regwrite <= 1;
                sign_ext <= 1;
                JUMPSIGN <= 0;
            end
            6'b001001: begin          //addiu function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 1;
                Regwrite <= 1;
                sign_ext <= 1;
                JUMPSIGN <= 0;
            end
            6'b001100: begin          //andi function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 1;
                Regwrite <= 1;
                sign_ext <= 0;
                JUMPSIGN <= 0;
            end
            6'b001101: begin          //ori function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 1;
                Regwrite <= 1;
                sign_ext <= 0;
                JUMPSIGN <= 0;
            end
            6'b001110: begin          //xori function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 1;
                Regwrite <= 1;
                sign_ext <= 0;
                JUMPSIGN <= 0;
            end
            6'b000100: begin          //beq function
                RegDst <= 0;
                Branch <= 1;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 0;
                Regwrite <= 0;
                sign_ext <= 0;
                JUMPSIGN <= 0;
            end
            6'b000101: begin          //bne function
                RegDst <= 0;
                Branch <= 1;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 0;
                Regwrite <= 0;
                sign_ext <= 0;
                JUMPSIGN <= 0;
            end
            6'b001010: begin          //slti function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 1;
                Regwrite <= 1;
                sign_ext <= 1;
                JUMPSIGN <= 0;
            end
            6'b001011: begin          //sltiu function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 1;
                Regwrite <= 1;
                sign_ext <= 1;
                JUMPSIGN <= 0;
            end
            6'b100011: begin          //lw function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 1;
                MemtoReg <= 1;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 1;
                Regwrite <= 1;
                sign_ext <= 0;
                JUMPSIGN <= 0;
            end
            6'b101011: begin          //sw function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 1;
                ALUSrc <= 1;
                Regwrite <= 0;
                sign_ext <= 0;
                JUMPSIGN <= 0;
            end
            6'b000010: begin          //j function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 0;
                Regwrite <= 0;
                sign_ext <= 0;
                JUMPSIGN <= 1;
            end
            6'b000011: begin          //jal function
                RegDst <= 0;
                Branch <= 0;
                Memread <= 0;
                MemtoReg <= 0;
                ALUop <= 0;
                Memwrite <= 0;
                ALUSrc <= 0;
                Regwrite <= 1;
                sign_ext <= 0;
                JUMPSIGN <= 1;
            end
            default:; 
            endcase
        end
        default:;
        //$display ("No such ID_EX_flush value")
        endcase
    end
    always @(Branch , zero_flag , JUMPSIGN) begin
        PC_BRCH_INTO = (Branch & zero_flag);
        if(PC_BRCH_INTO == 1 || JUMPSIGN == 1) IF_flush = 1;
        else IF_flush = 0;
    end
endmodule