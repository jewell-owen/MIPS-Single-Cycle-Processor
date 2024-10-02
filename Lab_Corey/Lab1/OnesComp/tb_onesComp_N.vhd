-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mux2t1_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a N-bit One's Complementor.
--              
-- Created 9/3/24.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_onesComp_N is
end tb_onesComp_N;

architecture structure of tb_onesComp_N is

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component onesComp_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A         : in std_logic_vector(N-1 downto 0);
       o_F         : out std_logic_vector(N-1 downto 0));
end component;


-- TODO: change input and output signals as needed.
signal s_iA   : std_logic_vector(32-1 downto 0) := x"00000000";
signal s_oF   : std_logic_vector(32-1 downto 0);

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: onesComp_N
  port map(
	    --N => s_N,
            i_A     => s_iA,
            o_F     => s_oF);
  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    --wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case 1: 
    s_iA   <= x"0000FFFF";

    wait for 100 ns;
    
    -- Expect: o_F equals 0xFFFF0000

    -- Test case 2:    
    s_iA   <= x"01234567";

    wait for 100 ns;

    -- Expect: o_F equals 0xFEDCBA98

    -- Test case 3: 
    s_iA   <= x"78785A5A";

    wait for 100 ns;
    
    -- Expect: o_F equals 0x8787A5A5

    -- Test case 4:   
    s_iA   <= x"00114466";

    wait for 100 ns;

    -- Expect: o_F equals 0xFFEEBB99



  end process;

end structure;
