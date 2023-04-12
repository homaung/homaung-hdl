module datapath(            
                        sam_srch_1          ,       //비교기1의 output
                        sam_srch_2          ,       //비교기2의 output   
                        enb_cnt             ,       //counter enble
                        rst_cnt             ,       //counter reset 
                        data                ,
                        address             ,            
                        clk                 ,
                        srdt                ,
                        sel_mux_reg_d       ,
                        rst_ma              ,       //register maxad address 리셋
                        ce_dt               ,       //memory data의 작동여부
                        we_dt               ,       //memory data의 읽기/쓰기
                        ce_ad               ,       //memory adress의 작동여부
                        we_ad               ,       //memory adress의 읽기/쓰기      
                        enb_srch_1          ,       //비교기1의 enble
                        enb_srch_2          ,       //비교기2의 enble                   
                        enb_srch_3          ,       //비교기3의 enble  
                        sel_mux_main_1      ,
                        sel_mux_main_2      ,
                        sel_reg_ma          ,
                        rst_reg_srdt        ,
                        sel_reg_srdt        ,
                        sel_reg_d           ,
                        seach_end           ,
                        out_mem_ad          ,
                        rst_reg_d           ,
                        out_incoder
);                                          



//Paramter
parameter             
                        S0=2'b00            , 
                        S1=2'b01            ,
                        S2=2'b10            ,
                        S3=2'b11
;

parameter               
                        A=8                 ,        // A : Adress width  
                        D=8                          // D : Data width                  
;                                                               


//wire&reg                                                                  
input wire [A-1:0]      
                        data                ,       
                        address             ,
                        srdt                        //찾고 싶은 데이터    
;

input wire             
                        enb_cnt             ,       //counter enble
                        rst_cnt             ,       //counter reset 
                        clk                 ,    
                        ce_dt               ,       //memory data의 작동여부
                        we_dt               ,       //memory data의 읽기/쓰기
                        ce_ad               ,       //memory adress의 작동여부
                        we_ad               ,       //memory adress의 읽기/쓰기
                        rst_ma              ,       //data의 갯수 저장의 리셋
                        sel_reg_ma          ,       //register maxad address select
                        enb_srch_1          ,       //비교기1의 enble
                        enb_srch_2          ,       //비교기2의 enble                   
                        enb_srch_3          ,       //비교기3의 enble
                        sel_mux_main_1      ,
                        rst_reg_srdt        ,
                        sel_reg_srdt        ,
                        rst_reg_d
;

input wire [2:0]       
                        sel_mux_reg_d       ,
                        sel_reg_d
;              
        
input wire [1:0]
                        sel_mux_main_2
;

output wire [D-1:0]     
                        out_mem_ad          
;

output wire            
                        seach_end                   //데이터   
;

output wire [2:0]
                        out_incoder         
;
output wire                   
                        sam_srch_1          ,       //비교기1의 output
                        sam_srch_2                  //비교기2의 output
;

wire [D-1:0]           
                        address_out         ,
                        data_out            ,
                        out_rom_main9       ,
                        reg_ma              ,       //register maxad address 데이터 출력
                        out_reg_srdt        ,
                        out_mux_main_2      ,
                        out_rom_main7       ,
                        count_0             ,       //counter 출력   
                        data_1              ,       //memory1의 데이터 입력
                        data_2              ,       //memory2의 데이터 입력
                        out_mem_dt1         ,
                        out_mem_dt2                  
;

wire [D-2:0]            
                        out_reg_d           , 
                        count_1             ,
                        reg_mc              ,
                        reg_ma_7bit         ,
                        out_rom_main8       ,
                        out_rom_main6       ,
                        out_rom_main1       ,
                        out_rom_main2       ,
                        count_mem_dt1       ,       //memory1의 주소 입력
                        count_mem_dt2               //memory2의 주소 입력
;

wire [13:0]
                        data1_mux1          ,
                        data2_mux1          ,
                        count_mem_dt0
;
wire
                        rst_dff               
;                        
//Instance

dff_8bit dff_ad (
                        .d(address)         ,       // 데이터 입력
                        .clk(clk)           ,       // 클럭 입력
                        .rst(rst_dff)       ,       // 리셋 입력
                        .q(address_out)             // 출력
);


