-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- carryLookaheadAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a N Bit
-- look ahead adder
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

---------------------------------------------------------------------
--Over Flow Calculation:
-- take the xor of Cn-1 and Cout to get over flow.
--   |   Cn-1 | Cout | Overflow  |
--   |  ________________________ |
--   |     0  |   0  |   0       |
--   |     0  |   1  |   1       |
--   |     1  |   0  |   1       |
--   |     1  |   1  |   0       |
---------------------------------------------------------------------

entity carryLookaheadAdder is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       i_nAddSub    : in std_logic;
       o_C          : out std_logic;
       o_O          : out std_logic;
       o_S          : out std_logic_vector(31 downto 0));

end carryLookaheadAdder;

architecture mixed of carryLookaheadAdder is

component fullAdder is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       i_CI         : in std_logic;
       o_CO         : out std_logic;
       o_S          : out std_logic);

end component;

component xorg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component mux2t1_N is
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(31 downto 0);
       i_D1         : in std_logic_vector(31 downto 0);
       o_O          : out std_logic_vector(31 downto 0));
end component;

component onesComp_N is
  port(i_I          : in std_logic_vector(31 downto 0);
       o_O          : out std_logic_vector(31 downto 0));
  end component;

--Signals
signal w_G : std_logic_vector(31 downto 0);
signal w_P : std_logic_vector(31 downto 0);
signal w_C : std_logic_vector(31 downto 0);
signal w_SUM : std_logic_vector(31 downto 0);
--Signal to carry inverted B
signal s_NOTB : std_logic_vector(31 downto 0);
--Signal for Post Mux B
signal s_PMB : std_logic_vector(31 downto 0);


begin

g_onesComp: onesComp_N
     port map(
              i_I      => i_B,      
              o_O      => s_NOTB);

m_mux2t1: mux2t1_N
     port map(
              i_S      => i_nAddSub,      
              i_D0     => i_B,  
              i_D1     => s_NOTB,  
              o_O      => s_PMB);

G_NBit_FULL: for i in 0 to 31 generate
   FULLI: fullAdder port map(
              i_A           =>  i_A(i),
              i_B           =>  s_PMB(i),
              i_CI          =>  w_C(i),
              o_CO          =>  open,     
              o_S           =>  w_SUM(i));
  end generate G_NBit_FULL;

  -- Create the Generate (G) Terms:  Gi=Ai*Bi
  -- Create the Propagate Terms: Pi=Ai+Bi
  -- Create the Carry Terms:  
  GEN_CLA : for j in 0 to 30 generate
    w_G(j)   <= i_A(j) and s_PMB(j);
    w_P(j)   <= i_A(j) or s_PMB(j);
    w_C(j+1) <= w_G(j) or (w_P(j) and w_C(j));
  end generate GEN_CLA;

  GEN_CLAEND : for j in 31 to 31 generate
    w_G(j)   <= i_A(j) and s_PMB(j);
    w_P(j)   <= i_A(j) or s_PMB(j);
    o_C      <= w_G(j) or (w_P(j) and w_C(j));
  end generate GEN_CLAEND;


g_Xor: xorg2
    port MAP(i_A             => w_C(31),
             i_B             => o_C,
             o_F             => o_O);

w_C(0) <= i_nAddSub;
o_S <= w_SUM; 

end mixed;