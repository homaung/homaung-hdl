module rom_8(                                           //만약 데이터와 찾는 데이터 같다는 신호가 입력 될시 출력
             a,                                       
             b,
             c
);
    
parameter               
                        D=8                          // D : Data width                  
;      

input wire [D-1:0] a
;
input wire b
;                  
output wire [D-2:0]c
;


assign c[6]= a[7] & b;
assign c[5]= a[6] & b;
assign c[4]= a[5] & b;
assign c[3]= a[4] & b;
assign c[2]= a[3] & b;
assign c[1]= a[2] & b;
assign c[0]= a[1] & b;
endmodule