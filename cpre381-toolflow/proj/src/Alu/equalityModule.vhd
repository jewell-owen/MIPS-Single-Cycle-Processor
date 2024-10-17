-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- equalityModule.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of the 
-- equality module for ALU
-------------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;

entity equalityModule is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic);

end equalityModule;

architecture dataflow of equalityModule is

begin
UNLABELED:
    o_F <= '1' when i_A = i_B else '0';

  
end dataflow;
