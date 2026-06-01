module despackeger (
    input wire [5:0] pack_in,  
    output wire pixel_out
);

    // O pixel é sempre o bit menos significativo
    assign pixel_out = pack_in[0];
    
endmodule