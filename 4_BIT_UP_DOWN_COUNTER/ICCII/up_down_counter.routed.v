// IC Compiler II Version W-2024.09 Verilog Writer
// Generated on 6/1/2025 at 5:24:48
// Library Name: UP_DOWN_COUNTER_LIBDH
// Block Name: up_down_counter
// User Label: 
// Write Command: write_verilog ./results/up_down_counter.routed.v
module up_down_counter ( clk , reset , up_down , count ) ;
input  clk ;
input  reset ;
input  up_down ;
output [3:0] count ;

DFFARX1_RVT \count_reg[0] ( .D ( ropt_net_0 ) , .CLK ( clk ) , 
    .RSTB ( HFSNET_1 ) , .Q ( count[0] ) , .QN ( n40 ) ) ;
DFFARX1_RVT \count_reg[1] ( .D ( N14 ) , .CLK ( clk ) , .RSTB ( HFSNET_1 ) , 
    .Q ( count[1] ) ) ;
DFFARX1_RVT \count_reg[2] ( .D ( N15 ) , .CLK ( clk ) , .RSTB ( HFSNET_1 ) , 
    .Q ( count[2] ) ) ;
DFFARX1_RVT \count_reg[3] ( .D ( N16 ) , .CLK ( clk ) , .RSTB ( HFSNET_1 ) , 
    .Q ( count[3] ) ) ;
IBUFFX2_RVT HFSINV_113_561 ( .A ( reset ) , .Y ( HFSNET_1 ) ) ;
DELLN1X2_RVT ropt_h_inst_1122 ( .A ( n40 ) , .Y ( ropt_net_0 ) ) ;
OR3X1_RVT U29 ( .A1 ( count[1] ) , .A2 ( count[0] ) , .A3 ( up_down ) , 
    .Y ( n34 ) ) ;
NAND3X0_RVT U33 ( .A1 ( count[1] ) , .A2 ( count[0] ) , .A3 ( up_down ) , 
    .Y ( n25 ) ) ;
NAND2X0_RVT U34 ( .A1 ( n34 ) , .A2 ( n25 ) , .Y ( n26 ) ) ;
OR2X1_RVT U35 ( .A1 ( n26 ) , .A2 ( count[2] ) , .Y ( n28 ) ) ;
NAND2X0_RVT U36 ( .A1 ( count[2] ) , .A2 ( n26 ) , .Y ( n27 ) ) ;
AND2X1_RVT U37 ( .A1 ( n28 ) , .A2 ( n27 ) , .Y ( N15 ) ) ;
OR2X1_RVT U38 ( .A1 ( count[0] ) , .A2 ( up_down ) , .Y ( n30 ) ) ;
NAND2X0_RVT U39 ( .A1 ( count[0] ) , .A2 ( up_down ) , .Y ( n29 ) ) ;
NAND2X0_RVT U40 ( .A1 ( n30 ) , .A2 ( n29 ) , .Y ( n31 ) ) ;
OR2X1_RVT U41 ( .A1 ( n31 ) , .A2 ( count[1] ) , .Y ( n33 ) ) ;
NAND2X0_RVT U42 ( .A1 ( count[1] ) , .A2 ( n31 ) , .Y ( n32 ) ) ;
AND2X1_RVT U43 ( .A1 ( n33 ) , .A2 ( n32 ) , .Y ( N14 ) ) ;
OR2X1_RVT U44 ( .A1 ( count[2] ) , .A2 ( n34 ) , .Y ( n36 ) ) ;
NAND4X1_RVT U45 ( .A1 ( count[1] ) , .A2 ( count[0] ) , .A3 ( up_down ) , 
    .A4 ( count[2] ) , .Y ( n35 ) ) ;
NAND2X0_RVT U46 ( .A1 ( n36 ) , .A2 ( n35 ) , .Y ( n37 ) ) ;
OR2X1_RVT U47 ( .A1 ( n37 ) , .A2 ( count[3] ) , .Y ( n39 ) ) ;
NAND2X0_RVT U48 ( .A1 ( count[3] ) , .A2 ( n37 ) , .Y ( n38 ) ) ;
AND2X1_RVT U49 ( .A1 ( n39 ) , .A2 ( n38 ) , .Y ( N16 ) ) ;
endmodule


