module DataMemory(Adr,
                  MemRead,
                  MemWrite,
                  Data,
                  WData,
                  clk);
    input[9:0] Adr;
    input MemWrite,MemRead,clk;
    input[15:0] WData;
    output[15:0] Data;
    reg [15:0] Memory[1023:0];
    
    initial begin
        $readmemb("datamem.txt",Memory);
    end
    
    always@(posedge clk)
    begin
        Memory[Adr] = (MemWrite)?WData:Memory[Adr];
    end
    
    assign Data = (MemRead)?Memory[Adr]:16'bz;
    
    /*always@(posedge clk)
     begin
     Memory[0] = 13;
     Memory[1] = 5;
     
     end*/
    
    
endmodule
    
