module TestBench();
    wire clk;
    reg clk_r = 0;
    
    Datapath D1(.clk(clk));
    
    
    assign clk = clk_r;
    always
    #10 clk_r = ~clk_r;
    
    
    
endmodule
