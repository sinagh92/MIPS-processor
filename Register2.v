module Register2(Instin,
                 clk,
                 Rega,
                 Regb,
                 Regaout,
                 Regbout,
                 Instout,
                 AlUSrcA,
                 ALUSrcB,
                 MemRead,
                 MemWrite,
                 Regwrite,
                 op,
                 AlUSrcAo2,
                 ALUSrcBo2,
                 MemReado2,
                 MemWriteo2,
                 Regwriteo2,
                 opo2,
                 RegData,
                 RegDatao2,
                 WindowR,
                 WindowRout);
    
    input [15:0] Instin;
    input clk;
    input [15:0] Rega;
    input [15:0] Regb;
    input[1:0] WindowR;
    
    output reg[15:0] Regaout   = 0;
    output reg[15:0] Regbout   = 0;
    output reg [15:0] Instout  = 16'h8040;
    output reg[1:0] WindowRout = 0;
    //Control
    input AlUSrcA,ALUSrcB,MemRead,MemWrite,Regwrite;
    input [1:0] RegData;
    input [2:0] op;
    output reg AlUSrcAo2       = 0,ALUSrcBo2       = 0,MemReado2       = 0,MemWriteo2       = 0,Regwriteo2       = 0;
    output reg [2:0] opo2      = 0;
    output reg [1:0] RegDatao2 = 0;
    
    
    
    always@(posedge clk)
    begin
        Instout    = Instin;
        Regaout    = Rega;
        Regbout    = Regb;
        WindowRout = WindowR;
        //Control
        AlUSrcAo2  = AlUSrcA;
        ALUSrcBo2  = ALUSrcB;
        MemReado2  = MemRead;
        MemWriteo2 = MemWrite;
        Regwriteo2 = Regwrite;
        opo2       = op;
        RegDatao2  = RegData;
        
    end
    
endmodule
    
