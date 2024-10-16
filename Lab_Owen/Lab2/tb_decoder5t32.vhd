-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_decoder5t32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- edge-triggered flip-flop register with parallel access and reset.
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_decoder5t32 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_decoder5t32;

architecture behavior of tb_decoder5t32 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component decoder5t32
    port(i_WA         : in std_logic_vector(4 downto 0);      -- Write Address input
         i_WE         : in std_logic;                          --Write Enable
         o_Q          : out std_logic_vector(31 downto 0));   -- Output

  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK  : std_logic;
  signal s_WE  : std_logic;
  signal s_WA : std_logic_vector(4 downto 0);
  signal s_Q : std_logic_vector(31 downto 0);

begin

  DUT: decoder5t32 
  port map(i_WA  => s_WA, 
           i_WE  => s_WE,
           o_Q   => s_Q);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
    -- Case 0
    s_WA <= "00000";
    s_WE <= '1';
    wait for cCLK_PER;

    -- Case 1
    s_WA <= "00001";
    s_WE <= '1';
    wait for cCLK_PER;

    -- Case 2
    s_WA <= "00010";
    s_WE <= '1';
    wait for cCLK_PER;

    -- Case 3
    s_WA <= "00011";
    s_WE <= '1';
    wait for cCLK_PER;

    -- Case 28
    s_WA <= "11100";
    s_WE <= '1';
    wait for cCLK_PER;

    -- Case 29
    s_WA <= "11101";
    s_WE <= '1';
    wait for cCLK_PER;

    -- Case 30
    s_WA <= "11110";
    s_WE <= '1';
    wait for cCLK_PER;

    -- Case 31
    s_WA <= "11111";
    s_WE <= '1';
    wait for cCLK_PER;

    -- Case 0 Not enabled
    s_WA <= "00000";
    s_WE <= '0';
    wait for cCLK_PER;

    -- Case 1 Not enabled
    s_WA <= "00001";
    s_WE <= '0';
    wait for cCLK_PER;

    -- Case 2 Not enabled
    s_WA <= "00010";
    s_WE <= '0';
    wait for cCLK_PER;

    -- Case 3 Not enabled
    s_WA <= "00011";
    s_WE <= '0';
    wait for cCLK_PER;

    -- Case 28 Not enabled
    s_WA <= "11100";
    s_WE <= '0';
    wait for cCLK_PER;

    -- Case 29 Not enabled
    s_WA <= "11101";
    s_WE <= '0';
    wait for cCLK_PER;

    -- Case 30 Not enabled
    s_WA <= "11110";
    s_WE <= '0';
    wait for cCLK_PER;

    -- Case 31 Not enabled
    s_WA <= "11111";
    s_WE <= '0';
    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;