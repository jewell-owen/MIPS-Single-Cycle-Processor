-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mux8t1_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 8 to 1 mux.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_mux8t1_32 is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_mux8t1_32;

architecture mixed of tb_mux8t1_32 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component mux8t1_32 is
  port(i_S          : in std_logic_vector(2 downto 0);
       i_D0         : in std_logic_vector(31 downto 0);
       i_D1         : in std_logic_vector(31 downto 0);
       i_D2         : in std_logic_vector(31 downto 0);
       i_D3         : in std_logic_vector(31 downto 0);
       i_D4         : in std_logic_vector(31 downto 0);
       i_D5         : in std_logic_vector(31 downto 0);
       i_D6         : in std_logic_vector(31 downto 0);
       i_D7         : in std_logic_vector(31 downto 0);
       o_O          : out std_logic_vector(31 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_I0 : std_logic_vector(31 downto 0);
signal s_I1 : std_logic_vector(31 downto 0);
signal s_I2 : std_logic_vector(31 downto 0);
signal s_I3 : std_logic_vector(31 downto 0);
signal s_I4 : std_logic_vector(31 downto 0);
signal s_I5 : std_logic_vector(31 downto 0);
signal s_I6 : std_logic_vector(31 downto 0);
signal s_I7 : std_logic_vector(31 downto 0);
signal s_O  : std_logic_vector(31 downto 0);
signal s_IS : std_logic_vector(2 downto 0);

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: mux8t1_32
  port map(
            i_D0  => s_I0,
      	    i_D1  => s_I1,
            i_D2  => s_I2,
      	    i_D3  => s_I3,
            i_D4  => s_I4,
      	    i_D5  => s_I5,
            i_D6  => s_I6,
      	    i_D7  => s_I7,
      	    i_S	  => s_IS,
      	    o_O   => s_O);
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

    -- Test case 0:
    s_IS   <= "000";
    s_I0   <= "00000000000000000000000000000000";  
    s_I1   <= "00010001000100010001000100010001";
    s_I2   <= "00100010001000100010001000100010";  
    s_I3   <= "00110011001100110011001100110011";
    s_I4   <= "01000100010001000100010001000100";  
    s_I5   <= "01010101010101010101010101010101";
    s_I6   <= "01100110011001100110011001100110";  
    s_I7   <= "01110111011101110111011101110111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 1:
    s_IS   <= "001";
    s_I0   <= "00000000000000000000000000000000";  
    s_I1   <= "00010001000100010001000100010001";
    s_I2   <= "00100010001000100010001000100010";  
    s_I3   <= "00110011001100110011001100110011";
    s_I4   <= "01000100010001000100010001000100";  
    s_I5   <= "01010101010101010101010101010101";
    s_I6   <= "01100110011001100110011001100110";  
    s_I7   <= "01110111011101110111011101110111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 2:
    s_IS   <= "010";
    s_I0   <= "00000000000000000000000000000000";  
    s_I1   <= "00010001000100010001000100010001";
    s_I2   <= "00100010001000100010001000100010";  
    s_I3   <= "00110011001100110011001100110011";
    s_I4   <= "01000100010001000100010001000100";  
    s_I5   <= "01010101010101010101010101010101";
    s_I6   <= "01100110011001100110011001100110";  
    s_I7   <= "01110111011101110111011101110111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 3:
    s_IS   <= "011";
    s_I0   <= "00000000000000000000000000000000";  
    s_I1   <= "00010001000100010001000100010001";
    s_I2   <= "00100010001000100010001000100010";  
    s_I3   <= "00110011001100110011001100110011";
    s_I4   <= "01000100010001000100010001000100";  
    s_I5   <= "01010101010101010101010101010101";
    s_I6   <= "01100110011001100110011001100110";  
    s_I7   <= "01110111011101110111011101110111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 4:
    s_IS   <= "100";
    s_I0   <= "00000000000000000000000000000000";  
    s_I1   <= "00010001000100010001000100010001";
    s_I2   <= "00100010001000100010001000100010";  
    s_I3   <= "00110011001100110011001100110011";
    s_I4   <= "01000100010001000100010001000100";  
    s_I5   <= "01010101010101010101010101010101";
    s_I6   <= "01100110011001100110011001100110";  
    s_I7   <= "01110111011101110111011101110111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 5:
    s_IS   <= "101";
    s_I0   <= "00000000000000000000000000000000";  
    s_I1   <= "00010001000100010001000100010001";
    s_I2   <= "00100010001000100010001000100010";  
    s_I3   <= "00110011001100110011001100110011";
    s_I4   <= "01000100010001000100010001000100";  
    s_I5   <= "01010101010101010101010101010101";
    s_I6   <= "01100110011001100110011001100110";  
    s_I7   <= "01110111011101110111011101110111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 6:
    s_IS   <= "110";
    s_I0   <= "00000000000000000000000000000000";  
    s_I1   <= "00010001000100010001000100010001";
    s_I2   <= "00100010001000100010001000100010";  
    s_I3   <= "00110011001100110011001100110011";
    s_I4   <= "01000100010001000100010001000100";  
    s_I5   <= "01010101010101010101010101010101";
    s_I6   <= "01100110011001100110011001100110";  
    s_I7   <= "01110111011101110111011101110111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

    -- Test case 7:
    s_IS   <= "111";
    s_I0   <= "00000000000000000000000000000000";  
    s_I1   <= "00010001000100010001000100010001";
    s_I2   <= "00100010001000100010001000100010";  
    s_I3   <= "00110011001100110011001100110011";
    s_I4   <= "01000100010001000100010001000100";  
    s_I5   <= "01010101010101010101010101010101";
    s_I6   <= "01100110011001100110011001100110";  
    s_I7   <= "01110111011101110111011101110111";
   
    wait for gCLK_HPER*2;
    wait for gCLK_HPER*2;

  

  end process;

end mixed;
