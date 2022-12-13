module Controller(clk,
                  ALUSrcA,
                  ALUSrcB,
                  RegSrc1,
                  RegSrc2,
                  PcSrc,
                  Regdata,
                  Memread,
                  Memwrite,
                  Regwrite,
                  f,
                  op,
                  Inst,
                  zero,
                  Branch);
    
    output reg ALUSrcA      = 0,ALUSrcB      = 0,RegSrc1      = 0,RegSrc2      = 0,Memread      = 0,Memwrite      = 0,Regwrite      = 0,f      = 0;
    output reg[2:0] op      = 0;
    output reg[1:0] Regdata = 0,PcSrc = 0;
    output reg Branch       = 0;
    input clk;
    input [15:0]Inst;
    input zero;
    wire [3:0] opcode;
    wire [7:0] func;
    
    
    assign opcode = Inst[15:12];
    assign func   = (opcode == 4'b1000)?Inst[7:0]:8'bz;
    
    
    always@(func or opcode)
    begin
        Branch = 0;ALUSrcA = 0;ALUSrcB = 0;RegSrc1 = 0;RegSrc2 = 0;PcSrc = 0;Regdata = 0;op = 0;f = 0;Memread = 0;Memwrite = 0;Regwrite = 0;f = 0;
        if (opcode == 4'b1000)
        begin
            if (func == 1)
            begin
                // move
                RegSrc1  = 0;
                RegSrc2  = 0;
                Regdata  = 2;
                Regwrite = 1;
                op       = 0;
                f        = 0;
            end
            else if (func == 2)
            begin
                //Add
                RegSrc1  = 0;
                RegSrc2  = 0;
                ALUSrcA  = 0;
                ALUSrcB  = 0;
                Regdata  = 0;
                Regwrite = 1;
                op       = 1;
                f        = 0;
            end
                else if (func == 4)
                begin
                //SUB
                RegSrc1  = 0;
                RegSrc2  = 0;
                ALUSrcA  = 0;
                ALUSrcB  = 0;
                Regdata  = 0;
                Regwrite = 1;
                op       = 2;
                f        = 0;
                end
                else if (func == 8)
                begin
                //And
                RegSrc1  = 0;
                RegSrc2  = 0;
                ALUSrcA  = 0;
                ALUSrcB  = 0;
                Regdata  = 0;
                Regwrite = 1;
                op       = 3;
                f        = 0;
                end
                else if (func == 16)
                begin
                //OR
                RegSrc1  = 0;
                RegSrc2  = 0;
                ALUSrcA  = 0;
                ALUSrcB  = 0;
                Regdata  = 1;
                Regwrite = 1;
                op       = 4;
                f        = 0;
                end
                else if (func == 32)
                begin
                //NOT
                RegSrc1 = 0;
                RegSrc2 = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                Regdata = 0
                ;
                Regwrite = 1;
                op       = 5;
                f        = 0;
                end
                else if (func == 64)
                begin
                //NOP
                
                end
                else if (func == 128)
                begin
                //Window0
                f = 1;
                
                end
                else if (func == 129)
                begin
                //Window1
                f = 1;
                
                end
                else if (func == 130)
                begin
                //Window2
                f = 1;
                
                end
                else if (func == 131)
                begin
                //Window3
                f = 1;
                
                end
                end
                else if (opcode == 4'b1100)
                begin
                //ADDi
                op       = 1;
                ALUSrcA  = 1;
                ALUSrcB  = 0;
                Regwrite = 1;
                end
                else if (opcode == 4'b1101)
                begin
                //SUBi
                op = 2;
                
                ALUSrcA  = 1;
                ALUSrcB  = 0;
                Regwrite = 1;
                end
                else if (opcode == 4'b1110)
                begin
                //ANDi
                op = 3;
                
                ALUSrcA  = 1;
                ALUSrcB  = 0;
                Regwrite = 1;
                end
                else if (opcode == 1111)
                begin
                //Ori
                op       = 4;
                ALUSrcA  = 1;
                ALUSrcB  = 0;
                Regwrite = 1;
                end
                else if (opcode == 0)
                begin
                //Load
                
                Regdata  = 1;
                Memread  = 1;
                Regwrite = 1;
                
                end
                else if (opcode == 1)
                begin
                //Store
                
                Memwrite = 1;
                
                end
                else if (opcode == 2)
                begin
                //Jump
                PcSrc = 1;
                
                end
                else if (opcode == 4)
                begin
                //beq
                //PcSrc = 2;
                Branch  = 1;
                f       = 0;
                
                
                end
                
                
                
                
                
                end
                
                
                
                
                endmodule
