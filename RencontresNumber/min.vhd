library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity min is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end min;

architecture rtl of min is
component complt is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component mux4 is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
signal s : std_logic;
begin
    u1 : complt port map (a, b, s);
    u2 : mux4 port map (s, b, a, y);
end rtl;
