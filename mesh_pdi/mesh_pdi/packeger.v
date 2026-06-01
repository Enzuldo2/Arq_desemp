module packeger (
    input wire pixel_in,
    input wire valid_in,    
    output wire [5:0] pack_out
);

    // Definindo o endereço de destino (Grid 4x4)
	 // Por enquanto, eles estão hardcoded, mas a ideia é ser dinâmico
    wire [1:0] dest_x = 2'b00; 
    wire [1:0] dest_y = 2'b00;    

    // Empacotamento estruturado: 
    // [5:4] = X (2 bits)
    // [3:2] = Y (2 bits)
    // [1]   = Valid (1 bit)
    // [0]   = Pixel (1 bit)
    assign pack_out = {dest_x, dest_y, valid_in, pixel_in};
    
endmodule