module led_7_doan(
    input wire clk,               // Xung nhịp
    input wire [6:0] value,       // Giá trị 7-bit đầu vào (0-99)           
    output reg [6:0] seg,         // Dữ liệu hiển thị LED 7 đoạn
    output reg [1:0] led_select   // Chọn LED (1: hàng chục, 0: hàng đơn vị)
);

    reg [3:0] tens;               // Chữ số hàng chục
    reg [3:0] units;              // Chữ số hàng đơn vị
    reg toggle = 0;

    always @(posedge clk) begin
        tens  <= value / 10;       // Tách hàng chục
        units <= value % 10;       // Tách hàng đơn vị
        toggle <= ~toggle;         // Chuyển đổi LED hiển thị
    end

    always @(*) begin
        case (toggle)
            1'b0: begin
                seg = decode(units);  // Hiển thị hàng đơn vị
                led_select[0] = 0;
                led_select[1] = 1;
            end
            1'b1: begin
                seg = decode(tens);   // Hiển thị hàng chục
                led_select[0] = 1;
                led_select[1] = 0;
            end
        endcase
    end

    function [6:0] decode;
        input [3:0] num;
        case (num)
            4'd0: decode = 7'b0111111;
            4'd1: decode = 7'b0000110;
            4'd2: decode = 7'b1011011;
            4'd3: decode = 7'b1001111;
            4'd4: decode = 7'b1100110;
            4'd5: decode = 7'b1101101;
            4'd6: decode = 7'b1111101;
            4'd7: decode = 7'b0000111;
            4'd8: decode = 7'b1111111;
            4'd9: decode = 7'b1101111;
            default: decode = 7'b0000000;
        endcase
    endfunction
endmodule
