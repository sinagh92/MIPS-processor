module Register3(Instin,
                 clk,
                 Rega,
                 Regb,
                 w,
                 Regaout,
                 Regbout,
                 wout,
                 Instout,
                 MemRead,
                 MemWrite,
                 Regwrite,
                 MemReado3,
                 MemWriteo3,
                 Regwriteo3,
                 RegData,
                 RegDatao3,
                 WindowR,
                 WindowRout);
    
    
    input [15:0] Instin;
    input clk;
    input [15:0] Rega;
    input [15:0] Regb;
    input [15:0] w;
    input[1:0] WindowR;
    
    output reg[15:0] wout      = 0;
    output reg[15:0] Regaout   = 0;
    output reg[15:0] Regbout   = 0;
    output reg [15:0] Instout  = 16'h8040;
    output reg[1:0] WindowRout = 0;
    
    //Control
    input MemRead,MemWrite,Regwrite;
    input[1:0] RegData;
    output reg MemReado3       = 0,MemWriteo3       = 0,Regwriteo3       = 0;
    output reg [1:0] RegDatao3 = 0;
    
    
    always@(posedge clk)
    begin
        Instout    = Instin;
        Regaout    = Rega;
        Regbout    = Regb;
        wout       = w;
        WindowRout = WindowR;
        //Control
        MemReado3  = MemRead;
        MemWriteo3 = MemWrite;
        Regwriteo3 = Regwrite;
        RegDatao3  = RegData;
    end
    
endmodule
