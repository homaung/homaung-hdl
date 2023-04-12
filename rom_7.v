module rom_7(                                           //만약 데이터와 찾는 데이터 같다는 신호가 입력 될시
             a,                                         //주소를 Right shift 한칸 하고 1bit에 1을 출력해 memory_addrss에 입력시키는 rom
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
output wire [D-1:0]c
;
assign c[7]= a[6] & b;
assign c[6]= a[5] & b;
assign c[5]= a[4] & b;
assign c[4]= a[3] & b;
assign c[3]= a[2] & b;
assign c[2]= a[1] & b;
assign c[1]= a[0] & b;
assign c[0]= b;
endmodule
