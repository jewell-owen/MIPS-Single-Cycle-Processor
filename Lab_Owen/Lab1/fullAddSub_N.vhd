-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- fullAddSub_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a N Bit
-- ripple carry full adder and subtractor
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity fullAddSub_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_AddSubCI   : in std_logic;
       o_CO         : out std_logic;
       o_S          : out std_logic_vector(N-1 downto 0));

end fullAddSub_N;

architecture structural of fullAddSub_N is

  component fullAddSub is
    port(i_A           : in std_logic;
         i_B           : in std_logic;
         i_AddSubCI    : in std_logic;
         o_CO          : out std_logic;
         o_S           : out std_logic);
  end component;

-- Signal for first carry to middle adders
signal s_CO : std_logic_vector(N-1 downto 0);

begin

  -- Instantiate N one bit fullAdder instances.


FirstAddSub: fullAddSub port map(
              i_A        =>  i_A(0),
              i_B        =>  i_B(0),
              i_AddSubCI =>  i_AddSubCI,
              o_CO       =>  s_CO(0),     
              o_S        =>  o_S(0));

G_NBit_AddSub: for i in 1 to N-1 generate
   AddSubI: fullAddSub port map(
              i_A        =>  i_A(i),
              i_B        =>  i_B(i),
              i_AddSubCI =>  s_CO(i-1),
              o_CO       =>  s_CO(i),     
              o_S        =>  o_S(i));
  end generate G_NBit_AddSub;

LastAddSub: fullAddSub port map(
              i_A        =>  i_A(N-1),
              i_B        =>  i_B(N-1),
              i_AddSubCI =>  s_CO(N-2),
              o_CO       =>  o_CO,     
              o_S        =>  o_S(N-1));
  
end structural;