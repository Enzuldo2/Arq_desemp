module core #(
    parameter DEST_X = 3, // Coordenada X do próximo destino
    parameter DEST_Y = 3  // Coordenada Y do próximo destino
)(
    input  wire clk,
    input  wire reset,
	 input wire sel,
    
    // Interface com o Roteador Local
    input  wire [5:0] from_router,
    output wire [5:0] to_router
);

    wire valid_in = from_router[1];
    wire img_in   = from_router[0];

    // --- VARIÁVEIS INTERNAS DO FILTRO ---
    reg [255:0] reg0; 
    reg [255:0] reg1; 
    reg [2:0]   reg2; 

    wire [8:0] window;
    wire valid_out;
    wire img_out;

    // --- LÓGICA DO FILTRO ---
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            reg0 <= 256'b0;
            reg1 <= 256'b0;
            reg2 <= 3'b0;
        end else if (valid_in) begin
				reg1 <= {reg1[254:0], img_in}; 
            reg0 <= {reg0[254:0], reg1[255]}; 
            reg2 <= {reg2[1:0], reg0[255]};     
        end
    end

    assign window = {reg0[2:0], reg1[2:0], reg2};
    assign valid_out = valid_in;
    assign img_out = valid_in ? (sel ? &window : |window) : 1'b0;

    // =========================================================
    // EMPACOTAMENTO PARAMETRIZADO
    // =========================================================
    // Montando o pacote com os parâmetros definidos lá em cima
    // Cortamos para [1:0] apenas para garantir que tenham 2 bits
    assign to_router = {DEST_X[1:0], DEST_Y[1:0], valid_out, img_out};

endmodule