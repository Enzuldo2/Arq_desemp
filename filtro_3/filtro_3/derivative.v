module derivative_filter(
	 input clk, img, valid,
    output img_out
);

	// Buffers
	reg [255:0] reg0; 
	reg [255:0] reg1; 
	reg [2:0] reg2; 
	 
	// Janela de aplicação do filtro
	wire w0, w1, w2, w3, w4, w5, w6, w7, w8;
	
	// Fios para cálculo da convolução
	wire [2:0] gx0, gx1, gx2, gx3, gx4, gx5, gx6, gx7, gx8;
	wire [2:0] gy0, gy1, gy2, gy3, gy4, gy5, gy6, gy7, gy8;
	wire [3:0] gx;
	wire [3:0] gy;
	wire [3:0] gx_abs;
	wire [3:0] gy_abs;
	wire [4:0] magnitude;
	wire pixel;

	// Atualizando os buffers com o pixel novo usando shif dos bits armazenados
	always @(posedge clk) begin
			if (valid) begin
			  reg0 <= {reg0[254:0], reg1[255]}; 
			  reg1 <= {reg1[254:0], img}; 
			  reg2 <= {reg2[1:0], reg0[255]};     
			end
	end

	// Janela com o pixel central e seus 8 vizinhos
	assign w8 = reg0[2];
	assign w7 = reg0[1];
	assign w6 = reg0[0];
	assign w5 = reg1[2];
	assign w4 = reg1[1];
	assign w3 = reg1[0];
	assign w2 = reg2[2];
	assign w1 = reg2[1];
	assign w0 = reg2[0];
	
	// Termos de GX positivos
	assign gx0 = {2'b0, w0};
	assign gx1 = 3'b0;
	assign gx3 = {1'b0, w3, 1'b0};
	assign gx4 = 3'b0;
	assign gx6 = {2'b0, w6};
	assign gx7 = 3'b0;
	
	// Termos de GX negativos
	assign gx2 = {2'b0, w2};
	assign gx5 = {1'b0, w5, 1'b0};
	assign gx8 = {2'b0, w8};
	
	wire [2:0]gx_pos = gx7 + gx6 + gx4 + gx3 + gx1 + gx0;
	wire [2:0]gx_neg = gx2 + gx5 + gx8;
	
	assign gx = $signed({1'b0, gx_pos}) - $signed({1'b0, gx_neg});
	
	// Termos de GY positivos
	assign gy0 = {2'b0, w0};
	assign gy1 = {1'b0, w1, 1'b0};
	assign gy2 = {2'b0, w2};
	assign gy3 = 3'b0;
	assign gy4 = 3'b0;
	assign gy5 = 3'b0;
	
	// Termos de GX negativos
	assign gy6 = {2'b0, w6};
	assign gy7 = {1'b0, w7, 1'b0};
	assign gy8 = {2'b0, w8};
	
	wire [2:0]gy_pos = gy5 + gy4 + gy3 + gy2 + gy1 + gy0;
	wire [2:0]gy_neg = gy6 + gy7 + gy8;
	
	assign gy = $signed({1'b0, gy_pos}) - $signed({1'b0, gy_neg});
							
	// Módulo de GX e GY
	assign gx_abs = gx[3] ? !gx+1'b1 : gx;
	assign gy_abs = gy[3] ? !gy+1'b1 : gy;
	
	assign magnitude = gx_abs + gy_abs;

	// Bordas brancas e resto preto
	assign pixel = (magnitude >= 2) ? 1'b1 : 1'b0;
	
	assign img_out = valid ? pixel : 1'b0;
	
endmodule