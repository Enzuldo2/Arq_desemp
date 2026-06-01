module median_filter(
input pixel_in, clk,
output pixel_out
);



reg [479:0]line1;
reg [479:0]line2;
reg [2:0]pixels;

wire [8:0]window;

always @ (posedge clk) begin
		line1 <= {line1[478:0], line2[479]};
		line2 <= {line2[478:0], pixel_in};
		pixels <= {pixels[1:0], line1[479]};
		
end

assign window = {line1[2:0], line2[2:0], pixels};

wire [3:0] count = window[0] + window[1] + window[2] + 
                   window[3] + window[4] + window[5] + 
                   window[6] + window[7] + window[8];


assign pixel_out = (count >= 5);


endmodule