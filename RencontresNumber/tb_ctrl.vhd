library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb_ctrl is
  port(clk,rst, start, finish_r, finish_b: in std_logic;
        row_r, row_b, col_r, col_b : in std_logic_vector(3 downto 0);
        start_r, start_b : out std_logic;
        row, col : out std_logic_vector(3 downto 0));
end tb_ctrl;

architecture rtl of tb_ctrl is
  type state_type is (s0,s1,s2,s3);
  signal current_state, next_state: state_type;
begin 
  process(finish_r, finish_b, row_b, row_r, col_b, col_r, start, current_state)
  begin
    case current_state is
	when s0 =>  
      start_b <= '0'; 
      start_r <= '0'; 
	  row <= "0000";
	  col <= "0000";
	  next_state <= s1;
	when s1 =>  
      start_b <= '0'; 
      start_r <= '0'; 
	  row <= "0000";
	  col <= "0000";
	  if (start = '1') then 
	    next_state <= s2 ;
	  else
	    next_state <= s1;	
	  end if;
	when s2 => 
      start_b <= '1'; 
      start_r <= '0'; 
	  row <= row_b;
	  col <= col_b;
      if (finish_b = '1') then
	  next_state <= s3;
      else
      next_state <= s2;
      end if;
	when s3 =>  
      start_b <= '0'; 
      start_r <= '1'; 
	  row <= row_r;
	  col <= col_r;
      if (finish_r = '1') then
	  next_state <= s1;
      else
      next_state <= s3;
      end if;
    
	end case;
  end process;
  process (rst, clk)
  begin
    if (rst ='1') then
      current_state <= s0;
    elsif (rising_edge(clk)) then
      current_state <= next_state;
    end if;
  end process;
end rtl;