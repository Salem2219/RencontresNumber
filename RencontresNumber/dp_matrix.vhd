library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dp_matrix is
port(clk, wr : in std_logic;
sel : in std_logic_vector(1 downto 0);
i, j, n, m : in std_logic_vector(3 downto 0);
C : in std_logic_vector(15 downto 0);
dout : out std_logic_vector(15 downto 0));
end dp_matrix;
architecture rtl of dp_matrix is

type ram_type is array (0 to 15, 0 to 15) of
std_logic_vector(15 downto 0);
signal program: ram_type := (others => (others => (others => '0')));
component minus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component adder is
    port (a, b : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(15 downto 0));
end component;
component multi16 is
    port (a, b : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(31 downto 0));
end component;
component minus2 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component sub4 is
    port (a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component mux4_1 is
    port (sel : in std_logic_vector(1 downto 0);
    a, b, c, d : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(15 downto 0));
end component;
signal iminus1, iminus2, iminusj : std_logic_vector(3 downto 0);
signal dp1, dp2, dp3, dp4, dp1plusdp2,  im : std_logic_vector(15 downto 0);
signal dpi : std_logic_vector(31 downto 0);
signal Cplusdp :std_logic_vector(31 downto 0);
begin
dp1 <= program(conv_integer(unsigned(iminus1)), 0);
dp2 <= program(conv_integer(unsigned(iminus2)), 0);
dp3 <= program(conv_integer(unsigned(iminusj)), 0);
im <= "000000000000" & iminus1;
u1 : minus1 port map (i, iminus1);
u2 : minus2 port map (i, iminus2);
u3 : sub4 port map (i, j, iminusj);
u4 : adder port map (dp1, dp2, dp1plusdp2);
u6 : multi16 port map (dp3, C, Cplusdp);
u5 : multi16 port map (im, dp1plusdp2, dpi);
u7 : mux4_1 port map (sel, "0000000000000001", "0000000000000000", dpi(15 downto 0), Cplusdp(15 downto 0), dp4);
process(clk)
begin
if (rising_edge(clk)) then
if (wr = '1') then
program(conv_integer(unsigned(i)), conv_integer(unsigned(j))) <= dp4;
end if;
end if;
end process;
dout <= program(conv_integer(unsigned(n)), conv_integer(unsigned(m)));
end rtl;