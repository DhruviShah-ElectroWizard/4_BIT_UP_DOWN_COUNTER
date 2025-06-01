/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09
// Date      : Sun Jun  1 05:14:17 2025
/////////////////////////////////////////////////////////////


module up_down_counter ( clk, reset, up_down, count );
  output [3:0] count;
  input clk, reset, up_down;
  wire   N14, N15, N16, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40;

  DFFARX1_RVT \count_reg[0]  ( .D(n40), .CLK(clk), .RSTB(n19), .Q(count[0]), 
        .QN(n40) );
  DFFARX1_RVT \count_reg[1]  ( .D(N14), .CLK(clk), .RSTB(n24), .Q(count[1]) );
  DFFARX1_RVT \count_reg[2]  ( .D(N15), .CLK(clk), .RSTB(n24), .Q(count[2]) );
  DFFARX1_RVT \count_reg[3]  ( .D(N16), .CLK(clk), .RSTB(n24), .Q(count[3]) );
  INVX0_RVT U26 ( .A(up_down), .Y(n20) );
  INVX0_RVT U27 ( .A(n20), .Y(n21) );
  INVX0_RVT U28 ( .A(n20), .Y(n22) );
  OR3X1_RVT U29 ( .A1(count[1]), .A2(count[0]), .A3(n21), .Y(n34) );
  INVX0_RVT U30 ( .A(n19), .Y(n23) );
  INVX0_RVT U31 ( .A(n23), .Y(n24) );
  INVX0_RVT U32 ( .A(reset), .Y(n19) );
  NAND3X0_RVT U33 ( .A1(count[1]), .A2(count[0]), .A3(n22), .Y(n25) );
  NAND2X0_RVT U34 ( .A1(n34), .A2(n25), .Y(n26) );
  OR2X1_RVT U35 ( .A1(n26), .A2(count[2]), .Y(n28) );
  NAND2X0_RVT U36 ( .A1(count[2]), .A2(n26), .Y(n27) );
  AND2X1_RVT U37 ( .A1(n28), .A2(n27), .Y(N15) );
  OR2X1_RVT U38 ( .A1(count[0]), .A2(n22), .Y(n30) );
  NAND2X0_RVT U39 ( .A1(count[0]), .A2(n22), .Y(n29) );
  NAND2X0_RVT U40 ( .A1(n30), .A2(n29), .Y(n31) );
  OR2X1_RVT U41 ( .A1(n31), .A2(count[1]), .Y(n33) );
  NAND2X0_RVT U42 ( .A1(count[1]), .A2(n31), .Y(n32) );
  AND2X1_RVT U43 ( .A1(n33), .A2(n32), .Y(N14) );
  OR2X1_RVT U44 ( .A1(count[2]), .A2(n34), .Y(n36) );
  NAND4X0_RVT U45 ( .A1(count[1]), .A2(count[0]), .A3(n22), .A4(count[2]), .Y(
        n35) );
  NAND2X0_RVT U46 ( .A1(n36), .A2(n35), .Y(n37) );
  OR2X1_RVT U47 ( .A1(n37), .A2(count[3]), .Y(n39) );
  NAND2X0_RVT U48 ( .A1(count[3]), .A2(n37), .Y(n38) );
  AND2X1_RVT U49 ( .A1(n39), .A2(n38), .Y(N16) );
endmodule

