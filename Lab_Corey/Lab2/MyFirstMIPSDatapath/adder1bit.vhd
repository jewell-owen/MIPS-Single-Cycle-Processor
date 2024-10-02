-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 1 bit
-- adder using structural VHDL.
--
--
-- NOTES:
-- Created 9/4/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adder1bit is

  port(i_C          : in std_logic;
       i_D0         : in std_logic;
       i_D1         : in std_logic;
       o_S          : out std_logic;
       o_C          : out std_logic);

end adder1bit;


architecture structure of adder1bit is

  -- AND gate
  component andg2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

  -- OR gate
  component org2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

  -- XOR gate
  component xorg2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;


  -- Signal to carry result of i_D1 and i_D0 after XOR gate
  signal s_D0D1XOR       : std_logic;
  -- Signal to carry result of i_D1 and i_D0 after AND gate
  signal s_D0D1AND      : std_logic;
  -- Signal to carry result of s_D0D1AND and i_C after AND gate
  signal s_D0D1XORCAND        : std_logic;

begin

  g_XOR: xorg2 port map (i_A => i_D0,
		  i_B => i_D1,
		  o_F => s_D0D1XOR);

  g_ADD: andg2 port map (i_A => i_D0,
		  i_B => i_D1,
		  o_F => s_D0D1AND);

  g_ADD2: andg2 port map (i_A => s_D0D1XOR,
		  i_B => i_C,
		  o_F => s_D0D1XORCAND);

  g_OR: org2 port map (i_A => s_D0D1XORCAND,
		  i_B => s_D0D1AND,
		  o_F => o_C);

  g_XOR2: xorg2 port map (i_A => s_D0D1XOR,
		  i_B => i_C,
		  o_F => o_S);

  end structure;
