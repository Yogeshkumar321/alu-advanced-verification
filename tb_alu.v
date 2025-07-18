`timescale 1ns/1ps
module tb_alu;
    reg [31:0] a, b;
    reg [2:0] op;
    wire [31:0] result;
    wire zero, carry;
    integer i, errors;
    alu dut (.a(a), .b(b), .op(op), .result(result), .zero(zero), .carry(carry));
    initial begin
        errors = 0;
        for(i=0; i<100; i=i+1) begin
            a = $random;
            b = $random;
            op = $random % 8;
            #5;
            case(op)
                3'b000: if(result !== a + b) errors = errors + 1;
                3'b001: if(result !== a - b) errors = errors + 1;
                3'b010: if(result !== (a & b)) errors = errors + 1;
                3'b011: if(result !== (a | b)) errors = errors + 1;
                3'b100: if(result !== (a ^ b)) errors = errors + 1;
                3'b101: if(result !== ~(a & b)) errors = errors + 1;
                3'b110: if(result !== (a << 1)) errors = errors + 1;
                3'b111: if(result !== (a >> 1)) errors = errors + 1;
            endcase
        end
        if(errors == 0) $display("TEST PASSED");
        else $display("TEST FAILED with %0d errors", errors);
        $finish;
    end
    initial begin
        $monitor("Time=%0t A=%d B=%d OP=%b Result=%d Zero=%b Carry=%b",$time,a,b,op,result,zero,carry);
    end
endmodule
