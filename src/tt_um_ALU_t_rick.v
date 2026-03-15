module fulladder
  (input  carryin,
   input  summand1,
   input  summand2,
   output carryout,
   output sum);
  wire halfadder_carry;
  wire halfadder_sum;
  wire halfadder_carryintermediate;
  wire n201_o;
  wire n202_o;
  wire n203_o;
  wire n204_o;
  wire n205_o;
  assign carryout = n205_o;
  assign sum = n203_o;
  /* ../fullAdder.vhdl:15:12  */
  assign halfadder_carry = n201_o; // (signal)
  /* ../fullAdder.vhdl:16:12  */
  assign halfadder_sum = n202_o; // (signal)
  /* ../fullAdder.vhdl:17:12  */
  assign halfadder_carryintermediate = n204_o; // (signal)
  /* ../fullAdder.vhdl:19:33  */
  assign n201_o = summand1 & summand2;
  /* ../fullAdder.vhdl:20:31  */
  assign n202_o = summand1 ^ summand2;
  /* ../fullAdder.vhdl:21:26  */
  assign n203_o = halfadder_sum ^ carryin;
  /* ../fullAdder.vhdl:22:50  */
  assign n204_o = halfadder_sum & carryin;
  /* ../fullAdder.vhdl:23:45  */
  assign n205_o = halfadder_carryintermediate | halfadder_carry;
endmodule

module fulladder_4bit
  (input  carryin_4bit,
   input  [3:0] summand1_4bit,
   input  [3:0] summand2_4bit,
   output carryout_4bit,
   output [3:0] sum_4bit);
  wire carry0;
  wire carry1;
  wire carry2;
  wire c0_carryout;
  wire c0_sum;
  wire n182_o;
  wire n183_o;
  wire c1_carryout;
  wire c1_sum;
  wire n186_o;
  wire n187_o;
  wire c2_carryout;
  wire c2_sum;
  wire n190_o;
  wire n191_o;
  wire c3_carryout;
  wire c3_sum;
  wire n194_o;
  wire n195_o;
  wire [3:0] n198_o;
  assign carryout_4bit = c3_carryout;
  assign sum_4bit = n198_o;
  /* ../fullAdder_4bit.vhdl:16:12  */
  assign carry0 = c0_carryout; // (signal)
  /* ../fullAdder_4bit.vhdl:17:12  */
  assign carry1 = c1_carryout; // (signal)
  /* ../fullAdder_4bit.vhdl:18:12  */
  assign carry2 = c2_carryout; // (signal)
  /* ../fullAdder_4bit.vhdl:21:5  */
  fulladder c0 (
    .carryin(carryin_4bit),
    .summand1(n182_o),
    .summand2(n183_o),
    .carryout(c0_carryout),
    .sum(c0_sum));
  /* ../fullAdder_4bit.vhdl:24:38  */
  assign n182_o = summand1_4bit[0];
  /* ../fullAdder_4bit.vhdl:25:38  */
  assign n183_o = summand2_4bit[0];
  /* ../fullAdder_4bit.vhdl:30:5  */
  fulladder c1 (
    .carryin(carry0),
    .summand1(n186_o),
    .summand2(n187_o),
    .carryout(c1_carryout),
    .sum(c1_sum));
  /* ../fullAdder_4bit.vhdl:33:38  */
  assign n186_o = summand1_4bit[1];
  /* ../fullAdder_4bit.vhdl:34:38  */
  assign n187_o = summand2_4bit[1];
  /* ../fullAdder_4bit.vhdl:39:5  */
  fulladder c2 (
    .carryin(carry1),
    .summand1(n190_o),
    .summand2(n191_o),
    .carryout(c2_carryout),
    .sum(c2_sum));
  /* ../fullAdder_4bit.vhdl:42:38  */
  assign n190_o = summand1_4bit[2];
  /* ../fullAdder_4bit.vhdl:43:38  */
  assign n191_o = summand2_4bit[2];
  /* ../fullAdder_4bit.vhdl:48:5  */
  fulladder c3 (
    .carryin(carry2),
    .summand1(n194_o),
    .summand2(n195_o),
    .carryout(c3_carryout),
    .sum(c3_sum));
  /* ../fullAdder_4bit.vhdl:51:38  */
  assign n194_o = summand1_4bit[3];
  /* ../fullAdder_4bit.vhdl:52:38  */
  assign n195_o = summand2_4bit[3];
  /* ../tt_um_ALU_t_rick.vhdl:95:5  */
  assign n198_o = {c3_sum, c2_sum, c1_sum, c0_sum};
