-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 16 to 32 bit 
-- extender with the option to sign extend or 0 extend
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity extender is
   port (i_IMM  :  in std_logic_vector(15 downto 0);     --16 bit immediate input
         i_EXTS :  in std_logic;                         --Extension select 0 = 0 extend, 1 = sign extend
         o_Q    :  out std_logic_vector(31 downto 0));    --32 output immediate
end extender;

architecture dataflow of extender is

begin
  
    process (i_IMM, i_EXTS, o_Q) is
    begin
  	if i_EXTS = '0' then

	  for i in 0 to 15 loop
              o_Q(i) <= i_IMM(i);

           end loop;

          for i in 16 to 31 loop
              o_Q(i) <= '0';

           end loop;

         else 

          for i in 0 to 15 loop
              o_Q(i) <= i_IMM(i);

           end loop;

          for i in 16 to 31 loop
              o_Q(i) <= i_IMM(15);

           end loop;


        end if;
        
          
    end process;

end dataflow;