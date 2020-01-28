module bitserialadd_mealy(
   input  clk,
   input  reset,
   input  a,
   input  b,
   output reg q
);

  // symbolic state assignment
  localparam S0 = 0, S1 = 1;    

   // state register
  (* syn_encoding = "default" *) reg state, statenext;

  // register
  always @(posedge clk)
   begin
    if (reset)       // synchronous reset
      state <= S0;   // initial state
    else
      state <= statenext;
   end


  // next-state logic
  always @(*)
   begin
   statenext = state;  // always add a default assignment
   case (state)
     S0:       statenext = ({a,b} == 2'b11) ? S1 : S0;
     S1:       statenext = ({a,b} == 2'b00) ? S0 : S1;
     default:  statenext = S0;
     endcase
   end
      
   // output function
   always @(*) begin
      case (state)
         S0:      q = (a^b) ? 1'b1 : 1'b0;
         S1:      q = (a^b) ? 1'b0 : 1'b1;
         default: q = 1'bx;
      endcase
   end

endmodule