endmodule

module tt_um_ALU_t_rick
  (input  clk,
   input  rst_n,
   input  ena,
   input  [7:0] ui_in,
   input  [7:0] uio_in,
   output [7:0] uo_out,
   output [7:0] uio_out,
   output [7:0] uio_oe);
  wire [3:0] porta;
  wire [3:0] portb;
  wire [3:0] portb_ones_complement;
  wire [3:0] porta_ones_complement;
  wire [3:0] fulladder_sum;
  wire [3:0] andoutput;
  wire [3:0] oroutput;
  wire [3:0] xoroutput;
  wire [3:0] sloutput;
  wire [3:0] sroutputarithmetic;
  wire [3:0] sroutputlogic;
  wire [3:0] rloutput;
  wire [3:0] rroutput;
  wire [3:0] rltcoutput;
  wire [3:0] rrtcoutput;
  wire [3:0] muxoutput;
  wire carryintermediateadd;
  wire carryintermediaterl;
  wire carryintermediaterr;
  wire carryout;
  wire zflag;
  wire nflag;
  wire vflag;
  localparam [7:0] n3_o = 8'b00000000;
  wire [2:0] n5_o;
  wire n7_o;
  wire [3:0] n9_o;
  wire [3:0] n10_o;
  wire n20_o;
  wire n21_o;
  wire n22_o;
  wire n23_o;
  wire n24_o;
  wire n25_o;
  wire n26_o;
  wire n27_o;
  wire n28_o;
  wire n29_o;
  wire n30_o;
  wire n31_o;
  wire fulladder4bit_carryout_4bit;
  wire [3:0] fulladder4bit_sum_4bit;
  wire n33_o;
  wire [3:0] n37_o;
  wire [3:0] n40_o;
  wire [3:0] n43_o;
  wire [3:0] n46_o;
  wire [2:0] n49_o;
  wire [2:0] n53_o;
  wire n54_o;
  wire [2:0] n57_o;
  wire [2:0] n61_o;
  wire n62_o;
  wire [2:0] n65_o;
  wire n66_o;
  wire [2:0] n69_o;
  wire n70_o;
  wire [2:0] n73_o;
  wire n74_o;
  wire [3:0] n77_o;
  wire n79_o;
  wire n81_o;
  wire n83_o;
  wire n85_o;
  wire n87_o;
  wire n89_o;
  wire n91_o;
  wire n93_o;
  wire n95_o;
  wire n97_o;
  wire n99_o;
  wire n101_o;
  wire [11:0] n102_o;
  reg [3:0] n103_o;
  reg n113_o;
  wire n116_o;
  wire n117_o;
  wire n118_o;
  wire n119_o;
  wire n120_o;
  wire n121_o;
  wire n122_o;
  wire n123_o;
  wire n124_o;
  wire n125_o;
  wire n126_o;
  wire n127_o;
  wire n128_o;
  wire n129_o;
  wire n130_o;
  wire n131_o;
  wire n132_o;
  wire n133_o;
  wire n134_o;
  wire n135_o;
  wire n136_o;
  wire n137_o;
  wire n138_o;
  wire n139_o;
  wire n140_o;
  wire n141_o;
  wire n142_o;
  wire n143_o;
  wire n144_o;
  wire n145_o;
  wire n146_o;
  wire n147_o;
  wire n148_o;
  wire n149_o;
  wire n150_o;
  wire n151_o;
  wire n152_o;
  wire n153_o;
  wire n154_o;
  wire n155_o;
  wire n156_o;
  wire n157_o;
  wire n158_o;
  wire n161_o;
  wire [7:0] n163_o;
  reg [3:0] n168_q;
  reg [3:0] n169_q;
  wire [3:0] n170_o;
  wire [3:0] n171_o;
  wire [3:0] n172_o;
  wire [3:0] n173_o;
  wire [3:0] n174_o;
  wire [3:0] n175_o;
  wire [3:0] n176_o;
  wire [3:0] n177_o;
  reg [7:0] n178_q;
  wire [7:0] n179_o;
  assign uo_out = n178_q;
  assign uio_out = n179_o;
  assign uio_oe = n3_o;
  /* ../tt_um_ALU_t_rick.vhdl:22:12  */
  assign porta = n168_q; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:23:12  */
  assign portb = n169_q; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:24:12  */
  assign portb_ones_complement = n170_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:25:12  */
  assign porta_ones_complement = n46_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:26:12  */
  assign fulladder_sum = fulladder4bit_sum_4bit; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:27:12  */
  assign andoutput = n37_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:28:12  */
  assign oroutput = n40_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:29:12  */
  assign xoroutput = n43_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:30:12  */
  assign sloutput = n171_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:31:12  */
  assign sroutputarithmetic = n172_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:32:12  */
  assign sroutputlogic = n173_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:33:12  */
  assign rloutput = n174_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:34:12  */
  assign rroutput = n175_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:35:12  */
  assign rltcoutput = n176_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:36:12  */
  assign rrtcoutput = n177_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:37:12  */
  assign muxoutput = n103_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:38:12  */
  assign carryintermediateadd = fulladder4bit_carryout_4bit; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:39:12  */
  assign carryintermediaterl = n70_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:40:12  */
  assign carryintermediaterr = n74_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:41:12  */
  assign carryout = n113_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:42:12  */
  assign zflag = n123_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:43:12  */
  assign nflag = n124_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:44:12  */
  assign vflag = n158_o; // (signal)
  /* ../tt_um_ALU_t_rick.vhdl:50:34  */
  assign n5_o = uio_in[7:5];
  /* ../tt_um_ALU_t_rick.vhdl:54:19  */
  assign n7_o = ~rst_n;
  /* ../tt_um_ALU_t_rick.vhdl:58:27  */
  assign n9_o = ui_in[3:0];
  /* ../tt_um_ALU_t_rick.vhdl:59:27  */
  assign n10_o = ui_in[7:4];
  /* ../tt_um_ALU_t_rick.vhdl:65:42  */
  assign n20_o = portb[0];
  /* ../tt_um_ALU_t_rick.vhdl:65:56  */
  assign n21_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:65:46  */
  assign n22_o = n20_o ^ n21_o;
  /* ../tt_um_ALU_t_rick.vhdl:66:42  */
  assign n23_o = portb[1];
  /* ../tt_um_ALU_t_rick.vhdl:66:56  */
  assign n24_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:66:46  */
  assign n25_o = n23_o ^ n24_o;
  /* ../tt_um_ALU_t_rick.vhdl:67:42  */
  assign n26_o = portb[2];
  /* ../tt_um_ALU_t_rick.vhdl:67:56  */
  assign n27_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:67:46  */
  assign n28_o = n26_o ^ n27_o;
  /* ../tt_um_ALU_t_rick.vhdl:68:42  */
  assign n29_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:68:56  */
  assign n30_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:68:46  */
  assign n31_o = n29_o ^ n30_o;
  /* ../tt_um_ALU_t_rick.vhdl:71:5  */
  fulladder_4bit fulladder4bit (
    .carryin_4bit(n33_o),
    .summand1_4bit(porta),
    .summand2_4bit(portb_ones_complement),
    .carryout_4bit(fulladder4bit_carryout_4bit),
    .sum_4bit(fulladder4bit_sum_4bit));
  /* ../tt_um_ALU_t_rick.vhdl:75:35  */
  assign n33_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:82:28  */
  assign n37_o = porta & portb;
  /* ../tt_um_ALU_t_rick.vhdl:87:27  */
  assign n40_o = porta | portb;
  /* ../tt_um_ALU_t_rick.vhdl:92:28  */
  assign n43_o = porta ^ portb;
  /* ../tt_um_ALU_t_rick.vhdl:97:34  */
  assign n46_o = ~porta;
  /* ../tt_um_ALU_t_rick.vhdl:103:38  */
  assign n49_o = porta[2:0];
  /* ../tt_um_ALU_t_rick.vhdl:110:52  */
  assign n53_o = porta[3:1];
  /* ../tt_um_ALU_t_rick.vhdl:111:43  */
  assign n54_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:117:47  */
  assign n57_o = porta[3:1];
  /* ../tt_um_ALU_t_rick.vhdl:124:38  */
  assign n61_o = porta[2:0];
  /* ../tt_um_ALU_t_rick.vhdl:125:29  */
  assign n62_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:131:38  */
  assign n65_o = porta[3:1];
  /* ../tt_um_ALU_t_rick.vhdl:132:29  */
  assign n66_o = porta[0];
  /* ../tt_um_ALU_t_rick.vhdl:138:40  */
  assign n69_o = porta[2:0];
  /* ../tt_um_ALU_t_rick.vhdl:140:37  */
  assign n70_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:146:40  */
  assign n73_o = porta[3:1];
  /* ../tt_um_ALU_t_rick.vhdl:148:37  */
  assign n74_o = porta[0];
  /* ../tt_um_ALU_t_rick.vhdl:153:20  */
  assign n77_o = uio_in[4:1];
  /* ../tt_um_ALU_t_rick.vhdl:154:13  */
  assign n79_o = n77_o == 4'b0000;
  /* ../tt_um_ALU_t_rick.vhdl:157:13  */
  assign n81_o = n77_o == 4'b0001;
  /* ../tt_um_ALU_t_rick.vhdl:160:13  */
  assign n83_o = n77_o == 4'b0010;
  /* ../tt_um_ALU_t_rick.vhdl:163:13  */
  assign n85_o = n77_o == 4'b0011;
  /* ../tt_um_ALU_t_rick.vhdl:166:13  */
  assign n87_o = n77_o == 4'b0100;
  /* ../tt_um_ALU_t_rick.vhdl:169:13  */
  assign n89_o = n77_o == 4'b0101;
  /* ../tt_um_ALU_t_rick.vhdl:172:13  */
  assign n91_o = n77_o == 4'b0110;
  /* ../tt_um_ALU_t_rick.vhdl:175:13  */
  assign n93_o = n77_o == 4'b0111;
  /* ../tt_um_ALU_t_rick.vhdl:178:13  */
  assign n95_o = n77_o == 4'b1000;
  /* ../tt_um_ALU_t_rick.vhdl:181:13  */
  assign n97_o = n77_o == 4'b1001;
  /* ../tt_um_ALU_t_rick.vhdl:184:13  */
  assign n99_o = n77_o == 4'b1010;
  /* ../tt_um_ALU_t_rick.vhdl:187:13  */
  assign n101_o = n77_o == 4'b1011;
  assign n102_o = {n101_o, n99_o, n97_o, n95_o, n93_o, n91_o, n89_o, n87_o, n85_o, n83_o, n81_o, n79_o};
  /* ../tt_um_ALU_t_rick.vhdl:153:9  */
  always @*
    case (n102_o)
      12'b100000000000: n103_o = rrtcoutput;
      12'b010000000000: n103_o = rltcoutput;
      12'b001000000000: n103_o = rroutput;
      12'b000100000000: n103_o = rloutput;
      12'b000010000000: n103_o = sroutputlogic;
      12'b000001000000: n103_o = sroutputarithmetic;
      12'b000000100000: n103_o = sloutput;
      12'b000000010000: n103_o = porta_ones_complement;
      12'b000000001000: n103_o = xoroutput;
      12'b000000000100: n103_o = oroutput;
      12'b000000000010: n103_o = andoutput;
      12'b000000000001: n103_o = fulladder_sum;
      default: n103_o = fulladder_sum;
    endcase
  /* ../tt_um_ALU_t_rick.vhdl:153:9  */
  always @*
    case (n102_o)
      12'b100000000000: n113_o = carryintermediaterr;
      12'b010000000000: n113_o = carryintermediaterl;
      12'b001000000000: n113_o = 1'b0;
      12'b000100000000: n113_o = 1'b0;
      12'b000010000000: n113_o = 1'b0;
      12'b000001000000: n113_o = 1'b0;
      12'b000000100000: n113_o = 1'b0;
      12'b000000010000: n113_o = 1'b0;
      12'b000000001000: n113_o = 1'b0;
      12'b000000000100: n113_o = 1'b0;
      12'b000000000010: n113_o = 1'b0;
      12'b000000000001: n113_o = carryintermediateadd;
      default: n113_o = carryintermediateadd;
    endcase
  /* ../tt_um_ALU_t_rick.vhdl:198:36  */
  assign n116_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:198:56  */
  assign n117_o = fulladder_sum[2];
  /* ../tt_um_ALU_t_rick.vhdl:198:40  */
  assign n118_o = n116_o | n117_o;
  /* ../tt_um_ALU_t_rick.vhdl:198:76  */
  assign n119_o = fulladder_sum[1];
  /* ../tt_um_ALU_t_rick.vhdl:198:60  */
  assign n120_o = n118_o | n119_o;
  /* ../tt_um_ALU_t_rick.vhdl:198:96  */
  assign n121_o = fulladder_sum[0];
  /* ../tt_um_ALU_t_rick.vhdl:198:80  */
  assign n122_o = n120_o | n121_o;
  /* ../tt_um_ALU_t_rick.vhdl:198:18  */
  assign n123_o = ~n122_o;
  /* ../tt_um_ALU_t_rick.vhdl:199:31  */
  assign n124_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:30  */
  assign n125_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:21  */
  assign n126_o = ~n125_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:47  */
  assign n127_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:38  */
  assign n128_o = ~n127_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:34  */
  assign n129_o = n126_o & n128_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:68  */
  assign n130_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:51  */
  assign n131_o = n129_o & n130_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:82  */
  assign n132_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:95  */
  assign n133_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:86  */
  assign n134_o = n132_o & n133_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:120  */
  assign n135_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:103  */
  assign n136_o = ~n135_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:99  */
  assign n137_o = n134_o & n136_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:73  */
  assign n138_o = n131_o | n137_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:140  */
  assign n139_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:200:130  */
  assign n140_o = ~n139_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:126  */
  assign n141_o = n138_o & n140_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:160  */
  assign n142_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:151  */
  assign n143_o = ~n142_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:173  */
  assign n144_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:164  */
  assign n145_o = n143_o & n144_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:194  */
  assign n146_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:177  */
  assign n147_o = n145_o & n146_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:208  */
  assign n148_o = porta[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:225  */
  assign n149_o = portb[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:216  */
  assign n150_o = ~n149_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:212  */
  assign n151_o = n148_o & n150_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:250  */
  assign n152_o = fulladder_sum[3];
  /* ../tt_um_ALU_t_rick.vhdl:200:233  */
  assign n153_o = ~n152_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:229  */
  assign n154_o = n151_o & n153_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:199  */
  assign n155_o = n147_o | n154_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:266  */
  assign n156_o = uio_in[0];
  /* ../tt_um_ALU_t_rick.vhdl:200:256  */
  assign n157_o = n155_o & n156_o;
  /* ../tt_um_ALU_t_rick.vhdl:200:145  */
  assign n158_o = n141_o | n157_o;
  /* ../tt_um_ALU_t_rick.vhdl:206:19  */
  assign n161_o = ~rst_n;
  assign n163_o = {vflag, nflag, zflag, carryout, muxoutput};
  /* ../tt_um_ALU_t_rick.vhdl:57:9  */
  always @(posedge clk or posedge n7_o)
    if (n7_o)
      n168_q <= 4'b0000;
    else
      n168_q <= n9_o;
  /* ../tt_um_ALU_t_rick.vhdl:57:9  */
  always @(posedge clk or posedge n7_o)
    if (n7_o)
      n169_q <= 4'b0000;
    else
      n169_q <= n10_o;
  /* ../tt_um_ALU_t_rick.vhdl:54:9  */
  assign n170_o = {n31_o, n28_o, n25_o, n22_o};
  /* ../tt_um_ALU_t_rick.vhdl:54:9  */
  assign n171_o = {n49_o, 1'b0};
  assign n172_o = {n54_o, n53_o};
  assign n173_o = {1'b0, n57_o};
  assign n174_o = {n61_o, n62_o};
  assign n175_o = {n66_o, n65_o};
  assign n176_o = {n69_o, carryout};
  assign n177_o = {carryout, n73_o};
  /* ../tt_um_ALU_t_rick.vhdl:208:9  */
  always @(posedge clk or posedge n161_o)
    if (n161_o)
      n178_q <= 8'b00000000;
    else
      n178_q <= n163_o;
  /* ../tt_um_ALU_t_rick.vhdl:206:9  */
  assign n179_o = {ena, 4'b0000, n5_o};
endmodule

