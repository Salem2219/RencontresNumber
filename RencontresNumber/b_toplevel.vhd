library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity b_toplevel is
    port (clk, rst, start : in std_logic;
    n, k : in std_logic_vector(3 downto 0);
    C : in std_logic_vector(15 downto 0);
    finish, wr : out std_logic;
    row, col : out std_logic_vector(3 downto 0);
    din : out std_logic_vector(15 downto 0));
end b_toplevel;

architecture rtl of b_toplevel is
    component b_dp is
    port (clk, rst, i_ld, j_ld, x_ld, z_ld, sel, col_sel : in std_logic;
    n, k : in std_logic_vector(3 downto 0);
    C : in std_logic_vector(15 downto 0);
    x1, x2 : out std_logic;
    row, col : out std_logic_vector(3 downto 0);
    din : out std_logic_vector(15 downto 0));
end component;
component b_ctrl is
  port(clk,rst, start, x1, x2: in std_logic;
        wr, i_ld, j_ld, x_ld, z_ld, sel, col_sel, finish: out std_logic);
end component;
signal x1, x2, i_ld, j_ld, x_ld, z_ld, sel, col_sel : std_logic;
begin
    datapath : b_dp port map (clk, rst, i_ld, j_ld, x_ld, z_ld, sel, col_sel, n, k, C, x1, x2, row, col, din);
    control : b_ctrl port map (clk,rst, start, x1, x2, wr, i_ld, j_ld, x_ld, z_ld, sel, col_sel, finish);
end rtl;