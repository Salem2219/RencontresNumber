library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity b_dp is
    port (clk, rst, i_ld, j_ld, x_ld, z_ld, sel, col_sel : in std_logic;
    n, k : in std_logic_vector(3 downto 0);
    C : in std_logic_vector(15 downto 0);
    x1, x2 : out std_logic;
    row, col : out std_logic_vector(3 downto 0);
    din : out std_logic_vector(15 downto 0));
end b_dp;

architecture rtl of b_dp is
component plus1 is
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
component compgr is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component min is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component reg16 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(15 downto 0);
reg_out: out std_logic_vector(15 downto 0));
end component;
component mux16 is
    port (s : in std_logic;
    a, b : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(15 downto 0));
end component;
component minus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component compij is
    port (
    i, j : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component adder is
    port (a, b : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(15 downto 0));
end component;
signal x3, not_x3 : std_logic;
signal iplus1, i_in, i, jplus1, j_in, j, iminus1, jminus1, minik : std_logic_vector(3 downto 0);
signal x, z, xplusz : std_logic_vector(15 downto 0);
begin
    not_x3 <= not (x3);
    i_op : plus1 port map (i, iplus1);
    i_mux : mux4 port map (sel, "0000", iplus1, i_in);
    i_reg : reg4 port map (clk, rst, i_ld, i_in, i);
    j_op : plus1 port map (j, jplus1);
    j_mux : mux4 port map (sel, "0000", jplus1, j_in);
    j_reg : reg4 port map (clk, rst, j_ld, j_in, j);
    x_reg : reg16 port map (clk, rst, x_ld, C, x);
    z_reg : reg16 port map (clk, rst, z_ld, C, z);
    row_op : minus1 port map (i, iminus1);
    row_mux : mux4 port map (j_ld, iminus1, i, row);
    col_op : minus1 port map (j, jminus1);
    col_mux : mux4 port map (col_sel, jminus1, j, col);
    din_comp : compij port map (i, j, x3);
    din_op : adder port map (x, z, xplusz) ;
    din_mux : mux16 port map (not_x3, "0000000000000001", xplusz, din);
    x1_comp : compgr port map (i, n, x1);
    x2_op : min port map (i, k, minik);
    x2_comp : compgr port map (j, minik, x2);
end rtl;
    
