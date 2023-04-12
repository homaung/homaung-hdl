module memory_ad(
    clk         ,
    ce          ,
    we          ,
    addr        ,
    data        ,
    q   
);

//parameter
parameter A=8, D=8, R=256; // A : Adress width    D : Data width    R : 2^A

//input & output
input                   clk           ;
input                   ce            ;       //chip enable (읽기/쓰기를 수행할 때 1로 인가)
input                   we            ;       //write enable (읽기: 0, 쓰기: 1)
input       [      A-1:0] addr        ;
input       [      D-1:0] data        ;
output      [      D-1:0] q           ;

//wire & regs
reg         [      D-1:0]  mem[R-1:0] ;
reg         [      A-1:0]  r_addr     ;
reg                        zero       ;

//logic
always @ (posedge clk)
    begin
        if (ce)  
            begin
                if (we) 
                    begin
                        if(!zero)
                            mem[addr] <= 8'b00000000;   //메모리 주소가 0이면 데이터가 무조건 0
                        else
                            mem[addr] <= data;
                    end 
                r_addr <= addr;
            end
    end


always @ (*)
    begin
        zero = |addr;                               // "|" 연산자는 입력값 중 하나 이상이 1이면 1을 출력합니다.
    end


assign q = mem[r_addr];

endmodule