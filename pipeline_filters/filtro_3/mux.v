module mux(
input a, b, select,
output c
);

assign c = (!select) ? a : b;


endmodule