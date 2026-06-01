module router #(
    parameter X = 0, 
    parameter Y = 0  
)(
    input wire clk,
    input wire reset,

    // Interfaces de 6 bits: [5:4] X, [3:2] Y, [1] Valid, [0] Pixel
    input wire  [5:0] in_west,
    output reg  [5:0] out_west,

    input wire  [5:0] in_east,
    output reg  [5:0] out_east,

    input wire  [5:0] in_north,
    output reg  [5:0] out_north,
     
    input wire  [5:0] in_south,
    output reg  [5:0] out_south,
     
    input wire  [5:0] in_core,
    output reg  [5:0] out_core
);

    // Fios internos para calcular o próximo estado das saídas
    reg [5:0] next_out_west;
    reg [5:0] next_out_east;
    reg [5:0] next_out_north;
    reg [5:0] next_out_south;
    reg [5:0] next_out_core;

    // =========================================================================
    // BLOCO 1: LÓGICA COMBINACIONAL DE ROTEAMENTO (Algoritmo XY e Arbitragem)
    // =========================================================================
    always @(*) begin
        // Valores padrão: Limpa os próximos estados (derruba o valid para 0)
        next_out_west  = 6'b0;
        next_out_east  = 6'b0;
        next_out_north = 6'b0;
        next_out_south = 6'b0;
        next_out_core  = 6'b0;

        // --- PACOTE VINDO DO CORE (Maior Prioridade) ---
        if (in_core[1]) begin
            if (in_core[5:4] > X) begin
                next_out_east = in_core;
            end else if (in_core[5:4] < X) begin
                next_out_west = in_core;
            end else if (in_core[3:2] > Y) begin
                next_out_north = in_core;
            end else if (in_core[3:2] < Y) begin
                next_out_south = in_core;
            end
        end

        // --- PACOTE VINDO DO OESTE (Viajando para a Direita) ---
        if (in_west[1]) begin
            // Verifica se a saída já não foi tomada por uma prioridade maior (!next_out_east[1])
            if (in_west[5:4] > X && !next_out_east[1]) begin
                next_out_east = in_west;
            end 
            else if (in_west[5:4] == X) begin
                if (in_west[3:2] > Y && !next_out_north[1]) begin
                    next_out_north = in_west;
                end else if (in_west[3:2] < Y && !next_out_south[1]) begin
                    next_out_south = in_west;
                end else if (in_west[3:2] == Y && !next_out_core[1]) begin
                    next_out_core = in_west; // CHEGOU NO DESTINO!
                end
            end
        end

        // --- PACOTE VINDO DO LESTE (Viajando para a Esquerda) ---
        if (in_east[1]) begin
            if (in_east[5:4] < X && !next_out_west[1]) begin
                next_out_west = in_east;
            end 
            else if (in_east[5:4] == X) begin
                if (in_east[3:2] > Y && !next_out_north[1]) begin
                    next_out_north = in_east;
                end else if (in_east[3:2] < Y && !next_out_south[1]) begin
                    next_out_south = in_east;
                end else if (in_east[3:2] == Y && !next_out_core[1]) begin
                    next_out_core = in_east; // CHEGOU NO DESTINO!
                end
            end
        end

        // --- PACOTE VINDO DO SUL (Viajando para Cima) ---
        if (in_south[1]) begin
            if (in_south[3:2] > Y && !next_out_north[1]) begin
                next_out_north = in_south;
            end else if (in_south[3:2] == Y && !next_out_core[1]) begin
                next_out_core = in_south; // CHEGOU NO DESTINO!
            end
        end

        // --- PACOTE VINDO DO NORTE (Viajando para Baixo) ---
        if (in_north[1]) begin
            if (in_north[3:2] < Y && !next_out_south[1]) begin
                next_out_south = in_north;
            end else if (in_north[3:2] == Y && !next_out_core[1]) begin
                next_out_core = in_north; // CHEGOU NO DESTINO!
            end
        end
    end

    // =========================================================================
    // BLOCO 2: REGISTRADORES SÍNCRONOS (Flip-Flops)
    // =========================================================================
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Se o reset for acionado, limpa completamente a rede
				$display("ATENÇÃO: reset ativo no tempo %t", $time);
            out_west  <= 6'b0;
            out_east  <= 6'b0;
            out_north <= 6'b0;
            out_south <= 6'b0;
            out_core  <= 6'b0;
        end else begin
            // Atualiza as portas físicas de saída com a decisão tomada pela lógica
            out_west  <= next_out_west;
            out_east  <= next_out_east;
            out_north <= next_out_north;
            out_south <= next_out_south;
            out_core  <= next_out_core;
				$display("TEMPO=%0t: Router(%0d,%0d) enviou NORTH X=%0d Y=%0d", $time, X, Y, out_north[5:4], out_north[3:2]);
        end
    end

endmodule