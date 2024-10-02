-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_adder1bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a 1-bit full adder.
--              
-- Created 9/4/24.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_adder1bit is
end tb_adder1bit;

architecture structure of tb_adder1bit is

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component adder1bit is
  port(i_C          : in std_logic;
       i_D0         : in std_logic;
       i_D1         : in std_logic;
       o_S          : out std_logic;
       o_C          : out std_logic);
end component;


-- TODO: change input and output signals as needed.
signal s_iC   : std_logic := '0';
signal s_iD0   : std_logic := '0';
signal s_iD1 : std_logic := '0';
signal s_oS   : std_logic;
signal s_oC   : std_logic;

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: adder1bit
  port map(
            i_C     => s_iC,
            i_D0    => s_iD0,
            i_D1    => s_iD1,
            o_S     => s_oS,
            o_C     => s_oC);
  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin

    -- Test case 1:
    s_iC    <= '0';  
    s_iD0   <= '0';
    s_iD1   <= '0';
    -- Expect: o_S equals 0 and o_C equals 0

	wait for 100 ns;

    -- Test case 2:
    s_iC    <= '0';  
    s_iD0   <= '0';
    s_iD1   <= '1';
    -- Expect: o_S equals 1 and o_C equals 0

	wait for 100 ns;

    -- Test case 3:
    s_iC    <= '0';  
    s_iD0   <= '1';
    s_iD1   <= '0';
    -- Expect: o_S equals 1 and o_C equals 0

	wait for 100 ns;

    -- Test case 4:
    s_iC    <= '0';  
    s_iD0   <= '1';
    s_iD1   <= '1';
    -- Expect: o_S equals 0 and o_C equals 1

	wait for 100 ns;

    -- Test case 5:
    s_iC    <= '1';  
    s_iD0   <= '0';
    s_iD1   <= '0';
    -- Expect: o_S equals 1 and o_C equals 0

	wait for 100 ns;

    -- Test case 6:
    s_iC    <= '1';  
    s_iD0   <= '0';
    s_iD1   <= '1';
    -- Expect: o_S equals 0 and o_C equals 1

	wait for 100 ns;

    -- Test case 7:
    s_iC    <= '1';  
    s_iD0   <= '1';
    s_iD1   <= '0';
    -- Expect: o_S equals 0 and o_C equals 1

	wait for 100 ns;

    -- Test case 8:
    s_iC    <= '1';  
    s_iD0   <= '1';
    s_iD1   <= '1';
    -- Expect: o_S equals 1 and o_C equals 1

	wait for 100 ns;



  end process;

end structure;
