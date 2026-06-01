module concatenacao(a,b,s);
input [9:0] a;
input [9:0] b;
output [14:0] s;

assign s = { b[6:0],a[7:0]};

endmodule
