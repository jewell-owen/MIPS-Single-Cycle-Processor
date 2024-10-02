-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- deextender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32 bit to10  bit 
-- deextender
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity deextender is
   port (i_I    :  in std_logic_vector(31 downto 0);     --32 bit input
         o_Q    :  out std_logic_vector(9 downto 0));    --10 bit output 
end deextender;

architecture dataflow of deextender is

begin
  
    process (i_I, o_Q) is
    begin
  	
	  for i in 0 to 9 loop
              o_Q(i) <= i_I(i);

           end loop;
        
    end process;

end dataflow;