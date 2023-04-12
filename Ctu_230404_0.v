module Ctu_230404_0(    
                        clk                 ,
                        reset               ,
                        srch                ,
                        dtin                ,
                        M1_AO               ,
                        out_mem_ad          ,
                        op_sr               ,
                        data                ,
                        address             ,
                        srdt

);
    
    
//wire&reg
input wire
                        clk         ,
                        reset       ,
                        srch        ,
                        dtin        ,
                        M1_AO       
;
input wire [7:0]
                        data                ,
                        address             ,
                        srdt                
;
output wire
                        op_sr               
;

output wire [7:0]
                        out_mem_ad          
;

wire                    seach_end
;

//instance  

Controlunit utt2 (
                        .clk(clk)                 ,
                        .enb_cnt(enb_cnt)             ,       //counter enble
                        .rst_cnt(rst_cnt)             ,       //counter reset 
                        .dtin(dtin)                ,       //데이터가 들어오면 감지         
                        .ce_dt(ce_dt)               ,       //memory data의 작동여부
                        .we_dt(we_dt)               ,       //memory data의 읽기/쓰기
                        .ce_ad(ce_ad)               ,       //memory adress의 작동여부
                        .we_ad(we_ad)               ,       //memory adress의 읽기/쓰기
                        .rst_ma(rst_ma)              ,       //data의 갯수 저장의 리셋
                        .sel_reg_ma(sel_reg_ma)          ,       //register maxad address select
                        .enb_srch_1(enb_srch_1)          ,       //비교기1의 enble
                        .enb_srch_2(enb_srch_2)          ,       //비교기2의 enble                   
                        .enb_srch_3(enb_srch_3)          ,       //비교기3의 enble
                        .sel_mux_main_1(sel_mux_main_1)      ,
                        .sel_mux_main_2(sel_mux_main_2)      ,
                        .rst_reg_srdt(rst_reg_srdt)        ,
                        .sel_reg_srdt(sel_reg_srdt)        ,
                        .rst_reg_d(rst_reg_d)           ,
                        .sel_mux_reg_d(sel_mux_reg_d)       ,
                        .sel_reg_d(sel_reg_d)           ,
                        .reset(reset)               ,
                        .srch(srch)                ,
                        .sel_mux_main_3(sel_mux_main_3)      ,
                        .op_sr(op_sr)               ,
                        .M1_AO(M1_AO)               ,
                        .seach_end(seach_end)
);
  
datapath utt1(            
                        .enb_cnt(enb_cnt)             ,       //counter enble
                        .rst_cnt(rst_cnt)             ,       //counter reset 
                        .data(data)                ,
                        .address(address)             ,            
                        .clk(clk)                 ,
                        .srdt(srdt)                ,
                        .sel_mux_reg_d(sel_mux_reg_d)       ,
                        .rst_ma(rst_ma)              ,       //register maxad address 리셋
                        .ce_dt(ce_dt)               ,       //memory data의 작동여부
                        .we_dt(we_dt)               ,       //memory data의 읽기/쓰기
                        .ce_ad(ce_ad)               ,       //memory adress의 작동여부
                        .we_ad(we_ad)               ,       //memory adress의 읽기/쓰기      
                        .enb_srch_1(enb_srch_1)          ,       //비교기1의 enble
                        .enb_srch_2(enb_srch_2)          ,       //비교기2의 enble                   
                        .enb_srch_3(enb_srch_3)          ,       //비교기3의 enble  
                        .sel_mux_main_1(sel_mux_main_1)      ,
                        .sel_mux_main_2(sel_mux_main_2)      ,
                        .sel_mux_main_3(sel_mux_main_3)      ,
                        .sel_reg_ma(sel_reg_ma)          ,
                        .rst_reg_srdt(rst_reg_srdt)        ,
                        .sel_reg_srdt(sel_reg_srdt)        ,
                        .sel_reg_d(sel_reg_d)           ,
                        .reg_mc(reg_mc)              ,
                        .seach_end(seach_end)           ,
                        .out_mem_ad(out_mem_ad)          ,
                        .rst_reg_d(rst_reg_d)
); 


 









endmodule
