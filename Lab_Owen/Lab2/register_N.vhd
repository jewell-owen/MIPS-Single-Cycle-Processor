-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- registerN.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an n Bit edge-triggered
-- register with parallel access and reset.
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity register_N is
generic(N : integer := 32);
  port(i_CLK        : in std_logic;                          -- Clock input
       i_RST        : in std_logic;                          -- Reset input
       i_WE         : in std_logic;                          -- Write enable input
       i_WD         : in std_logic_vector(N-1 downto 0);     -- Write Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));    -- Data value output
end register_N;

architecture structural of register_N is

  component dffg is
    port(i_CLK        : in std_logic;
         i_RST        : in std_logic;
         i_WE         : in std_logic;
         i_D          : in std_logic;
         o_Q          : out std_logic);
  end component;

begin

  -- Instantiate N dffg instances.
  G_NBit_DFFG: for i in 0 to N-1 generate
    DFFGI : dffg port map(
	      i_CLK    => i_CLK,   
              i_RST    => i_RST,  
              i_WE     => i_WE,
	      i_D      => i_WD(i), 
              o_Q      => o_Q(i)); 
  end generate G_NBit_DFFG;
  
end structural;

