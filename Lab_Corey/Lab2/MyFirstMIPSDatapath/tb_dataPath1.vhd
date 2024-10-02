-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_dataPath1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a datapath.
--              
-- Created 9/22/24.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std_unsigned.all;
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;     

library work;
use work.array_type.all;        


entity tb_dataPath1 is 
  generic(gCLK_HPER   : time := 10 ns);
end tb_dataPath1;


architecture mixed of tb_dataPath1 is

constant cCLK_PER  : time := gCLK_HPER * 2;


component dataPath1

  generic(N : integer := 32); 
  port(i_CLK        : in std_logic;    
       i_RST        : in std_logic;    
       i_regWrite   : in std_logic;     
       i_rs_sel     : in std_logic_vector(4 downto 0);
       i_rt_sel     : in std_logic_vector(4 downto 0);
       i_rd_sel     : in std_logic_vector(4 downto 0);
       --i_rd_D	    : in std_logic_vector(31 downto 0);
       --o_rs_D       : out std_logic_vector(31 downto 0); 
       --o_rt_D	    : out std_logic_vector(31 downto 0);

       i_nAdd_Sub     : in std_logic;
       i_ALUSrc       : in std_logic;
       i_immed        : in std_logic_vector(N-1 downto 0);
       --i_DA           : in std_logic_vector(N-1 downto 0);
       --i_DB           : in std_logic_vector(N-1 downto 0);
       --o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Car          : out std_logic
  	);
end component;

  signal CLK, reset, regWrite   : std_logic := '0';
  signal s_rs_sel     : std_logic_vector(4 downto 0);
  signal s_rt_sel     : std_logic_vector(4 downto 0);
  signal s_rd_sel     : std_logic_vector(4 downto 0);

  signal s_nAdd_Sub   : std_logic := '0';
  signal s_ALUSrc     : std_logic := '0';
  signal s_immed      : std_logic_vector(32-1 downto 0) := x"00000000";
  signal s_oCar       : std_logic;


begin

  DUT0: dataPath1
  port map(
		i_CLK       => CLK,
       		i_RST       => reset,
		i_regWrite  => regWrite,
       		i_rs_sel    => s_rs_sel,
       		i_rt_sel    => s_rt_sel,
       		i_rd_sel    => s_rd_sel,
		i_nAdd_Sub     => s_nAdd_Sub,
	    	i_ALUSrc       => s_ALUSrc,
	    	i_immed        => s_immed,
            	o_Car          => s_oCar
		);


  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;  
 
  
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2;
    
    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "00001";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000001";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "00010";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000002";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "00011";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000003";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "00100";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000004";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "00101";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000005";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "00110";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000006";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "00111";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000007";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "01000";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000008";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "01001";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"00000009";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "01010";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    s_immed       <= x"0000000A";


    wait for gCLK_HPER*10;

----------------------------------------------------- #s 1 - 10 have been placed in registers $1 - $10

    s_rs_sel      <= "00001"; -- A
    s_rt_sel 	  <= "00010"; -- B
    s_rd_sel      <= "01011";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';     -- add
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "01011";
    s_rt_sel 	  <= "00011";
    s_rd_sel      <= "01100";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '1';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "01100";
    s_rt_sel 	  <= "00100";
    s_rd_sel      <= "01101";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "01101";
    s_rt_sel 	  <= "00101";
    s_rd_sel      <= "01110";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '1';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "01110";
    s_rt_sel 	  <= "00110";
    s_rd_sel      <= "01111";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

--------------------------------------------------- Just did add #15, $14, $6

    s_rs_sel      <= "01111";
    s_rt_sel 	  <= "00111";
    s_rd_sel      <= "10000";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '1';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "10000";
    s_rt_sel 	  <= "01000";
    s_rd_sel      <= "10001";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "10001";
    s_rt_sel 	  <= "01001";
    s_rd_sel      <= "10010";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '1';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "10010";
    s_rt_sel 	  <= "01010";
    s_rd_sel      <= "10011";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;

    s_rs_sel      <= "00000";
    s_rt_sel 	  <= "00000";
    s_rd_sel      <= "10100";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '1';
    --s_immed       <= x"00000023";
    s_immed       <= x"FFFFFFDD";


    wait for gCLK_HPER*10;

--------------------------------------------------- Just did addi $20, $0, -35

    s_rs_sel      <= "10011";
    s_rt_sel 	  <= "10100";
    s_rd_sel      <= "10101";
    regWrite	  <= '1'; 
    s_nAdd_Sub    <= '0';  
    s_ALUSrc      <= '0';
    s_immed       <= x"00000000";


    wait for gCLK_HPER*10;


    wait;




  end process;
end mixed;

