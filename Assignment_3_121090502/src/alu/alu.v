// instruction: 32-bit instruction
// regA/B: 32-bit data in registerA(addr=00000), registerB(addr=00001)
// result: 32-bit result of Alu execution
// flags: 3-bit alu flag
 
module alu(input[31:0] instruction, input[31:0] regA, input[31:0] regB, output[31:0] result, output[2:0] flags);
    
    reg[5:0] shamt_reg;
    reg[5:0] opcode,func;
    reg[31:0] temp_result;
    reg[2:0] flag;  // flag[2] : zero flag
                    // flag[1] : negative flag
                    // flag[0] : overflow flag

    always @(*) 
    begin
        opcode = instruction[31:26];
        func = instruction[5:0];
        flag = 3'b000;

        case(opcode)
        //R type(func)// I type(opcode) 
        //add100000  addu100001 //addi001000 addiu 001001
        //sub100010 subu100011
        //and100100  nor100111 or100101 xor100110 //andi001100 ori001101 xori001110
        //slt101010 sltu101011 //beq000100 bne000101 slti001010 sltiu001011
        //  //lw100011 sw101011
        //sll000000 sllv000100 srl000010 srlv000110 sra000011 srav000111
        6'b000000://R type
        begin
            case(func)
            6'b100000: //add
            begin
                temp_result = regA + regB;
                if (!regA[31]&&!regB[31]&&temp_result[31] || regA[31]&&regB[31]&&!temp_result[31])
                    flag[0] = 1;
            end

            6'b100001: //addu
            begin
                temp_result = regA + regB;
            end

            6'b100010: //sub100010
            begin
                temp_result = regA - regB;
                if (!regA[31]&&regB[31]&&temp_result[31] || regA[31]&&!regB[31]&&!temp_result[31])
                    flag[0] = 1; 
            end

            6'b100011: //subu100011
            begin
                temp_result = regA - regB;
            end

            6'b100100: //and100100
            begin
                temp_result = regA & regB;
            end

            6'b100111: //nor100111
            begin
                temp_result = ~(regA | regB);
            end

            6'b100101: //or100101
            begin
                temp_result = (regA | regB);
            end

            6'b100110: //xor 100110
            begin
                temp_result = regA ^ regB;
            end

            6'b101010: //slt101010
            begin
                temp_result = regA - regB;
                if (temp_result[31] == 1)
                    flag[1] = 1;
                else
                    flag[1] = 0;
            end

            6'b101011: //sltu101011
            begin
                temp_result = regA - regB;
                if (temp_result[31] == 0)
                    flag[1] = 1;
                else
                    flag[1] = 0;
            end

            6'b000000: //sll000000 
            begin
                if (instruction[25:21] == 5'b00000)
                    temp_result = regA << instruction[10:6];
                if (instruction[25:21] == 5'b00001)
                    temp_result = regB << instruction[10:6];
            end

            6'b000100: //sllv000100 
            begin
                if (instruction[25:21] == 5'b00000)
                    shamt_reg = $signed(regB[4:0]);
                    temp_result = regA << shamt_reg;
                if (instruction[25:21] == 5'b00001)
                    shamt_reg = $signed(regA[4:0]);
                    temp_result = regB << shamt_reg;
            end

            6'b000010: //srl000010 
            begin
                if (instruction[25:21] == 5'b00000)
                    temp_result = regA >> instruction[10:6];
                if (instruction[25:21] == 5'b00001)
                    temp_result = regB >> instruction[10:6];
            end

            6'b000110: //srlv000110 
            begin
                if (instruction[25:21] == 5'b00000)
                    shamt_reg = $signed(regB[4:0]);
                    temp_result = regA >> shamt_reg;
                if (instruction[25:21] == 5'b00001)
                    shamt_reg = $signed(regA[4:0]);
                    temp_result = regB >> shamt_reg;
            end

            6'b000011: //sra000011 
            begin
                if (instruction[25:21] == 5'b00000)
                    temp_result = regA >>> instruction[10:6];
                if (instruction[25:21] == 5'b00001)
                    temp_result = regB >>> instruction[10:6];
                // temp_result = regB >>>instruction[10:6];
            end

            6'b000111: //srav000111
            begin
                if (instruction[25:21] == 5'b00000)
                    shamt_reg = $signed(regB[4:0]);
                    temp_result = regA <<< shamt_reg;
                if (instruction[25:21] == 5'b00001)
                    shamt_reg = $signed(regA[4:0]);
                    temp_result = regB <<< shamt_reg;
            end

            endcase
        end //R type end

        //addi001000 addiu 001001
        //andi001100 ori001101 xori001110
        //beq000100 bne000101 slti001010 sltiu001011
        //lw100011 sw101011
        //I type
        6'b001000 : //addi001000
        begin
            if (instruction[25:21] == 5'b00000)
                temp_result = regA + $signed(instruction[15:0]);
            if (instruction[25:21] == 5'b00001)
                temp_result = regB + $signed(instruction[15:0]);
            temp_result = regA + $signed(instruction[15:0])  ;
            flag[0] = (($signed(regA) >= 0)) == ($signed({instruction[15:0]}) >= 0) 
                && ($signed(temp_result) < 0);
        end

        6'b001001 : //addiu001001
        begin
            if (instruction[25:21] == 5'b00000)
                temp_result = regA + $signed(instruction[15:0]);
            if (instruction[25:21] == 5'b00001)
                temp_result = regB + $signed(instruction[15:0]);
            // temp_result = regA + $signed({instruction[15:0]});
        end 

        6'b001100 : //andi001100
        begin
            temp_result = regA & {instruction[15:0], 16'b0};
        end

        6'b001101 : //ori001101
        begin
            temp_result = regA | {instruction[15:0], 16'b0};
        end

        6'b001110 : //xori001110
        begin
            if (instruction[25:21] == 5'b00000)
                temp_result = regA ^ {instruction[15:0], 16'b0};
            if (instruction[25:21] == 5'b00001)
                temp_result = regB ^ {instruction[15:0], 16'b0};
            // temp_result = regA ^ {instruction[15:0], 16'b0};
        end
        
        6'b000100 : //beq000100 
        begin
            if (regA == regB) begin
                flag[2] = 1;
            end
        end
        
        6'b000101 : //bne000101
        begin
            if (regA != regB) begin
                flag[2] = 1;
            end
        end
        
        6'b001010 : //slti001010
        begin
            temp_result =  regA - $signed(instruction[15:0]);
            if (temp_result[31] == 1)
                flag[1] = 1;
        end
        
        6'b001011 : //sltiu001011
        begin
            temp_result = (regA < {instruction[15:0], 16'b0}) ?1 : 0;
        end
        
        6'b100011 : //lw100011
        begin
            if (instruction[25:21] == 5'b00000)
                temp_result = regA + $signed(instruction[15:0]);
            if (instruction[25:21] == 5'b00001)
                temp_result = regB + $signed(instruction[15:0]);
        end
        
        6'b101011 : //sw101011
        begin
            if (instruction[25:21] == 5'b00000)
                temp_result = regA + $signed(instruction[15:0]);
            if (instruction[25:21] == 5'b00001)
                temp_result = regB + $signed(instruction[15:0]);
        end  

        endcase
    end
    assign result = temp_result[31:0];
    assign flags = flag[2:0];

endmodule