module filtro (
	 input clk, img, sel, valid,
    output img_out, valid_out
);

	// Buffers
	reg [255:0] reg0; 
	reg [255:0] reg1; 
	reg [2:0] reg2; 
	reg v_out;
	 
	// Janela de aplicação do filtro
	wire [8:0] window; 

	// Atualizando os buffers com o pixel novo usando shif dos bits armazenados
	always @(posedge clk) begin
			if (valid) begin
			  reg0 <= {reg0[254:0], reg1[255]}; 
			  reg1 <= {reg1[254:0], img}; 
			  reg2 <= {reg2[1:0], reg0[255]};     
			  v_out <= valid;
			end
	end

	// Janela com o pixel central e seus 8 vizinhos
	assign window = {reg0[2:0], reg1[2:0], reg2};
	assign valid_out = valid;
	assign img_out = valid ? ((sel) ? &window : |window) : 1'b0;

endmodule