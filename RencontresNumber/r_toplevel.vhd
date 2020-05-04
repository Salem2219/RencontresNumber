library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity r_toplevel is
    port (clk, rst, start : in std_logic;
    n, m : in std_logic_vector(3 downto 0);
    C : in std_logic_vector(15 downto 0);
    finish : out std_logic;
    row, col : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(15 downto 0));
end r_toplevel;

architecture rtl of r_toplevel is
component r_dp is
    port (clk, rst, wr, i_ld, j_ld, sel : in std_logic;
    dp_sel : in std_logic_vector(1 downto 0);
    n, m : in std_logic_vector(3 downto 0);
    C : in std_logic_vector(15 downto 0);
    x1, x2, x3, x4, x5, x6 : out std_logic;
    row, col : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(15 downto 0));
end component;
component r_ctrl is
   port(clk,rst, start, x1, x2, x3, x4, x5, x6: in std_logic;
        wr, i_ld, j_ld, sel, finish: out std_logic;
        dp_sel: out std_logic_vector(1 downto 0));
end component;
signal wr, sel, i_ld, j_ld, x1, x2, x3, x4, x5, x6 : std_logic;
signal dp_sel : std_logic_vector(1 downto 0);
begin
    datapath : r_dp port map (clk, rst, wr, i_ld, j_ld, sel, dp_sel, n, m, C, x1, x2, x3, x4, x5, x6, row, col, y);
    control : r_ctrl port map (clk, rst, start, x1, x2, x3, x4, x5, x6, wr, i_ld, j_ld, sel, finish, dp_sel);
end rtl;