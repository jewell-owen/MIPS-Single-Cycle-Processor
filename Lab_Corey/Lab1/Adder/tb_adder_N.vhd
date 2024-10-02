-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_adder_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a N-bit ripple-carry full adder.
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
entity tb_adder_N is
end tb_adder_N;

architecture structure of tb_adder_N is

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component adder_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width.
  port(i_C          : in std_logic;
       i_A         : in std_logic_vector(N-1 downto 0);
       i_B         : in std_logic_vector(N-1 downto 0);
       o_S          : out std_logic_vector(N-1 downto 0);
       o_C          : out std_logic);
end component;


-- TODO: change input and output signals as needed.
signal s_iC   : std_logic := '0';
signal s_iA   : std_logic_vector(32-1 downto 0) := x"00000000";
signal s_iB   : std_logic_vector(32-1 downto 0) := x"00000000";
signal s_oS   : std_logic_vector(32-1 downto 0);
signal s_oC   : std_logic;

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: adder_N
  port map(
            i_C     => s_iC,
            i_A     => s_iA,
            i_B     => s_iB,
            o_S     => s_oS,
            o_C     => s_oC);
  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin

    -- Test case 1:
    s_iC    <= '0';  
    s_iA    <= x"00000001";
    s_iB    <= x"00000001";
    -- Expect: o_S equals 2 and o_C equals 0

	wait for 100 ns;

    -- Test case 2:
    s_iC    <= '1';  
    s_iA    <= x"12525251";
    s_iB    <= x"00886688";
    -- Expect: o_S equals 316324058 and o_C equals 0

	wait for 100 ns;

    -- Test case 3:
    s_iC    <= '0';  
    s_iA    <= x"FFFFFFFF";
    s_iB    <= x"00000010";
    -- Expect: o_S equals 15 and o_C equals 1

	wait for 100 ns;

    -- Test case 4:
    s_iC    <= '1';  
    s_iA    <= x"FFFFFFFF";
    s_iB    <= x"FFFFFFFF";
    -- Expect: o_S equals 4294967295 and o_C equals 1

	wait for 150 ns;



  end process;

end structure;
 