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
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;             


entity tb_addSub_N is
end tb_addSub_N;

architecture structure of tb_addSub_N is


component addSub_N is
  generic(N : integer := 32); 
  port(i_nAdd_Sub     : in std_logic;
       i_ALUSrc       : in std_logic;
       i_immed        : in std_logic_vector(N-1 downto 0);
       i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Car          : out std_logic);
end component;


signal s_nAdd_Sub   : std_logic := '0';
signal s_ALUSrc     : std_logic := '0';
signal s_immed      : std_logic_vector(32-1 downto 0) := x"00000000";
signal s_iDA        : std_logic_vector(32-1 downto 0) := x"00000000";
signal s_iDB        : std_logic_vector(32-1 downto 0) := x"00000000";
signal s_oSum       : std_logic_vector(32-1 downto 0);
signal s_oCar       : std_logic;

begin

  DUT0: addSub_N
  port map(
            i_nAdd_Sub     => s_nAdd_Sub,
	    i_ALUSrc       => s_ALUSrc,
	    i_immed        => s_immed,
            i_DA           => s_iDA,
            i_DB           => s_iDB,
            o_Sum          => s_oSum,
            o_Car          => s_oCar);
  
  
  P_TEST_CASES: process
  begin

   
    s_nAdd_Sub    <= '0';  
    s_ALUSrc    <= '0';
    s_immed    <= x"00000000";
    s_iDA    <= x"00000001";
    s_iDB    <= x"00000001";
    -- Expect: o_Sum equals 2 and o_Car equals 0

	wait for 100 ns;

    
    s_nAdd_Sub    <= '0';  
    s_iDA    <= x"12525251";
    s_iDB    <= x"00886688";
    -- Expect: o_Sum equals 316324057 and o_Car equals 0

	wait for 100 ns;

    
    s_nAdd_Sub    <= '0';  
    s_iDA    <= x"FFFFFFFF";
    s_iDB    <= x"00000010";
    -- Expect: o_Sum equals 15 and o_Car equals 1

	wait for 100 ns;

    
    s_nAdd_Sub    <= '0';  
    s_iDA    <= x"FFFFFFFF";
    s_iDB    <= x"FFFFFFFF";
    -- Expect: o_Sum equals 4294967294 and o_Car equals 1

	wait for 100 ns;



    
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"00000001";
    s_iDB    <= x"00000001";
    -- Expect: o_Sum equals 0 and o_Car equals 1

	wait for 100 ns;

    
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"12525251";
    s_iDB    <= x"00886688";
    -- Expect: o_Sum equals 298445769 and o_Car equals 1

	wait for 100 ns;

    
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"00886688";
    s_iDB    <= x"12525251";
    -- Expect: o_Sum equals -298445769 and o_Car equals 0

	wait for 100 ns;

   
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"FFFFFFFF";
    s_iDB    <= x"00000010";
    -- Expect: o_Sum equals 4294967279 and o_Car equals 1

	wait for 100 ns;

   
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"FFFFFFFF";
    s_iDB    <= x"FFFFFFFF";
    -- Expect: o_Sum equals 0 and o_Car equals 1

	wait for 100 ns;

   
    s_nAdd_Sub    <= '1';  
    s_iDA    <= x"00000000";
    s_iDB    <= x"00000000";
    -- Expect: o_Sum equals 0 and o_Car equals 0

	wait for 100 ns;


    s_nAdd_Sub    <= '0';  
    s_ALUSrc    <= '1';
    s_immed    <= x"00000002";
    s_iDA    <= x"0000000D";
    s_iDB    <= x"00000008";
    -- Expect: o_Sum equals F and o_Car equals 0

	wait for 100 ns;

    s_nAdd_Sub    <= '1';  
    s_ALUSrc    <= '1';
    s_immed    <= x"00000008";
    s_iDA    <= x"0000000F";
    s_iDB    <= x"0000000D";
    -- Expect: o_Sum equals 8 and o_Car equals 1

	wait for 100 ns;





  end process;

end structure;
