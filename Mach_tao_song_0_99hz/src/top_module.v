module top_module(
    input main_clk,
    input btn_up, btn_dwn,
    output [6:0] leds,
    output [1:0] segment,
    output out_pulse
);
wire [6:0] count; 

dieu_khien_nut u0 (main_clk, btn_up, btn_dwn, count);
chia_xung u1 (main_clk, count, out_pulse);
led_7_doan u2 (main_clk, count, leds, segment);

endmodule