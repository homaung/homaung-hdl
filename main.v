module main(dataRG,
            clk,
            dataR,
            adr_ram1,
            q4,
            q5,
            q
            
             
                         
);
parameter S0=2'b00, S1=2'b01,S2=2'b10,S3=2'b11;




input wire clk;
input wire [2:0] dataR;     //ram에 입력하는 데이터
input wire [4:0] adr_ram1;  //ram 주소 입력(쓰기용)
input wire [2:0] dataRG;    //register 입력 데이터

reg reset1,                 //비교기 레지스터1 리셋  
    reset2,                 //비교기 레지스터2 리셋
    reset3,                 //레지스터3 리셋
    select1,                //비교기 레지스터1 select
    select2,                //비교기 레지스터2 select
    select3,                //레지스터3 select
    select4,                //mux select 
    rw                      //ram r/w
;
      
output wire  q4;            //검색 찾을시 1
output wire  q5;            //검색 찾을시 0
wire [4:0] addr;            //주소
wire [2:0] rcreg;           //ram output
reg  [4:0] dataADR;         //찾던 자료가 있던 주소 레지스터3에 입력하는 reg
output wire  [4:0] q;       //레지스터3 출력
reg [4:0] adr_ram2;         //ram 주소 입력(읽기용)


 

ram utt1 ( .clk(clk), .rw(rw), .addr(addr), .data(dataR), .q(rcreg) );                                                                         //ram
compare utt2 (.data1(rcreg),.data2(dataRG),.reset1(reset1),.reset2(reset2),.clk(clk),.select1(select1),.select2(select2),.q4(q4), .q5(q5) );   //비교기
register_adr uut3 (.data(dataADR), .reset(reset3), .q(q), .select(select3), .clk(clk));                                                        //검색 완료시 자료의 위치 주소 저장을 레지스터에 저장
mux_1 utt4 (.a(adr_ram1), .b(adr_ram2), .sel(select4), .out(addr));                                                                            //mux 읽기 쓰기 변경



endmodule