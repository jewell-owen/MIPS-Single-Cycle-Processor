-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- reg_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-bit register
-- file using edge-triggered flip-flop with parallel access and reset.
--
--
-- NOTES:
-- Created 9/11/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity reg_NPC is
  generic(N : integer := 32); 

  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value inputs
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value outputs

end reg_NPC;

architecture structure of reg_NPC is


  component dffg
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
  end component;

  component dffgPC
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
  end component;


begin


  G_NBit_Reg0: for i in 0 to 21 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_D(i),
	      o_Q       => o_Q(i));
  end generate G_NBit_Reg0;

  G_NBit_Reg1: for i in 22 to 22 generate
    REGI: dffgPC port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_D(i),
	      o_Q       => o_Q(i));
  end generate G_NBit_Reg1;

  G_NBit_Reg2: for i in 23 to N-1 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_D(i),
	      o_Q       => o_Q(i));
  end generate G_NBit_Reg2;

  
end structure;
