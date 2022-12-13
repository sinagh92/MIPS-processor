module Forward(input alusrc1,
               alusrc2,
               input[1:0] Ri3,
               Ri4,
               window3,
               window4,
               window2,
               Rj3,
               Rj4,
               input[15:0] inst2,
               inst3,
               inst4,
               inst1,
               output[2:0] sela,
               selb,
               selaz,
               selbz,
               output selmem);
    wire[2:0] Rx2,Rx3,Rx4,Ry2,Rx1,Ry1;
    assign Rx2 = {window2[1:0],1'b0}+inst2[11:10];
    assign Rx1 = {window2[1:0],1'b0}+inst1[11:10];
    assign Rx3 = {window3[1:0],1'b0}+inst3[11:10];
    assign Rx4 = {window4[1:0],1'b0}+inst4[11:10];
    assign Ry2 = {window2[1:0],1'b0}+inst2[9:8];
    assign Ry1 = {window2[1:0],1'b0}+inst1[9:8];
    
    assign sela = 
    (alusrc1 == 1)?1:
    (Rx2 == Rx3 && inst3[15:12] == 4'b0 && inst2[15] == 1)?4:
    (Rx2 == Rx3 && inst3[15] == 1 && inst2[15] == 1)?3:
    (inst4[15:12] == 4'b0000 && Rx4 == Rx2 && inst2[15] == 1)?5:
    (Rx4 == Rx2 && inst4[15] == 1 && inst2[15] == 1)?2:3'b0;
    
    
    assign selb = 
    (Ry2 == Rx3 && inst3[15] == 1 && inst2[15] == 1)?2:
    (Ry2 == Rx3 && inst3[15:12] == 4'b0 && inst2[15] == 1)?4:
    (inst4[15:12] == 4'b0000 && Rx4 == Ry2 && inst2[15] == 1)?5:
    (Ry2 == Rx4 && inst4[15] == 1 && inst2[15] == 1)?3:1;
    
    assign selaz = 
    (Rx2 == Rx1 && inst2[15] == 1 && inst1[15:12] == 4'b0100)?6:
    (Rx1 == Rx3 && inst3[15:12] == 4'b0 &&  inst1[15:12] == 4'b0100)?4:
    (Rx1 == Rx3 && inst3[15] == 1 && inst1[15:12] == 4'b0100)?3:
    (Rx4 == Rx1 && inst4[15] == 1 && inst1[15:12] == 4'b0100)?2:
    (inst4[15:12] == 4'b0000 && Rx4 == Rx1 && inst1[15:12] == 4'b0100)?5:3'b0;
    
    
    assign selbz = 
    (Rx2 == Ry1 && inst2[15] == 1 && inst1[15:12] == 4'b0100)?6:
    (Ry1 == Rx3 && inst3[15:12] == 4'b0 && inst1[15:12] == 4'b0100)?4:
    (Ry1 == Rx3 && inst3[15] == 1 && inst1[15:12] == 4'b0100)?3:
    (Ry1 == Rx4 && inst4[15] == 1 && inst1[15:12] == 4'b0100)?2:
    (inst4[15:12] == 4'b0000 && Rx4 == Ry1 && inst1[15:12] == 4'b0100)?5:1;
    
    
    assign selmem = 
    (inst3[15:12] == 4'b0001 && Rx3 == Rx4)?1'b1:1'b0;
    
    
    
    
    
    
endmodule
