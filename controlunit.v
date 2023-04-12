module Controlunit(
                        clk                 ,
                        enb_cnt             ,       //counter enble
                        rst_cnt             ,       //counter reset 
                        dtin                ,       //데이터가 들어오면 감지         
                        ce                  ,       //memory의 작동여부
                        we                  ,       //memory의 읽기/쓰기
                        sel_reg_ma          ,       //register maxad address select
                        enb_srch            ,       //비교기1,2,3 의 enble
                        sel_mux_main_1      ,       
                        rst_reg_srdt        ,
                        sel_reg_srdt        ,
                        sel_mux_reg_d       ,
                        sel_reg_d           ,
                        reset               ,
                        srch                ,
                        sel_mux_main_2      ,
                        op_sr               ,
                        seach_end           ,
                        out_incoder         ,
                        overflow            ,
                        sam_srch_1          ,       //비교기1의 output
                        sam_srch_2          ,       //비교기2의 output
                        underflow
);
 
 
//Paramter
parameter             
                        S0=2'b00            , 
                        S1=2'b01            ,
                        S2=2'b10            ,
                        S3=2'b11
;


parameter             
                        R0=3'b000            , 
                        R1=3'b001            ,
                        R2=3'b010            ,
                        R3=3'b011            ,
                        R4=3'b100            ,
                        R5=3'b101            ,   
                        R6=3'b110            ,
                        R7=3'b111                             
;

//wire&reg    
input wire
                    clk                 ,
                    reset               ,
                    srch                ,
                    dtin                ,
                    sam_srch_1          ,
                    sam_srch_2          ,   
                    seach_end
; 

input wire [2:0]
                    out_incoder
;

reg [2:0]         
                    cmd_reg_in          ,
                    cmd_reg_out 
;
reg [1:0]           
                    ps                  ,
                    ns
;


output wire 
                    we                  ,       //memory의 읽기/쓰기
                    ce                  ,       // 최대 주소 레지스터, 레지스터 딜레이 리셋, 메모리 온 오프 
                    sel_mux_main_1  ,
                    rst_reg_srdt        ,
                    rst_cnt             ,       //counter reset                
                    enb_cnt  , //counter enble
                    sel_reg_srdt        ,               
                    sel_reg_ma          ,       //register maxad address select
                    enb_srch                  //비교기의 enble
        
;
output wire [2:0]       
                    sel_mux_reg_d       ,
                    sel_reg_d
;              
     
output wire [1:0]
                    sel_mux_main_2
;

output wire 
                    op_sr               ,
                    overflow            ,
                    underflow
;

wire [1:0] 
                    cmd_reg_d           ,
                    cmd_reg_d_0         ,
                    cmd_reg_d_1
;

wire
                    q                   ,
                    q1                  ,
                    q2                  ,
                    q3                  ,
                    q4                  ,
                    q5                  ,
                    ce_cmd_reg_d     
;

    
//logic
always @ (posedge clk, negedge reset)
    begin
        if (!reset)
            ps <= S3;
        else
            ps <= ns;
    end


//always @ (ps)
//    case(ps)
//        S0 :      
//            begin
//                ce               <= 1'b0 ;       //memory data의 작동여부
//                we               <= 1'b0 ;       //memory data의 읽기/쓰기
//                sel_reg_ma       <= 1'b0 ;       //register maxad address select
//                enb_srch         <= 1'b0 ;       //비교기의 enble
//                sel_mux_main_1   <= 1'b1 ;
//                 ce_cmd_reg_d    <= 1'b0 ;                      
//                if(q1)
//                    ns        <=  S1     ;
//                else
//                    ns        <=  S0     ;
            
//               end
//        S1 : 
//            begin
//                ce              <= 1'b1  ;       //memory의 작동여부
//                we              <= 1'b1  ;       //memory의 읽기/쓰기
//                sel_reg_ma      <= 1'b0  ;       //register maxad address select
//                enb_srch        <= 1'b0  ;       //비교기의 enble
//                sel_mux_main_1  <= 1'b1  ;
//                ce_cmd_reg_d    <= 1'b0  ;
//                if(dtin)
//                    begin
//                        ns      <= S1    ;                 
//                    end
//                else
//                    begin
//                        ns      <= S2    ;              
//                    end
//            end
//        S2 : 
//            begin
//                ce              <= 1'b1  ;       //memory data의 작동여부
//                we              <= 1'b0  ;       //memory data의 읽기/쓰기
//                sel_reg_ma      <= 1'b1  ;       //register maxad address select
//                enb_srch        <= 1'b0  ;       //비교기의 enble
//                sel_mux_main_1  <= 1'b1  ;
//                ce_cmd_reg_d    <= 1'b1  ;
//                    if(q) 
//                        ns  <= S2        ;               
//                 else
//                        ns <= S3         ;

