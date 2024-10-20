-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mux32t1_new.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a 32:1 mux.
--              
-- Created 9/11/24.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std_unsigned.all;
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;     

library work;
use work.array_type.all;        


entity tb_mux32t1_new is 
end tb_mux32t1_new;


architecture mixed of tb_mux32t1_new is

component mux32t1_new
	port(
		i_S : in integer range 0 to 31;
		i_D : in array_logic_vector(0 to 31)(31 downto 0);
		o_F : out std_logic_vector(31 downto 0)
	);
end component;


  signal s_S   : integer range 0 to 31;
  signal s_F   : std_logic_vector(31 downto 0) := x"00000000";
  signal s_A   : array_logic_vector(0 to 31)(31 downto 0);


begin

  DUT0: mux32t1_new
  port map(
            i_S     => s_S,
	    i_D     => s_A,
            o_F     => s_F);
 
  
  P_TEST_CASES: process
  begin
    

    FILL_MUX_INPUTS: for i in 0 to 31 loop
	s_A(i) <= to_std_logic_vector((i + 10), 32);
    end loop FILL_MUX_INPUTS;

    MUX_TEST_LOOP: for i in 0 to 31 loop

	s_S <= i;
	wait for 60 ns;
    
    end loop MUX_TEST_LOOP;
		
  end process;
end mixed;

