module compare_adr_csu(
               data1,
               data2,
               reset1,
               reset2,
               clk,
               select1,
               select2,
               q4,
               q5,
               same             
);

//Parameter
parameter A=8,  D=8, R=256; // A : Adress width    D : Data width    R : 2^A




//wire&reg
input wire [A-1:0] data1;   // 검색 시작 주소1 레지스터 입력
input wire [A-1:0] data2;   // 검색 시작 주소2 레지스터 입력

input wire reset1;          //주소1 레지스터 리셋
input wire reset2;          //주소2 레지스터 리셋

input wire clk;

wire [A-1:0] q1;            //검색 주소1 레지스터 출력
wire [A-1:0] q2;            //검색 주소2 레지스터 출력
reg q3;                       
output wire q4;             //최종 검색 시작 주소
output wire q5;             //최종 검색 끝   주소
output reg same;              
input  wire select1;        //레지스터 1 select
input  wire select2;        //레지스터 2 select




//instant
register utt5(.data(data1), .reset(reset1),.q(q1), .select(select1), .clk(clk));       //레지스터 1
register utt6(.data(data2), .reset(reset2),.q(q2), .select(select2), .clk(clk));       //레지스터 2
mux_1to8_ls utt7 (.a(q1), .b(q2), .sel(q3), .out(q4));                                 //mux1 순서 조정용
mux_1to8_ls utt8 (.a(q2), .b(q1), .sel(q3), .out(q5));                                 //mux2 순서 조정용





//logic
always@(q1,q2)        //주소를 입력하는 두 input에 앞뒤 순서 맞추지 않아도 알아서 조정
   begin        
      if(q1>q2)
         begin
            q3<=1'b1;
         end
      else
         begin         
            q3<=1'b0;
         end
   end
               
   
          
always @ (q1,q2)        //만약 두 주소 코드의 hamming distant가 0일경우 same에 high value를 output  
   begin
      if(q1==q2)
         same<=1'b1;
      else             
         same<=1'b0;
   end        


endmodule


