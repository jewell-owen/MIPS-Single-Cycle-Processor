-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------
-- tb_equalityModule.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 2 to 1 mux.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_equalityModule is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_equalityModule;

architecture mixed of tb_equalityModule is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.


component equalityModule is

  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_F          : out std_logic);

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_O : std_logic;
signal s_IA : std_logic_vector(31 downto 0);
signal s_IB : std_logic_vector(31 downto 0);

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: equalityModule
  port map(
            i_A  => s_IA,
      	    i_B  => s_IB,
      	    o_F  => s_O);
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  -- This process resets the sequential components of the design.
  -- It is held to be 1 across both the negative and positive edges of the clock
  -- so it works regardless of whether the design uses synchronous (pos or neg edge)
  -- or asynchronous resets.
  P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case 1:
    s_IA   <= "00000000000000000000000000000000";  
    s_IB   <= "00000000000000000000000000000000";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 2:
    s_IA   <= "11111111111111111111111111111111";  
    s_IB   <= "11111111111111111111111111111111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 3:
    s_IA   <= "10101010101010101010101010101010";  
    s_IB   <= "10101010101010101010101010101010";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 4:
    s_IA   <= "00000000000000000000000000000000";  
    s_IB   <= "11111111111111111111111111111111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 5:
    s_IA   <= "11111111111111111111111111111111";  
    s_IB   <= "00000000000000000000000000000000";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 6:
    s_IA   <= "10101010101010101010101010101010";  
    s_IB   <= "01010101010101010101010101010101";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;
 

  end process;

end mixed;
