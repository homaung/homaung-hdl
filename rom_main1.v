module rom_main1(                                     //홀수일경우 1bit right shift  짝수일 경우 0 출력
                        a                   ,         
                        b

);
parameter               A=8                         
;                                                               

input  wire [A-1:0] a;
output wire [A-2:0] b;


assign b[7] = a[8] & a[0];
assign b[6] = a[7] & a[0];
assign b[5] = a[6] & a[0];
assign b[4] = a[5] & a[0];
assign b[3] = a[4] & a[0];
assign b[2] = a[3] & a[0];
assign b[1] = a[2] & a[0];
assign b[0] = a[1] & a[0];

endmodule 