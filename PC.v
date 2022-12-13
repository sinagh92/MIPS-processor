module PC(PCin,
          clk,
          PCout);
    input clk;
    input [9:0]PCin;
    output reg [9:0]PCout = 0;
    
    always@(posedge clk)
        PCout = PCin;
    
    
    
    
endmodule
