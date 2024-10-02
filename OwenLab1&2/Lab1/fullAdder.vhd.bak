-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- fullAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a full
-- adder
-------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is

  port(i_A           : in std_logic;
       i_B           : in std_logic;
       i_CI          : in std_logic;
       o_CO          : out std_logic;
       o_S           : out std_logic);

end fullAdder;

architecture structure of fullAdder is
-- Describe the component entities as defined in invg.vhd

component org2 is
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

component xorg2 is
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

component andg2 is
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

-- Signal to store s inverse
signal s_X1 : std_logic;
-- Signal to store 1st and gate
signal s_A1 : std_logic;
-- Signal to store 2nd and gate
signal s_A2 : std_logic;

begin

g_Xor1: xorg2
    port MAP(i_A             => i_A,
             i_B             => i_B,
             o_F            => s_X1);

g_And1: andg2
    port MAP(i_A             => i_A,
             i_B             => i_B,
             o_F            => s_A1);

g_Xor2: xorg2
    port MAP(i_A             => i_CI,
             i_B             => s_X1,
             o_F            => o_S);

g_And2: andg2
    port MAP(i_A             => i_CI,
             i_B             => s_X1,
             o_F            => s_A2);

g_Or: org2
    port MAP(i_A             => s_A1,
             i_B             => s_A2,
             o_F            => o_CO);

end structure;