module rom_10(
            a,
            b

);
input wire [6:0] a;
output wire [2:0] b;

assign b[0] = a[6]|(!a[5]&a[4])|(!a[5]&!a[3]&a[2])|(!a[5]&!a[3]&!a[1]&a[0]);
assign b[1] = a[6]|a[5]|(!a[4]&!a[3]&a[2])|(!a[4]&!a[3]&a[1]);
assign b[2] = a[6]|a[5]|a[4]|a[3];

endmodule