//            end
//        S3 : 
//            begin
//                ns              <= S0     ;
//                ce              <= 1'b0   ;       //memory data의 작동여부
//                we              <= 1'b0   ;       //memory data의 읽기/쓰기
//                sel_reg_ma      <= 1'b1   ;       //register maxad address select
//                enb_srch        <= 1'b1   ;       //비교기의 enble
//                sel_mux_main_1  <= 1'b0   ;
//                ce_cmd_reg_d    <= 1'b0   ;
//            end
//    endcase

always @ (ps)
    case(ps)
        S0 :      
            begin
                if(q1)
                    ns <= S1 ;
                else
                    ns <= S0 ;
            end
        S1 : 
            begin
                if(dtin)
                    ns <= S1 ;                 

                else
                    ns <= S2 ;              
            end
        S2 : 
            begin
                if(q) 
                    ns <= S2 ;               
                 else
                    ns <= S3 ;

            end
        S3 : 
            begin
                ns <= S0 ;
            end
    endcase


assign      overflow = !( sam_srch_2 & ( &out_incoder ) );

assign      underflow = sam_srch_1 & ( !( |out_incoder ) ); 

assign      cmd_reg_d_0 = { sam_srch_1, sam_srch_2 };   

assign      q1 = srch & dtin ;

assign      q = (!seach_end)||out_incoder;

assign      cmd_reg_d [0] = cmd_reg_d_0 [0] & ce_cmd_reg_d ;
assign      cmd_reg_d [1] = cmd_reg_d_0 [1] & ce_cmd_reg_d ;

assign      sel_mux_main_2 [1] = ! ( cmd_reg_d [1] ^ cmd_reg_d[0] );
assign      sel_mux_main_2 [0] = ! cmd_reg_d [1] ;

assign      sel_mux_main_1 = !( (ps[0]) & (ps[1]) );

assign      enb_srch = ps[0] & ps[1] ;

assign      q2 = (!ps[1]) & dtin ;

assign      q4 = (!ps[0]) & ps[1] ;

assign      q5 = ps[0] & (!ps[1]) ;

assign      q3 = q4||q5 ;

assign      we = q5 ;

assign      enb_cnt = q4||q2    ;

assign      ce = q3 ;

assign      ce_cmd_reg_d = q4   ;  

assign      op_sr = q3||( srch & (!ps[1]) );

assign      rst_cnt = ( q2 & ( ps[0] || srch ) )|| q4 ;

assign      rst_reg_srdt  = q3 || ( ( q2 & srch ) );  

assign      sel_reg_srdt = q3 || q2 ;

assign      sel_reg_ma = ps[1] ;



//always@(*)
//    case(cmd_reg_d)
//        S0 :                                //00
//             begin
//                sel_reg_d <= 3'b000;
//                sel_mux_reg_d <= 3'b000;
//             end
//        S1 :                                //01
//             begin
//                sel_reg_d <= cmd_reg_in;
//                sel_mux_reg_d <= 3'b000;
//             end
//        S2 :                                //10
//            begin
//                sel_reg_d <= 3'b000;
//                sel_mux_reg_d <= cmd_reg_out;
//            end
//        S3 :                                //11
//            begin 
//                sel_reg_d <= cmd_reg_in;
//                sel_mux_reg_d <= cmd_reg_out; 
//            end
//    endcase

assign      sel_mux_reg_d [2] = out_incoder [2] & cmd_reg_d [1] ;
assign      sel_mux_reg_d [1] = out_incoder [1] & cmd_reg_d [1] ;
assign      sel_mux_reg_d [0] = out_incoder [0] & cmd_reg_d [1] ;

assign      sel_reg_d [2] = cmd_reg_in [2] & cmd_reg_d [0] ;
assign      sel_reg_d [1] = cmd_reg_in [1] & cmd_reg_d [0] ;
assign      sel_reg_d [0] = cmd_reg_in [0] & cmd_reg_d [0] ;

always@(*)
    case(out_incoder)
        R0 :
            begin 
                cmd_reg_in <= 3'b001 ;
            end
        R1 : 
            begin
                cmd_reg_in <= 3'b010 ;
            end
        R2 :
             begin
                cmd_reg_in <= 3'b011 ;
             end
        R3 : 
             begin
                cmd_reg_in <= 3'b100 ;
             end
        R4 :
             begin
                cmd_reg_in <= 3'b101 ;
             end
        R5 : 
             begin
                cmd_reg_in <= 3'b110 ;
             end
        R6 : 
            begin
                cmd_reg_in <= 3'b111 ;
            end
        R7 : 
            begin 
                cmd_reg_in <= 3'b000 ;     
            end
    endcase

endmodule