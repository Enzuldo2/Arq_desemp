module LifeToVGA (
    input wire clk,             
    input wire reset,           
    input wire [4095:0] life_grid, 
    input wire [9:0] vga_x,     
    input wire [9:0] vga_y,     
    output reg pixel_out       
);
    localparam CELL = 10'd6;   // Cada célula do jogo será uma célula visual de 6x6 pixels
    localparam GRID = 10'd64;  // Grid do jogo: 64x64 células
    localparam X_OFFSET = 10'd128; // Margem esquerda
    localparam Y_OFFSET = 10'd48;  // Margem superior

    // Verifica se o monitor está varrendo a área do jogo ou não
	 // 128 < X < 128 + 64*6 (tamanho do jogo)
	 // 48 < Y < 48 + 64*6 (tamanho do jogo) 
    wire in_grid = (vga_x >= X_OFFSET) && (vga_x < X_OFFSET + CELL*GRID) &&
                   (vga_y >= Y_OFFSET) && (vga_y < Y_OFFSET + CELL*GRID);

    
    // X relativo -> jogo no "centro" da tela
	 // Ex: Se o VGA_X está em 128, no jogo ele está em 0
    wire [9:0] x_rel = vga_x - X_OFFSET;
    wire [9:0] y_rel = vga_y - Y_OFFSET;

    // Descobre em qual célula o pixel está
    wire [5:0] cell_col = x_rel / CELL;
    wire [5:0] cell_row = y_rel / CELL;
	 
	 // IDX = (celula_row * 64 + celula_col)
	 // Deslocamos o row 6 bits pra esquerda -> x64
	 // Somamos o col
    wire [11:0] cell_idx = {cell_row, cell_col};

    always @(posedge clk or posedge reset) begin
        if (reset)
            pixel_out <= 0;
        else
				// Pixel está fora -> desligado
				// Pixel está dentro -> valor do life grid
            pixel_out <= in_grid ? life_grid[cell_idx] : 1'b0;
    end

endmodule