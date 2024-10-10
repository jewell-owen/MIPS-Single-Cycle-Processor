-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- fullAddSub_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a N Bit
-- ripple carry full adder and subtractor (try #2)
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

  component fullAdder_N is
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_CI         : in std_logic;
       o_CO         : out std_logic;
       o_S          : out std_logic_vector(N-1 downto 0));
  end component;

component mux2t1_N is
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

component onesComp_N is
  port(i_I          : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
  end component;

-- Signal for first carry to middle adders
signal s_CO : std_logic_vector(N-1 downto 0);
--Signal to carry inverted B
signal s_NOTB : std_logic_vector(N-1 downto 0);
--Signal for Post Mux B
signal s_PMB : std_logic_vector(N-1 downto 0);

begin

  -- Instantiate N one bit fullAdder instances.

g_onesComp: onesComp_N
     port map(
              i_I      => i_B,      
              o_O      => s_NOTB);

m_mux2t1: mux2t1_N
     port map(
              i_S      => i_AddSubCI,      
              i_D0     => i_B,  
              i_D1     => s_NOTB,  
              o_O      => s_PMB);


f_FullAdder: fullAdder_N
     port map(
              i_A        =>  i_A,
              i_B        =>  s_PMB,
              i_CI       =>  i_AddSubCI,
              o_CO       =>  o_CO,     
              o_S        =>  o_S);
  
end structural;
