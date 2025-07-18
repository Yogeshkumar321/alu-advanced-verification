module alu (
    input [31:0] a, b,
    input [2:0] op,
    output reg [31:0] result,
    output zero, carry
);
    reg c;
    assign zero = (result == 0);
    assign carry = c;
    always @(*) begin
        case(op)
            3'b000: {c,result} = a + b;
            3'b001: {c,result} = a - b;
            3'b010: result = a & b;
            3'b011: result = a | b;
            3'b100: result = a ^ b;
            3'b101: result = ~(a & b);
            3'b110: result = a << 1;
            3'b111: result = a >> 1;
            default: result = 0;
        endcase
    end
endmodule
