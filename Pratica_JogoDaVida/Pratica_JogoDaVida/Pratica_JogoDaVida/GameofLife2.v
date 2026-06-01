module GameOfLife (
    input wire clk,     
    input wire reset,   
    input wire start, 
    output reg [4095:0] grid_state
);

    localparam NCELLS = 4096;          // 64x64
    reg [4095:0] actual_grid;          // Registrador que guarda a geração atual
    reg [4095:0] next_grid;            // Registrador que constrói a próxima geração
    
    // Estados da máquina
    localparam ST_IDLE = 2'd0, ST_RUN = 2'd1, ST_DONE = 2'd2;
    reg [1:0] state;                  
    
    // Contadores de controle
    reg [11:0] addr_cnt;               // Contador que varre todas as 4096 células (0 a 4095)
    reg [2:0] drain_cnt;               // Contador de atraso (pipeline) para garantir que os últimos cálculos terminem

    // Pipeline de processamento com 4 estágios
    // Estágio 1: Lê o endereço, pega o estado da célula e soma os vizinhos
    reg [11:0] s1_addr; reg s1_cell; reg s1_vld; reg [3:0] s1_sum;
    // Estágio 2: Repassa os dados adiante (Buffer/Atraso)
    reg [11:0] s2_addr; reg s2_cell; reg s2_vld; reg [3:0] s2_sum;
    // Estágio 3: Repassa os dados adiante (Buffer/Atraso)
    reg [11:0] s3_addr; reg s3_cell; reg s3_vld; reg [3:0] s3_sum;
    // Estágio 4: Aplica as regras de Conway baseadas na soma e salva no next_grid
    reg [11:0] s4_addr; reg s4_next; reg s4_vld;

    // Converte o índice linear em coordenadas row e coluna
    wire [5:0] r = addr_cnt / 64; 
    wire [5:0] c = addr_cnt % 64;

    // Detectores de borda
    wire up    = (r != 0);        
    wire down  = (r != 63);       
    wire left  = (c != 0);        
    wire right = (c != 63);    

    wire [11:0] idx = addr_cnt;
    // Pega o valor (1 vivo, 0 morto) dos 8 vizinhos ao redor da célula atual.
    // Se a célula estiver em uma borda (ex: up == 0), aquele vizinho específico retorna 0.
    wire [3:0] n0 = (up   && left  ? {3'b0, actual_grid[idx - 65]} : 4'd0); 
    wire [3:0] n1 = (up            ? {3'b0, actual_grid[idx - 64]} : 4'd0); 
    wire [3:0] n2 = (up   && right ? {3'b0, actual_grid[idx - 63]} : 4'd0); 
    wire [3:0] n3 = (left          ? {3'b0, actual_grid[idx -  1]} : 4'd0); 
    wire [3:0] n4 = (right         ? {3'b0, actual_grid[idx +  1]} : 4'd0); 
    wire [3:0] n5 = (down && left  ? {3'b0, actual_grid[idx + 63]} : 4'd0); 
    wire [3:0] n6 = (down          ? {3'b0, actual_grid[idx + 64]} : 4'd0); 
    wire [3:0] n7 = (down && right ? {3'b0, actual_grid[idx + 65]} : 4'd0); 

    // Total de vizinhos vivos
    wire [3:0] total_neigh = n0+n1+n2+n3+n4+n5+n6+n7;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Se o botão de reset for apertado, zera todas as variáveis
            state     <= ST_IDLE;
            addr_cnt  <= 0;
            drain_cnt <= 0;
            {s1_vld, s2_vld, s3_vld, s4_vld} <= 4'b0;
            actual_grid <= 0;
            next_grid   <= 0;
            
            // Desenha o padrão inicial
            actual_grid[2080] <= 1;
            actual_grid[2081] <= 1;
            actual_grid[2082] <= 1;
            
            actual_grid[2144] <= 1;
				actual_grid[2145] <= 0;
            actual_grid[2146] <= 1;
            
            actual_grid[2208] <= 1;
            actual_grid[2209] <= 1;
            actual_grid[2210] <= 1;
            
        end else begin
            // Comportamento baseado no estado atual
            case (state)
                ST_IDLE: begin
                    if (start) begin
                        addr_cnt <= 0;
                        {s1_vld, s2_vld, s3_vld, s4_vld} <= 4'b0;
                        next_grid <= 0;
                        state <= ST_RUN;
                    end
                end

                ST_RUN: begin
                    // --- Injeta a célula atual no pipeline (Estágio 1) ---
                    s1_addr <= addr_cnt;
                    s1_cell <= actual_grid[addr_cnt];
                    s1_sum  <= total_neigh;   
                    s1_vld  <= 1; // Marca que este dado é válido

                    // --- Empurra os dados pelo pipeline (Estágios 2 e 3) ---
                    s2_addr <= s1_addr; s2_cell <= s1_cell; s2_sum  <= s1_sum; s2_vld  <= s1_vld;
                    s3_addr <= s2_addr; s3_cell <= s2_cell; s3_sum  <= s2_sum; s3_vld  <= s2_vld;

                    // Aplica as regras do jogo
                    s4_addr <= s3_addr;
                    s4_vld  <= s3_vld;
                    // Se estiver viva (s3_cell = 1): Sobrevive se tiver 2 ou 3 vizinhos.
                    // Se estiver morta (s3_cell = 0): Nasce se tiver exatamente 3 vizinhos.
                    s4_next <= s3_cell ?
                        (s3_sum == 4'd2 || s3_sum == 4'd3) :  
                        (s3_sum == 4'd3);                      

                    // Se a validação for verdadeira, grava a nova célula no mapa futuro
                    if (s4_vld)
                        next_grid[s4_addr] <= s4_next;

                    if (addr_cnt == 12'd4095) begin
                        state    <= ST_DONE;
                        drain_cnt <= 0;
                    end else begin
                        addr_cnt <= addr_cnt + 1; // Vai para a próxima
                    end
                end

                ST_DONE: begin
                    // Como o contador principal parou, não geramos mais dados novos (s1_vld = 0)
                    s1_vld  <= 0;          

                    // Mas precisamos continuar empurrando as últimas 3 células que ainda 
                    // estão presas nos canos do pipeline para o next_grid
                    s2_addr <= s1_addr; s2_cell <= s1_cell; s2_sum  <= s1_sum;  s2_vld  <= s1_vld;
                    s3_addr <= s2_addr; s3_cell <= s2_cell; s3_sum  <= s2_sum;  s3_vld  <= s2_vld;
                    s4_addr <= s3_addr; s4_vld  <= s3_vld;
                    s4_next <= s3_cell ?
                        (s3_sum == 4'd2 || s3_sum == 4'd3) :
                        (s3_sum == 4'd3);

                    if (s4_vld)
                        next_grid[s4_addr] <= s4_next;

                    // O drain_cnt conta quantos ciclos esperamos o pipeline esvaziar
                    drain_cnt <= drain_cnt + 1;

                    if (drain_cnt == 3'd4) begin     
                        actual_grid <= next_grid; 
                        next_grid   <= 0;        
                        addr_cnt    <= 0;        
                        {s1_vld, s2_vld, s3_vld, s4_vld} <= 4'b0;
                        state       <= ST_RUN; 
                    end
                end

            endcase
        end
    end

    // Atualiza a saída para que o módulo de VGA consiga ler os pixels
    always @(posedge clk)
        grid_state <= actual_grid;

endmodule