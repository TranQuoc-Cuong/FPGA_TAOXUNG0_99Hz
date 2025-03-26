module dieu_khien_nut(
    input main_clk,
    input btn_up, btn_dwn,
    output reg [6:0] count
);

reg btn_up_old = 0, btn_dwn_old = 0;
reg [19:0] debounce_counter_up = 0, debounce_counter_dwn = 0;
reg btn_up_stable = 0, btn_dwn_stable = 0;
parameter DEBOUNCE_LIMIT = 540000;  // Thời gian debouncing 

always @(posedge main_clk)
begin
    // Debouncing cho nút up
    if (btn_up != btn_up_stable) begin
        debounce_counter_up <= debounce_counter_up + 1;
        if (debounce_counter_up >= DEBOUNCE_LIMIT) begin
            btn_up_stable = btn_up;
            debounce_counter_up <= 0;
        end
    end

    // Debouncing cho nút down
    if (btn_dwn != btn_dwn_stable) begin
        debounce_counter_dwn <= debounce_counter_dwn + 1;
        if (debounce_counter_dwn >= DEBOUNCE_LIMIT) begin
            btn_dwn_stable = btn_dwn;
            debounce_counter_dwn <= 0;
        end
    end 

    // Kiểm tra nút up sau khi debouncing
    if (count < 99 && btn_up_stable) begin
        if (btn_up_old == 0) begin
            count = count + 1'b1;
            btn_up_old = 1;
        end
    end else if (btn_up_stable == 0) begin
        btn_up_old = 0;
    end

    // Kiểm tra nút down sau khi debouncing
    if (count > 1 && btn_dwn_stable) begin
        if (btn_dwn_old == 0) begin
            count = count - 1'b1;
            btn_dwn_old = 1;
        end
    end else if (btn_dwn_stable == 0) begin
        btn_dwn_old = 0;
    end
end

endmodule
