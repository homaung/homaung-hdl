module rom_main2(       a                   ,        
                        b
);
parameter               N = 8                       
;                                                               

input  wire [N-1:0]     a                   ;
output wire [N-2:0]     b                   ;

wire                    c                   ;
assign c = !a[0] ;


assign b[7] = a[8] & c ;
assign b[6] = a[7] & c ;
assign b[5] = a[6] & c ;
assign b[4] = a[5] & c ;
assign b[3] = a[4] & c ;
assign b[2] = a[3] & c ;
assign b[1] = a[2] & c ;
assign b[0] = a[1] & c ;

endmodule 
