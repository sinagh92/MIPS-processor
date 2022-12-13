module ALU(A,
           B,
           W,
           op,
           Zero);
    input[15:0] A,B;
    output reg[15:0] W = 15'b1;
    output Zero;
    input[2:0] op;
    
    always@(A or B or op)
    begin
        case(op)
            0: W      = B;
            1: W      = A+B;
            2: W      = A-B;
            3: W      = A&B;
            4: W      = A|B;
            5: W      = ~B;
            default W = B;
        endcase
    end
    
    assign Zero = (W == 0)?1'b1:1'b0;
    
endmodule
