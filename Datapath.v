module Datapath(input clk);
    
    wire [15:0] Inst,Inst1,Inst2,Inst3,Inst4,A,B,A2,B2,A3,B3,Az,Bz,A4,B4,W,W3,W4,DM4,DM,A_alu,B_alu,WriteData,Wdatamem,Instout;
    wire [9:0] PCin,PCout;
    wire [1:0] Ri,Rj,window,PCSrc;
    wire[2:0] op,sela,selb,selaz,selbz;
    wire RegSrc1,RegSrc2,ALUSrcA,ALUSrcB,f,Zero,Zero2;
    wire ALUSrcAo2,ALUSrcBo2,Memreado2,MemWriteo2,Regwriteo2;
    wire Regwriteo3,RegWriteo4,MemReado3,MemWriteo3,selmem;
    wire [2:0] opo2;
    wire [1:0] RegDatao2,RegDatao3,Regdata,RegDatao4,WindowRout,WindowRout2,WindowRout3,WindowRout4;
    
    Controller C1(.clk(clk),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .RegSrc1(RegSrc1),
    .RegSrc2(RegSrc2),
    .PcSrc(PCSrc),
    .Regdata(Regdata),
    .Memread(Memread),
    .Memwrite(Memwrite),
    .Regwrite(Regwrite),
    .f(ff),
    .op(op),
    .Inst(Inst1),
    .zero(Zero),
    .Branch(Branch));
    
    Forward forward(.alusrc1(ALUSrcAo2),
    .alusrc2(ALUSrcBo2),
    .Ri3(Inst3[11:10]),
    .Ri4(Inst4[11:10]),
    .window3(WindowRout3),
    .window4(WindowRout4),
    .window2(WindowRout2),
    .Rj3(Inst3[9:8]),
    .Rj4(Inst4[9:8]),
    .inst1(Inst1),
    .inst2(Inst2),
    .inst3(Inst3),
    .inst4(Inst4),
    .sela(sela),
    .selb(selb),
    .selaz(selaz),
    .selbz(selbz),
    .selmem(selmem));
    
    PC dpPC(.clk(clk),
    .PCin(PCin),
    .PCout(PCout));
    
    
    
    InstMemory dpInstMem(.Adr(PCout),
    .Data(Instout),
    .clk(clk));
    
    
    Register1 R1(.clk(clk),
    .Instin(Inst),
    .Instout(Inst1));
    
    
    Register2 R2(.clk(clk),
    .Instin(Inst1),
    .Rega(A),.Regb(B),
    .Regaout(A2),.Regbout(B2),
    .Instout(Inst2),
    .AlUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),
    .MemRead(Memread),.MemWrite(Memwrite),
    .Regwrite(Regwrite),
    .op(op),
    .AlUSrcAo2(ALUSrcAo2),.ALUSrcBo2(ALUSrcBo2),
    .MemReado2(Memreado2),.MemWriteo2(MemWriteo2),
    .Regwriteo2(Regwriteo2),
    .opo2(opo2),
    .RegData(Regdata),.RegDatao2(RegDatao2),
    .WindowR(WindowRout),.WindowRout(WindowRout2));
    
    Register_file dpRegFile(.clk(clk),
    .Ri(Ri),
    .RegRead2(Rj),
    .WR(Inst4[11:10]),
    .Regwrite(RegWriteo4),.WriteData(WriteData),
    .DataRead1(A),.DataRead2(B),
    .f(f),
    .Window2(Inst1[1:0]),.WindowR(WindowRout4),.WindowRout(WindowRout));
    
    ALU dpALU(.A(A_alu),
    .B(B_alu),
    .W(W),
    .op(opo2),
    .Zero(Zero2));
    
    
    
    Register3 R3(.clk(clk),
    .Instin(Inst2),
    .Rega(A2),.Regb(B),.w(W),.Regaout(A3),.Regbout(B3),.wout(W3),
    .Instout(Inst3),
    .MemRead(Memreado2),.MemWrite(MemWriteo2),
    .Regwrite(Regwriteo2),
    .MemReado3(MemReado3),.MemWriteo3(MemWriteo3),
    .Regwriteo3(Regwriteo3),.RegData(RegDatao2),.RegDatao3(RegDatao3),
    .WindowR(WindowRout2),.WindowRout(WindowRout3));
    
    
    
    
    Register4 R4(.clk(clk),
    .Instin(Inst3),
    .Regb(B3),
    .Memory(DM),
    .window(window),
    .Regbout(B4),.Regaout(A4),
    .Instout(Inst4),
    .Memoryout(DM4),
    .W3(W3),.W4(W4),
    .RegWrite(Regwriteo3),.RegWriteo4(RegWriteo4),.RegData(RegDatao3),.RegDatao4(RegDatao4),
    .WindowR(WindowRout3),.WindowRout(WindowRout4));
    
    
    
    
    
    DataMemory dpDataMem(.clk(clk),
    .Adr(Inst3[9:0]),
    .MemRead(MemReado3),
    .MemWrite(MemWriteo3),
    .Data(DM),
    .WData(Wdatamem));
    
    
    
    
    
    
    // Data patch connections
    assign A_alu = (sela == 0)?A2:(sela == 1)?Inst2[7:0]:(sela == 3'd2)?W3:(sela == 3'd3)?W4:(sela == 3'd5)?DM4:A2;
    assign B_alu = (selb == 0)?B2:(selb == 1)?B2:(selb == 3'd2)?W3:(selb == 3'd3)?W4:(selb == 3'd5)?DM4:B2;
    
    
    assign Az = (selaz == 0)?A:(selaz == 3'd2)?W4:(selaz == 3'd3)?W3:(selaz == 3'd5)?DM4:(selaz == 6)?W:A2;
    assign Bz = (selbz == 0)?B:(selbz == 3'd2)?W4:(selbz == 3'd3)?W3:(selbz == 3'd5)?DM4:(selbz == 6)?W:B2;
    
    
    assign Wdatamem  = (selmem)?W4:A3;
    assign Ri        = (RegSrc1 == 0)?Inst1[11:10]:Inst1[11:10];
    assign Rj        = (RegSrc2 == 0)?Inst1[9:8]:Inst1[9:8];
    assign WriteData = (RegDatao4 == 0)?W4:(RegDatao4 == 1)?DM4:(RegDatao4 == 2)?B4:B4;
    assign PCin      = (Branch&Zero)?{PCout[9],PCout[8],Inst1[7:0]}:(Inst1[15:12] == 4'b0)?PCout:(PCSrc == 0)?(PCout+1):(PCSrc == 1)?Inst1[9:0]:(PCout+1);
    assign f         = (Inst1[7] == 1&Inst1[15:12] == 4'b1000)?1:0;
    assign Zero      = (Az == Bz)?1'b1:1'b0;
    assign Inst      = ((Inst1[15:12] == 4'b0010)||(Branch&Zero)||(Inst1[15:12] == 4'b0))?16'h8040:Instout;
    
    
    
    
endmodule
    
