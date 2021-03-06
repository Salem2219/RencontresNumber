library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity compij3 is
    port (
    i, j : in std_logic_vector(3 downto 0);
    y : out std_logic);
end compij3;

architecture rtl of compij3 is
component comp is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;

signal x1, x2 : std_logic;
begin
    u1 : comp port map (i, "0001", x1);
    u2 : comp port map (j, "0000", x2);
    y <= x1 and x2;
end rtl;
