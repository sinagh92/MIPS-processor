module Register1(Instin,
                 clk,
                 Instout);
    input [15:0] Instin;
    input clk;
    output reg [15:0] Instout = 16'h8040;
    
    always@(posedge clk)
    begin
        Instout = Instin;
        
        
    end
    
    
    
    
    
    
    
    
endmodule
