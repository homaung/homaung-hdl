module main(            dataRG              ,
                        clk                 ,
                        dataR               ,
                        adr_mem1            ,
                        q4                  , 
                        q5                  , 
                        ce                  ,
                        q


                         
);                                          



//Paramter
parameter               S0=2'b00            , 
                        S1=2'b01            ,
                        S2=2'b10            ,
                        S3=2'b11
;
parameter               A=8                 ,         // A : Adress width  
                        D=8                           // D : Data width                  
;                                                               




//wire&reg                                                                  
input wire              clk                 ,                  
                        ce_in               ,        //mememory enable
                        we_in                        //mememory write enable
;                                                       


input wire [D-1:0]      dataR               ,        //mememory 입력하는 데이터
                        dataRG                       //register 입력 데이터
;                                                        

input wire [A-1:0]      adr_mem1            ,        //mememory 주소 입력(쓰기용)
                 

reg                     reset1              ,        //비교기 레지스터1 리셋  
                        reset2              ,        //비교기 레지스터2 리셋
                        reset3              ,        //레지스터3 리셋
                        select1             ,        //비교기 레지스터1 select
                        select2             ,        //비교기 레지스터2 select
                        select3             ,        //레지스터3 select
                        sel_adr             ,        //mux select 
                        rw                  ,        //mememory r/w
                        ce_ctu              ,        //control unit mememory enable
                        we_ctu                       //control unit mememory write enable
;                                                                   

output wire             q4                  ,        //검색 찾을시 1
                        q5                           //검색 찾을시 0

;                                                           
wire [A-1:0]            addr                ,        //주소
                        addr_ls                             
;                                                           
wire [D-1:0]            rcreg                        //mememory output
;                                                       
wire                    sel_ce_ctu          ,           
                        ce                              
;                                                           
reg  [A-1:0]            dataADR                      //찾던 자료가 있던 주소 레지스터3에 입력하는 reg
;                                                                   
output wire  [A-1:0]    q                                                       
;                                                    //레지스터3 출력
reg [A-1:0]             adr_mem2                     //mememory 주소 입력(읽기용)
;         


 
//Instance
memory mem_data (       .clk(clk)           ,        //Memory_data
                        .ce(ce)             ,
                        .we(rw)             ,
                        .addr(addr_ls)      ,
                        .data(dataR)        ,
                        .q(rcreg)
);                 


memory mem_addr(        
                        .clk(clk)           ,        //Memory_addr
                        .ce(ce)             ,        
                        .we(rw)             ,
                        .addr(addr_ls)      ,
                        .data(addr)         ,
                        .q(rcreg)
);                              


search search(           
                        .data1(rcreg)       ,        //비교기
                        .data2(dataRG)      ,           
                        .reset1(reset1)     ,           
                        .reset2(reset2)     ,           
                        .clk(clk)           ,           
                        .select1(select1)   ,               
                        .select2(select2)   ,                       
                        .q4(q4)             ,           
                        .q5(q5)                                 
);              


register_8bits uut3 (     
                        .data(dataADR)      ,        //검색 완료시 자료의 위치 주소 저장을 레지스터에 저장
                        .reset(reset3)      ,
                        .q(q)               ,  
                        .select(select3)    ,
                        .clk(clk)
);                            

                                                                                                                  
mux_1to8 mux_main_1 (
                        .a(adr_mem1)        ,        //mux we에 따른 주소 wire 변경
                        .b(adr_mem2)        ,
                        .sel(sel_adr)       ,
                        .out(addr)
);

mux_1to1 mux_main_2 (
                        .a(ce_in)           ,         //mux  검색기능 명령 받을시 메모리 ce 컨드롤
                        .b(ce_ctu)          ,
                        .sel(sel_ce_ctu)    ,
                        .out(ce)
);

mux_1to1 mux_main_3 (
                        .a(we_in)           ,         //mux  검색기능 명령 받을시 메모리 we컨드롤
                        .b(we_ctu)          , 
                        .sel(sel_we_ctu)    ,
                        .out(we)
);   

ctu_ls ctu (
                        .ce_ctu(ce_ctu)     ,
                        .we_ctu(we_ctu)     ,

            
);


endmodule