library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity multi16 is
    port (a, b : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(31 downto 0));
end multi16;

architecture rtl of multi16 is
signal y_uns : unsigned(31 downto 0);
begin
y_uns <= unsigned(a) * unsigned(b);
y <= std_logic_vector(y_uns);
end rtl;
