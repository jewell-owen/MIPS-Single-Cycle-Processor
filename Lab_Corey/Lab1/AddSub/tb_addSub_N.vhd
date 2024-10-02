-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_addSub_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a N-bit adder/subtractor.
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
entity tb_addSub_N is
end tb_addSub_N;

architecture structure of tb_addSub_N is

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component addSub_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width.
  port(i_nAdd_Sub     : in std_logic;
       i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Car          : out std_logic);
end component;


-- TODO: change input and output signals as needed.
signal s_nAdd_Sub   : std_logic := '0';
signal s_iDA   : std_logic_vector(32-1 downto 0) := x"00000000";
signal s_iDB   : std_logic_vector(32-1 downto 0) := x"00000000";
signal s_oSum   : std_logic_vector(32-1 downto 0);
signal s_oCar   : std_logic;

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: addSub_N
  port map(
            i_nAdd_Sub     => s_nAdd_Sub,
            i_DA      => s_iDA,
            i_DB      => s_iDB,
            o_Sum     => s_oSum,
            o_Car     => s_oCar);
  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin

    -- Test case 1:
    s_nAdd_Sub    <= '0';  
    s_iDA    <= x"00000001";
    s_iDB    <= x"00000001";
    -- Expect: o_Sum equals 2 and o_Car equals 0

	wait for 100 ns;

    -- Test case 2:
    s_nAdd_Sub    <= '0';  
    s_iDA    <= x"12525251";
    s_iDB    <= x"00886688";
    -- Expect: o_Sum equals 316324057 and o_Car equals 0

	wait for 100 ns;

    -- Test case 3:
    s_nAdd_Sub    <= '0';  
    s_iDA    <= x"FFFFFFFF";
    s_iDB    <= x"00000010";
    -- Expect: o_Sum equals 15 and o_Car equals 1

	wait for 100 ns;

    -- Test case 4:
    s_nAdd_Sub    <= '0';  
    s_iDA    <= x"FFFFFFFF";
    s_iDB    <= x"FFFFFFFF";
    -- Expect: o_Sum equals 4294967294 and o_Car equals 1

	wait for 100 ns;



    -- Test case 5:
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"00000001";
    s_iDB    <= x"00000001";
    -- Expect: o_Sum equals 0 and o_Car equals 1

	wait for 100 ns;

    -- Test case 6:
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"12525251";
    s_iDB    <= x"00886688";
    -- Expect: o_Sum equals 298445769 and o_Car equals 1

	wait for 100 ns;

    -- Test case 7:
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"00886688";
    s_iDB    <= x"12525251";
    -- Expect: o_Sum equals -298445769 and o_Car equals 0

	wait for 100 ns;

    -- Test case 8:
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"FFFFFFFF";
    s_iDB    <= x"00000010";
    -- Expect: o_Sum equals 4294967279 and o_Car equals 1

	wait for 100 ns;

    -- Test case 9:
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"FFFFFFFF";
    s_iDB    <= x"FFFFFFFF";
    -- Expect: o_Sum equals 0 and o_Car equals 1

	wait for 100 ns;

    -- Test case 10:
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"00000000";
    s_iDB    <= x"00000000";
    -- Expect: o_Sum equals 0 and o_Car equals 0

	wait for 100 ns;



  end process;

end structure;
