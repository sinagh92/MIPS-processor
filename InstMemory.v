module InstMemory(Adr,
                  Data,
                  clk);
    input[9:0] Adr;
    input clk;
    
    output[15:0] Data;
    reg [15:0] Memory[25:0];
    assign Data = Memory[Adr];
    
    initial  begin
        $readmemb("instmem2.txt",Memory);
        //$readmemb("testadd.txt",Memory);
        
        
    end
    
endmodule
