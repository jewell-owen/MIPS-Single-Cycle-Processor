
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- tb_carryLookaheadAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a test bench for structural implementation  
-- of a N bit ripple carry full adder and subtractor
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_carryLookaheadAdder is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_carryLookaheadAdder;

architecture mixed of tb_carryLookaheadAdder is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;
constant N : integer :=32;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component carryLookaheadAdder is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       i_nAddSub    : in std_logic;
       o_C          : out std_logic;
       o_O          : out std_logic;
       o_S          : out std_logic_vector(31 downto 0));
end component;
-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_IA        : std_logic_vector(N-1 downto 0);
signal s_IB        : std_logic_vector(N-1 downto 0);
signal s_IAddSubCI : std_logic;
signal s_OC        : std_logic;
signal s_OO        : std_logic;
signal s_OS        : std_logic_vector(N-1 downto 0);

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: carryLookaheadAdder
  port map(
            i_A       => s_IA,
            i_B       => s_IB,
            i_nAddSub => s_IAddSubCI,
            o_C      => s_OC,
            o_O      => s_OO,
      	    o_S       => s_OS);
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
    -- 0x00000000 + 0x00000000
    -- Expected s_OS = 0x00000000 | s_OC = 0 | s_OO = 0
    s_IA    <= "00000000000000000000000000000000";
    s_IB    <= "00000000000000000000000000000000";
    s_IAddSubCI   <= '0';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

   
    -- Test case 2:
    -- 0xFFFFFFFF + 0xFFFFFFFF
    -- Expected s_OS = 0xFFFFFFFE | s_OC = 1 | s_OO = 0
    s_IA    <= "11111111111111111111111111111111";
    s_IB    <= "11111111111111111111111111111111";
    s_IAddSubCI   <= '0';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 3
    -- 0xFFFFFFFF + 0x00000000
    -- Expected s_OS = 0xFFFFFFFF | s_OC = 0 | s_OO = 0

    s_IA    <= "11111111111111111111111111111111";
    s_IB    <= "00000000000000000000000000000000";
    s_IAddSubCI   <= '0';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

   
    -- Test case 4
    --  0x00000000 + 0xFFFFFFFF
    -- Expected s_OS = 0xFFFFFFFF | s_OC = 0 | s_OO = 0
    s_IA    <= "00000000000000000000000000000000";
    s_IB    <= "11111111111111111111111111111111";
    s_IAddSubCI   <= '0';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 5:
    --  0xAAAAAAAA + 0xAAAAAAAA
    -- Expected s_OS = 0x55555554 | s_OC = 1 | s_OO = 1
    s_IA    <= "10101010101010101010101010101010";
    s_IB    <= "10101010101010101010101010101010";
    s_IAddSubCI   <= '0';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

   
    -- Test case 6:
    --  0xAAAAAAAA + 0x55555555
    -- Expected s_OS = 0xFFFFFFFF | s_OC = 0 | s_OO = 0
    s_IA    <= "10101010101010101010101010101010";
    s_IB    <= "01010101010101010101010101010101";
    s_IAddSubCI   <= '0';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;
--------------------------------Start Subtraction cases

    -- Test case 7:
    -- 0x00000000 - 0x00000000
    -- Expected s_OS = 0x00000000 | s_OC = 0 | s_OO = 0
    s_IA    <= "00000000000000000000000000000000";
    s_IB    <= "00000000000000000000000000000000";
    s_IAddSubCI   <= '1';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

   
    -- Test case 8:
    -- 0xFFFFFFFF - 0xFFFFFFFF
    -- Expected s_OS = 0x00000000 | s_OC = 1 | s_OO = 0

    s_IA    <= "11111111111111111111111111111111";
    s_IB    <= "11111111111111111111111111111111";
    s_IAddSubCI   <= '1';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 9:
    -- 0xFFFFFFFF - 0x00000000
    -- Expected s_OS = 0xFFFFFFFF | s_OC = 1 | s_OO = 0

    s_IA    <= "11111111111111111111111111111111";
    s_IB    <= "00000000000000000000000000000000";
    s_IAddSubCI   <= '1';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

   
    -- Test case 10:
    -- 0x00000000 - 0xFFFFFFFF
    -- Expected s_OS = 0x00000001 | s_OC = 0 | s_OO = 0

    s_IA    <= "00000000000000000000000000000000";
    s_IB    <= "11111111111111111111111111111111";
    s_IAddSubCI   <= '1';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 11:
    -- 0xAAAAAAAA - 0xAAAAAAAA
    -- Expected s_OS = 0x00000000 | s_OC = 1 | s_OO = 0
    s_IA    <= "10101010101010101010101010101010";
    s_IB    <= "10101010101010101010101010101010";
    s_IAddSubCI   <= '1';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

   
    -- Test case 12:
    --  0xAAAAAAAA - 0x55555555
    -- Expected s_OS = 0x55555555 | s_OC = 1 | s_OO = 1
    s_IA    <= "10101010101010101010101010101010";
    s_IB    <= "01010101010101010101010101010101";
    s_IAddSubCI   <= '1';
    
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

  end process;

end mixed;