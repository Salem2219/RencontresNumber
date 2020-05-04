library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity r_ctrl is
  port(clk,rst, start, x1, x2, x3, x4, x5, x6: in std_logic;
        wr, i_ld, j_ld, sel, finish: out std_logic;
        dp_sel: out std_logic_vector(1 downto 0));
end r_ctrl;

architecture rtl of r_ctrl is
  type state_type is (s0,s1,s2,s3, s4, s5);
  signal current_state, next_state: state_type;
begin 
  process(x1, x2, x3, x4, x5, x6, start, current_state)
  begin
    case current_state is
	when s0 =>  
	  wr <= '0';
	  i_ld <= '0';
	  j_ld <= '0';
    sel <= '0';      
	  next_state <= s1;
	when s1 =>  
	  wr <= '0';
	  i_ld <= '1';
    j_ld <= '0';      
    sel <= '0';
	  if (start = '1') then 
	    next_state <= s2 ;
	  else
	    next_state <= s1;	
	  end if;
	when s2 => 
	  wr <= '0';
    i_ld <= '0';      
    j_ld <= '1';      
    sel <= '0';
      if (x1 = '1') then
	  next_state <= s1;
      else
      next_state <= s3;
      end if;
	when s3 =>  
	  wr <= '0';
    i_ld <= '0';      
    j_ld <= '0';      
    sel <= '0';
    if(x2 = '1') then
    next_state <= s5;
    else
    next_state <= s4;
    end if;
    when s4 =>  
	  wr <= not (x3);
    i_ld <= '0';      
    j_ld <= '1';      
    sel <= '1';
    next_state <= s3;
    when s5 =>  
	  wr <= '0';
    i_ld <= '1';      
    j_ld <= '0';      
    sel <= '1';
    next_state <= s2;
    
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
  dp_sel(1) <= x4 nor x5;     
  dp_sel(0) <= not(x4) and (x5 or not(x6));
  finish <= '1' when x1 = '1' else '0';
end rtl;