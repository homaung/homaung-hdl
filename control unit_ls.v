module ctu_ls  (sch_adr1,
                sch_adr2,
                ce_ctu,
                we_ctu,
                sel_ce_ctu,
                sel_we_ctu,
                sel_adr,
                clk


               );




//Parameter
parameter A=8,  D=8;           // A : Adress width    D : Data width    

//wire&reg
input wire [A-1:0] sch_adr1;
input wire [A-1:0] sch_adr2;
input wire  clk;
output reg  ce_ctu,
            we_ctu,
            sel_ce_ctu,
            sel_we_ctu,
            sel_adr
            ;
reg  [A-1:0] sch_adr_str;
reg  [A-1:0] sch_adr_end;
reg reset_cp,
    select,
    same
    ;

//Instance

    
//logic  
    
    
endmodule