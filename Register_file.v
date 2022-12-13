module Register_file(Ri,
                     RegRead2,
                     WR,
                     Regwrite,
                     WriteData,
                     DataRead1,
                     DataRead2,
                     f,
                     clk,
                     Window2,
                     WindowR,
                     WindowRout);
    input f,clk;
    input[1:0] Ri,Window2;
    input[1:0] RegRead2;
    input[15:0] WriteData;
    input[1:0] WindowR;
    input Regwrite;
    input [1:0] WR;
    output reg[15:0] DataRead1 = 0;
    output reg[15:0] DataRead2 = 0;
    output reg[1:0] WindowRout = 0;
    
    reg[1:0] Window   = 0;
    reg[1:0] RegRead1 = 0;
    reg[15:0] R0      = 10;
    reg[15:0] R1      = 20;
    reg[15:0] R2      = 30;
    reg[15:0] R3      = 40;
    reg[15:0] R4      = 50;
    reg[15:0] R5      = 60;
    reg[15:0] R6      = 70;
    reg[15:0] R7      = 80;
    
    always@(Ri)
        RegRead1 = Ri;
    
    always@(posedge clk)
        WindowRout = Window;
    
    always@(posedge f)
        Window = Window2;
    
    
    always@(Window or RegRead1 or RegRead2 or Regwrite)
    begin
        case(Window)
            0: begin DataRead1 = (RegRead1 == 2'b00)?R0:
            (RegRead1 == 2'b01)?R1:
            (RegRead1 == 2'b10)?R2:
            (RegRead1 == 2'b11)?R3:
            R0;
            DataRead2 = (RegRead2 == 2'b00)?R0:
            (RegRead2 == 2'b01)?R1:
            (RegRead2 == 2'b10)?R2:
            (RegRead2 == 2'b11)?R3:
            R0;
        end
        1: begin DataRead1 = (RegRead1 == 2'b00)?R2:
        (RegRead1 == 2'b01)?R3:
        (RegRead1 == 2'b10)?R4:
        (RegRead1 == 2'b11)?R5:
        R2;
        DataRead2 = (RegRead2 == 2'b00)?R2:
        (RegRead2 == 2'b01)?R3:
        (RegRead2 == 2'b10)?R4:
        (RegRead2 == 2'b11)?R5:
        R2;
    end
    2:begin DataRead1 = (RegRead1 == 2'b00)?R4:
    (RegRead1 == 2'b01)?R5:
    (RegRead1 == 2'b10)?R6:
    (RegRead1 == 2'b11)?R7:
    R4;
    DataRead2 = (RegRead2 == 2'b00)?R4:
    (RegRead2 == 2'b01)?R5:
    (RegRead2 == 2'b10)?R6:
    (RegRead2 == 2'b11)?R7:
    R4;
end
3: begin DataRead1 = (RegRead1 == 2'b00)?R6:
(RegRead1 == 2'b01)?R7:
(RegRead1 == 2'b10)?R0:
(RegRead1 == 2'b11)?R1:
R6;
DataRead2 = (RegRead2 == 2'b00)?R6:
(RegRead2 == 2'b01)?R7:
(RegRead2 == 2'b10)?R0:
(RegRead2 == 2'b11)?R1:
R6;
end
        endcase
    end
    
    
    always@(negedge clk)
    begin
        if (Regwrite)
        begin
            if (WindowR == 0)
            begin
                if (WR == 0)
                    R0 = WriteData;
                else if (WR == 1)
                    R1 = WriteData;
                else if (WR == 2)
                    R2 = WriteData;
                else
                    R3 = WriteData;
            end
            
            else if (WindowR == 1)
            begin
            if (WR == 0)
                R2 = WriteData;
            else if (WR == 1)
                R3 = WriteData;
            else if (WR == 2)
                R4 = WriteData;
            else
                R5 = WriteData;
        end
        else if (WindowR == 2)
        begin
            if (WR == 0)
                R4 = WriteData;
            else if (WR == 1)
                R5 = WriteData;
            else if (WR == 2)
                R6 = WriteData;
            else
                R7 = WriteData;
        end
        else
        begin
            if (WR == 0)
                R6 = WriteData;
            else if (WR == 1)
                R7 = WriteData;
            else if (WR == 2)
                R0 = WriteData;
            else
                R1 = WriteData;
        end
        
        
    end
    end
    
endmodule
