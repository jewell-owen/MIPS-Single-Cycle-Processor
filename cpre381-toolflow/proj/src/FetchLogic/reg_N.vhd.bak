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

entity reg_N is
  generic(N : integer := 32); 

  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value inputs
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value outputs

end reg_N;

architecture structure of reg_N is


  component dffgPC
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
  end component;

  signal s_D    : std_logic_vector(N-1 downto 0);    -- Multiplexed input to the FF
  signal s_WE    : std_logic;    -- Output of the FF

begin

  s_D <= i_D; 
  s_WE <= i_WE; 

  G_NBit_Reg: for i in 0 to N-1 generate
    REGI: dffgPC port map(
	      i_CLK     => i_CLK,
	      i_RST     => '0',
	      i_WE      => s_WE,
	      i_D       => s_D(i),
	      o_Q       => o_Q(i));
  end generate G_NBit_Reg;

  process (i_RST)
  begin
    if (i_RST = '1') then
      s_WE <= '1'; 
      s_D <= x"00400000";
    end if;

  end process;
  
end structure;
