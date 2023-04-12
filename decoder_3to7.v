module decoder_3to7(
                    in,
                    out
);
input [2:0] in
;
output reg [6:0] out
;
always @* begin
    case (in)
        3'b000: out <= 7'b0000000;
        3'b001: out <= 7'b0000001;
        3'b010: out <= 7'b0000010;
        3'b011: out <= 7'b0000100;
        3'b100: out <= 7'b0001000;
        3'b101: out <= 7'b0010000;
        3'b110: out <= 7'b0100000;
        3'b111: out <= 7'b1000000;
    endcase
end

endmodule
