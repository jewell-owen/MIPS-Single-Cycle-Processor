-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- onesComp_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a N bit 
-- one's complementor
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity onesComp_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_I          : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end onesComp_N;

architecture structural of onesComp_N is

  component onesComp is
    port(i_I                  : in std_logic;
         o_O                  : out std_logic);
  end component;

begin

  -- Instantiate N one bit onesComp instances.
  G_NBit_ONES: for i in 0 to N-1 generate
    ONESI: onesComp port map(
              i_I       =>  i_I(i), 
              o_O       =>  o_O(i));
  end generate G_NBit_ONES;
  
end structural;