module And_Gate_Project
 (input i_Switch_1,
  input i_Switch_2,
  output o_LED_1);
assign o_LED_1 = i_Switch_1 & i_Switch_2;
endmodule