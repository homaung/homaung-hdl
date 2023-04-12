module mux_7bit_3sel (
                        sel,
                        input0,
                        input1,
                        input2,
                        input3,
                        input4,
                        input5,
                        input6,
                        input7,
                        out
);
input [2:0] sel
;
input [6:0] input0,
            input1,
            input2,
            input3,
            input4,
            input5,
            input6,
            input7
;
output reg [6:0] out 
;
  always @(*) 
    begin
        case (sel)
            3'b000 : out = input0;
            3'b001 : out = input1;
            3'b010 : out = input2;
            3'b011 : out = input3;
            3'b100 : out = input4;
            3'b101 : out = input5;
            3'b110 : out = input6;
            3'b111 : out = input7;
            default: out = 8'h00; // 에러 상황 대응
        endcase
    end
endmodule

