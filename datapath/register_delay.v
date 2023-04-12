module register_delay( 
                        data            ,
                        rst             ,
                        clk             ,
                        sel_mux         ,
                        out             ,
                        sel_reg         ,
                        reg_mc

);
//Parameter    
 parameter              
                    R=8                ,         //R : 2^A
                    A=3                ,         // A : Adress width  
                    D=7                          // D : Data width                  
;      
                                                         
//wire&reg
input wire [D-1:0] 
                    data
;

input wire [A-1:0] 
                    sel_mux             ,
                    sel_reg
;

input wire      
                    rst                 ,
                    clk
;

output wire [D-1:0] 
                    out
;
output wire [D-1:0] 
                    reg_mc
;
wire [R-2:0] 
                    sel0_out            ,
                    sel_out

;
wire
            sel0                        ,
            sel1                        ,
            sel2                        ,
            sel3                        ,
            sel4                        ,
            sel5                        ,
            sel6                        ,
            sel7                        ,
            sell1                       ,
            sell2                       ,
            sell3                       ,
            sell4                       ,
            sell5                       ,
            sell6                       ,
            sell7                       ,
            reg0_mc                     , 
            reg1_mc                     ,
            reg2_mc                     ,
            reg3_mc                     ,
            reg4_mc                     ,    
            reg5_mc                     ,
            reg6_mc                     ,
            reg7_mc                     ,
            tff1                        ,
            tff2                        ,
            tff3                        ,
            tff4                        ,
            tff5                        ,
            tff6                        ,
            tff7
;
wire[D-1:0] 
            input0                      ,
            input1                      ,
            input2                      ,
            input3                      ,
            input4                      ,
            input5                      ,
            input6                      ,
            input7
;

//instance

tff reg1_mct(

            .clk(clk)                   ,
            .rst(rst)                   ,
            .t(tff1)                    ,
            .q(reg1_mc)
  
);

tff reg2_mct(

            .clk(clk)                   ,
            .rst(rst)                   ,
            .t(tff2)                    ,
            .q(reg2_mc)
  
);

tff reg3_mct(

            .clk(clk)                   ,
            .rst(rst)                   ,
            .t(tff3)                    ,
            .q(reg3_mc)
  
);

tff reg4_mct(

            .clk(clk)                   ,
            .rst(rst)                   ,
            .t(tff4)                    ,
            .q(reg4_mc)
  
);


tff reg5_mct(

            .clk(clk)                   ,
            .rst(rst)                   ,
            .t(tff5)                    ,
            .q(reg5_mc)
  
); 

tff reg6_mct(

            .clk(clk)                   ,
            .rst(rst)                   ,
            .t(tff6)                    ,       
            .q(reg6_mc)
  
);

tff reg7_mct(

            .clk(clk)                   ,
            .rst(rst)                   ,
            .t(tff7)                    ,
            .q(reg7_mc)
  
);

decoder_3to7 decoder (

            .in(sel_reg)                ,
            .out(sel_out)

);

decoder_3to7 decoder1 (

            .in(sel_mux)                ,
            .out(sel0_out)

);

mux_7bit_3sel mux_delay (

            .sel(sel_mux)               ,
            .input0(input0)             ,
            .input1(input1)             ,
            .input2(input2)             ,
            .input3(input3)             ,
            .input4(input4)             ,
            .input5(input5)             ,
            .input6(input6)             ,
            .input7(input7)             ,
            .out(out)

);

register_7bits reg1 (   

            .data(data)                 ,
            .reset(rst)                 ,
            .q(input1)                  ,
            .select(sel1)               ,
            .clk(clk)

);
    
register_7bits reg2 (   

            .data(data)                 ,
            .reset(rst)                 ,
            .q(input2)                  ,
            .select(sel2)               ,
            .clk(clk)

);
    
register_7bits reg3 (   

            .data(data)                 ,
            .reset(rst)                 ,
            .q(input3)                  ,
            .select(sel3)               ,
            .clk(clk)

);    

register_7bits reg4 (  

            .data(data)                 ,
            .reset(rst)                 ,
            .q(input4)                  ,
            .select(sel4)               ,
            .clk(clk)
);

register_7bits reg5 (   

            .data(data)                 ,
            .reset(rst)                 ,
            .q(input5)                  ,
            .select(sel5)               ,
            .clk(clk)
);

register_7bits reg6 (   

            .data(data)                 ,
            .reset(rst)                 ,
            .q(input6)                  ,
            .select(sel6)               ,
            .clk(clk)
);

register_7bits reg7 (   

            .data(data)                 ,
            .reset(rst)                 ,
            .q(input7)                  ,
            .select(sel7)               ,
            .clk(clk)

);

//logic
assign input0 = 7'b0000000;

assign sel1 = sel_out[0];
assign sel2 = sel_out[1];
assign sel3 = sel_out[2];
assign sel4 = sel_out[3];
assign sel5 = sel_out[4];
assign sel6 = sel_out[5];
assign sel7 = sel_out[6];

assign sell1 = sel0_out[0];
assign sell2 = sel0_out[1];
assign sell3 = sel0_out[2];
assign sell4 = sel0_out[3];
assign sell5 = sel0_out[4];
assign sell6 = sel0_out[5];
assign sell7 = sel0_out[6];

assign tff1 = sel1^sell1;
assign tff2 = sel2^sell2;
assign tff3 = sel3^sell3;
assign tff4 = sel4^sell4;
assign tff5 = sel5^sell5;
assign tff6 = sel6^sell6;
assign tff7 = sel7^sell7;

assign reg_mc[0] = reg1_mc;
assign reg_mc[1] = reg2_mc;
assign reg_mc[2] = reg3_mc;
assign reg_mc[3] = reg4_mc;
assign reg_mc[4] = reg5_mc;
assign reg_mc[5] = reg6_mc;
assign reg_mc[6] = reg7_mc;

endmodule