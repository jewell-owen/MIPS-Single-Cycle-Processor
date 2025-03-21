------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- vectorReverser_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the implementation of an N bit order reverser
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity vectorReverser_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
   port(i_D                : in std_logic_vector(N-1 downto 0);          -- 32 bit data input
        o_O                : out std_logic_vector(N-1 downto 0));        -- 32 bit data output

end vectorReverser_N;

architecture dataflow of vectorReverser_N is



begin

process (i_D) is
    begin
 
	  for i in 0 to N-1 loop
              o_O(i) <= i_D((N-1)-i);

           end loop;

   
    end process;

  
end dataflow;