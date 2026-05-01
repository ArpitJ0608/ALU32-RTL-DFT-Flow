module ALU_32(

        input [31:0] a,b,

        input clk,

        input rst,

        input [2:0] sel,

        output carry_out,

        output reg [32:0] out);



reg [32:0] temp;

always @(*)

begin

        case(sel)

                3'b000: temp = a+b;

                3'b001: temp = a-b;

                3'b010: temp = {1'b0, a&b};

                3'b011: temp = {1'b0, a|b};

                3'b100: temp = {1'b0, a^b};

                3'b101: temp = {1'b0,~(a&b)};

                default: temp = 32'b0;

         endcase



end

always @(posedge clk or posedge rst) begin

        if(rst) begin

                out <=32'b0;

                carry_out<=1'b0;

        end

        else begin

                out<= temp[31:0];

                carry_out<=temp[32];

        end



end

endmodule
