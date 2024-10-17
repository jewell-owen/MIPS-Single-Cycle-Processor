-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- lessThanModule.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of the 
-- equality module for ALU
-------------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity lessThanModule is
  port(
    i_A : in std_logic_vector(31 downto 0);
    i_B : in std_logic_vector(31 downto 0);
    o_F : out std_logic_vector(31 downto 0)
  );
end lessThanModule;

architecture dataflow of lessThanModule is
  signal s_A, s_B : std_logic_vector(31 downto 0);
begin
  -- You don't need conversion to integer, just compare the vectors directly
  s_A <= i_A;
  s_B <= i_B;

  -- Perform the signed comparison
  o_F <= "00000000000000000000000000000001" when s_A < s_B else
         "00000000000000000000000000000000";
end dataflow;
