library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
end tb ;

architecture behav of tb is
  constant clockperiod: time:= 0.1 ns;
  signal clk: std_logic:='0';
  signal rst,start, start_r, start_b, finish_b, finish_r, wr: std_logic;
  signal n, m, row_r, row_b, col_r, col_b, row, col : std_logic_vector(3 downto 0);
  signal y, din,C : std_logic_vector (15 downto 0);
  component b_toplevel
    port (clk, rst, start : in std_logic;
    n, k : in std_logic_vector(3 downto 0);
    C : in std_logic_vector(15 downto 0);
    finish, wr : out std_logic;
    row, col : out std_logic_vector(3 downto 0);
    din : out std_logic_vector(15 downto 0));
  end component ;
  component r_toplevel
     port (clk, rst, start : in std_logic;
    n, m : in std_logic_vector(3 downto 0);
    C : in std_logic_vector(15 downto 0);
    finish : out std_logic;
    row, col : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(15 downto 0));
  end component ;
  component tb_ctrl is
  port(clk,rst, start, finish_r, finish_b: in std_logic;
        row_r, row_b, col_r, col_b : in std_logic_vector(3 downto 0);
        start_r, start_b : out std_logic;
        row, col : out std_logic_vector(3 downto 0));
end component;
component matrix is
port(clk, wr : in std_logic;
row, col : in std_logic_vector(3 downto 0);
din : in std_logic_vector(15 downto 0);
dout : out std_logic_vector(15 downto 0));
end component;
  begin
    clk <= not clk after clockperiod /2;
    rst <= '1' , '0' after 0.1 ns;
    start <= '0' , '1' after 0.1 ns, '0' after 0.5 ns;
    n <= "0111";
    m <= "0010";
    bf : b_toplevel port map(clk,rst,start_b,n,m, C, finish_b, wr, row_b, col_b, din);
    rn : r_toplevel port map(clk,rst,start_r,n,m, C, finish_r, row_r, col_r, y);
    c_ram : matrix port map (clk, wr, row, col, din, C);
    ctrl : tb_ctrl port map (clk, rst, start, finish_r, finish_b, row_r, row_b, col_r, col_b, start_r, start_b, row, col);
  end behav;