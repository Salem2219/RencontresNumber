library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity r_dp is
    port (clk, rst, wr, i_ld, j_ld, sel : in std_logic;
    dp_sel : in std_logic_vector(1 downto 0);
    n, m : in std_logic_vector(3 downto 0);
    C : in std_logic_vector(15 downto 0);
    x1, x2, x3, x4, x5, x6 : out std_logic;
    row, col : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(15 downto 0));
end r_dp;

architecture rtl of r_dp is
component compgr is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component plus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component minus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component mux4 is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component reg4 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(3 downto 0);
reg_out: out std_logic_vector(3 downto 0));
end component;
component dp_matrix is
port(clk, wr : in std_logic;
sel : in std_logic_vector(1 downto 0);
i, j, n, m : in std_logic_vector(3 downto 0);
C : in std_logic_vector(15 downto 0);
dout : out std_logic_vector(15 downto 0));
end component;
component compij2 is
    port (
    i, j : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component compij3 is
    port (
    i, j : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component comp is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
signal i, i_in, iplus1, j, j_in, jplus1 :  std_logic_vector(3 downto 0);
begin
    i_op : plus1 port map (i, iplus1);
    i_mux : mux4 port map (sel, "0000", iplus1, i_in);
    i_reg : reg4 port map (clk, rst, i_ld, i_in, i);
    j_op : plus1 port map (j, jplus1);
    j_mux : mux4 port map (sel, "0000", jplus1, j_in);
    j_reg : reg4 port map (clk, rst, j_ld, j_in, j);
    dp_ram : dp_matrix port map (clk, wr,dp_sel, i, j, n, m, C, y);
    in_comp : compgr port map (i, n, x1);
    jm_comp : compgr port map (j, m, x2);
    ji_comp : compgr port map (j, i, x3);
    ji_comp2 : compij2 port map (i, j, x4);
    ji_comp3 : compij3 port map (i, j, x5);
    j_comp : comp port map ("0000", j, x6);
    row <= i;
    col <= j;
end rtl;

