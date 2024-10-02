-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2:1
-- mux using structural VHDL.
--
--
-- NOTES:
-- Created 9/3/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is

  port(i_S          : in std_logic;
       i_D0         : in std_logic;
       i_D1         : in std_logic;
       o_O          : out std_logic);

end mux2t1;


architecture structure of mux2t1 is
  
  -- NOT gate
  component invg
    port(i_A          : in std_logic;
         o_F          : out std_logic);
  end component;

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


  -- Signal to carry i_S after NOT gate
  signal s_SN         : std_logic;
  -- Signal to carry result of i_SN and i_D0 after AND gate
  signal s_SND0       : std_logic;
  -- Signal to carry result of i_S and i_D1 after AND gate
  signal s_SD1        : std_logic;

begin

  g_NOT: invg port map (i_A => i_S,
		  o_F => s_SN);

  g_ADD: andg2 port map (i_A => s_SN,
		  i_B => i_D0,
		  o_F => s_SND0);

  g_ADD2: andg2 port map (i_A => i_S,
		  i_B => i_D1,
		  o_F => s_SD1);

  g_OR: org2 port map (i_A => s_SND0,
		  i_B => s_SD1,
		  o_F => o_O);

  end structure;
