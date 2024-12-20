-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- equalityMuxModule.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of the 
-- equality module for ALU
-------------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;

entity equalityMuxModule is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic_vector(31 downto 0));

end equalityMuxModule;

architecture dataflow of equalityMuxModule is

begin
UNLABELED:
    o_F <= "00000000000000000000000000000001" when i_A = i_B else "00000000000000000000000000000000";

  
end dataflow;
