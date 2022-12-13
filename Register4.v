module Register4(Instin,
                 clk,
                 Regb,
                 Memory,
                 window,
                 Regbout,
                 Regaout,
                 Instout,
                 Memoryout,
                 W3,
                 W4,
                 RegWrite,
                 RegWriteo4,
                 RegData,
                 RegDatao4,
                 WindowR,
                 WindowRout);
    
    input [15:0] Instin;
    input clk;
    input [15:0] Regb;
    input [15:0] Memory;
    input[15:0] W3;
    input[1:0] WindowR;
    
    
    output reg[15:0] Regaout   = 0;
    output reg[15:0] Memoryout = 0;
    output reg[15:0] Regbout   = 0;
    output reg [15:0] Instout  = 16'h8040;
    output reg [1:0] window    = 0;
    output reg [15:0] W4       = 0;
    output reg[1:0] WindowRout = 0;
    
    //Control
    input [1:0] RegData;
    input RegWrite;
    output reg [1:0] RegDatao4 = 0;
    output reg RegWriteo4      = 0;
    
    always@(posedge clk)
    begin
        Instout    = Instin;
        Regbout    = Regb;
        window     = Instin[1:0];
        Memoryout  = Memory;
        W4         = W3;
        WindowRout = WindowR;
        //Control
        RegWriteo4 = RegWrite;
        RegDatao4  = RegData;
    end
    
endmodule
