-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- fullAdder_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a N Bit
-- ripple carry full adder
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_CI         : in std_logic;
       o_CO         : out std_logic;
       o_S          : out std_logic_vector(N-1 downto 0));

end fullAdder_N;

architecture structural of fullAdder_N is

  component fullAdder is
    port(i_A           : in std_logic;
         i_B           : in std_logic;
         i_CI          : in std_logic;
         o_CO          : out std_logic;
         o_S           : out std_logic);
  end component;

-- Signal for first carry to middle adders
signal s_CO : std_logic_vector(N-1 downto 0);

begin

  -- Instantiate N one bit fullAdder instances.


FirstAdder: fullAdder port map(
              i_A        =>  i_A(0),
              i_B        =>  i_B(0),
              i_CI       =>  i_CI,
              o_CO       =>  s_CO(0),     
              o_S        =>  o_S(0));

G_NBit_FULL: for i in 1 to N-1 generate
   FULLI: fullAdder port map(
              i_A        =>  i_A(i),
              i_B        =>  i_B(i),
              i_CI       =>  s_CO(i-1),
              o_CO       =>  s_CO(i),     
              o_S        =>  o_S(i));
  end generate G_NBit_FULL;

LastAdder: fullAdder port map(
              i_A        =>  i_A(N-1),
              i_B        =>  i_B(N-1),
              i_CI       =>  s_CO(N-2),
              o_CO       =>  o_CO,     
              o_S        =>  o_S(N-1));
  
end structural;