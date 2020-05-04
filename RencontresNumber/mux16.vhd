library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity mux16 is
    port (s : in std_logic;
    a, b : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(15 downto 0));
end mux16;

architecture rtl of mux16 is
begin
    y <= a when s = '0' else b;
end rtl;