dff_8bit dff_dt (
                        .d(data)            ,       // 데이터 입력
                        .clk(clk)           ,       // 클럭 입력
                        .rst(rst_dff)       ,       // 리셋 입력
                        .q(data_out)                // 출력
);

register_delay reg_delay_main( 
                        .data(out_rom_main8),
                        .rst(rst_reg_d)     ,
                        .clk(clk)           ,
                        .sel_mux(sel_mux_reg_d),
                        .out(out_reg_d)     ,
                        .sel_reg(sel_reg_d) ,
                        .reg_mc(reg_mc)

);

mux_1to14 mux_main_1(
                        .a(data1_mux1)      ,
                        .b(data2_mux1)      ,
                        .sel(sel_mux_main_1),
                        .out(count_mem_dt0)
);


mux_2to8_ls mux_main_2( 
                        .a1X(count_0)       ,
                        .a00(out_rom_main7) ,
                        .a01(out_rom_main9) ,
                        .sel(sel_mux_main_2),
                        .c(out_mux_main_2)

);

register_7bits reg_maxad (                          //register maxad address
                        .data(reg_ma)       ,
                        .reset(rst_ma)      ,    
                        .q(reg_ma_7bit)     ,
                        .select(sel_reg_ma) ,
                        .clk(clk)
);

register_8bits reg_srdt ( 
                        .data(srdt)         ,
                        .reset(rst_reg_srdt),
                        .q(out_reg_srdt)    ,
                        .select(sel_reg_srdt),
                        .clk(clk)
);



search srch_1(         
                        .q1(out_reg_srdt)   ,
                        .q2(out_mem_dt1)    ,
                        .q5(sam_srch_1)     ,     // 같으면 1        
                        .enble(enb_srch_1)
);

search srch_2(         
                        .q1(out_reg_srdt)   ,
                        .q2(out_mem_dt2)    ,
                        .q5(sam_srch_2)     ,     // 같으면 1        
                        .enble(enb_srch_2)
);

search2 srch_3(
                        .q1(reg_ma_7bit)    ,
                        .q2(out_rom_main6)  ,
                        .q5(seach_end)      ,      // 같으면 1        
                        .enble(enb_srch_3)
);
               
counter_8bit_enable cnt (                          //카운터
                        .clk(clk)           ,
                        .reset(rst_cnt)     ,
                        .count_enb(enb_cnt) ,
                        .count(count_0)
);


rom_main1 rom_main1(                                
                        .a(count_0)         ,
                        .b(out_rom_main1)
);

rom_main2 rom_main2(
                        .a(count_0)         ,
                        .b(out_rom_main2)

);


rom_7 rom_main7(
                        .a(count_0)         ,
                        .b(sam_srch_1)      ,
                        .c(out_rom_main7)
);

rom_8 rom_main8(
                        .a(count_0)         ,
                        .b(sam_srch_2)      ,
                        .c(out_rom_main8)
);

memory_data mem_dt1(                                //데이터 메모리1
                        .clk(clk)           ,
                        .ce(ce_dt)          ,
                        .we(we_dt)          ,
                        .addr(count_mem_dt1),
                        .data(data_out)     ,
                        .q(out_mem_dt1)   
);

memory_data mem_dt2(                                //데이터 메모리2
                        .clk(clk)           ,
                        .ce(ce_dt)          ,
                        .we(we_dt)          ,
                        .addr(count_mem_dt2),
                        .data(data_out)     ,
                        .q(out_mem_dt2)   
);

memory_ad mem_ad(                                  //주소 메모리
                        .clk(clk)           ,
                        .ce(ce_ad)          ,
                        .we(we_ad)          ,
                        .addr(out_mux_main_2),
                        .data(address_out)  ,
                        .q(out_mem_ad)   
);

rom_10 incoder_1 (
                        .a(reg_mc)          ,
                        .b(out_incoder)

);

//logic
assign     rst_dff = 1'b1 ;

assign     out_rom_main9 = { out_reg_d [6:0], 1'b0};

assign     reg_ma = count_0[7:1] ;

assign     out_rom_main6 =  count_0[7:1] ;

assign     data1_mux1 = { out_rom_main1, out_rom_main2 };

assign     data2_mux1 = { count_1, count_1 };

assign     count_1 = count_0 [6:0] ;

assign     count_mem_dt1 = count_mem_dt0 [13:7] ;

assign     count_mem_dt2 = count_mem_dt0 [6:0] ;

endmodule

