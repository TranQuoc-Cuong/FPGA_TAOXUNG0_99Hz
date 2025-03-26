module chia_xung (
    input main_clk,
    input [6:0]count_set,
    output reg out
);

parameter Clock_frequency  = 27_000_000;

reg [24:0] count;

always @(posedge main_clk)
begin
    
    if(count <= ((((Clock_frequency/2)-1) / count_set)-1)) count <= count + 1'b1;
    else begin
        count <= 0;
        out <= ~out;
    end

end
    
endmodule