module if_test (a, b, c, d, e, sel, z);

    input a, b, c, d, e;
    input [3:0] sel;
    output reg z;

    always @(a or b or c or d or e or sel) begin
        z = e;
        if(sel[0]) z = a;
        if(sel[1]) z = b;
        if(sel[2]) z = c;
        if(sel[3]) z = d;
    end

    always @(a or b or c or d or e or sel) begin
        z = e;
        if(sel[0]) z = a;
        else if(sel[1]) z = b;
        else if(sel[2]) z = c;
        else if(sel[3]) z = d;
    end

endmodule
