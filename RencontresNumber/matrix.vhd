library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity matrix is
port(clk, wr : in std_logic;
row, col : in std_logic_vector(3 downto 0);
din : in std_logic_vector(15 downto 0);
dout : out std_logic_vector(15 downto 0));
end matrix;
architecture rtl of matrix is
type ram_type is array (0 to 15, 0 to 15) of
std_logic_vector(15 downto 0);
signal program: ram_type;
begin
process(clk)
begin
if (rising_edge(clk)) then
if (wr = '1') then
program(conv_integer(unsigned(row)), conv_integer(unsigned(col))) <= din;
end if;
end if;
end process;
dout <= program(conv_integer(unsigned(row)), conv_integer(unsigned(col)));
end rtl;