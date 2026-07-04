module janela(a,b,f);
input [9:0] a;
input [9:0] b;
output f;
reg f;

always@(a,b) begin

 if(a > 'd256 | b > 'd128)
	 begin
		f = 0;
	 end
 else 
	 begin	
		f = 1;
	 end
 
end

endmodule
