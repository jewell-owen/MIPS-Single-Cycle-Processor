-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_regFile.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a register file.
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


entity tb_regFile is 
  generic(gCLK_HPER   : time := 10 ns);
end tb_regFile;


architecture mixed of tb_regFile is

constant cCLK_PER  : time := gCLK_HPER * 2;

component regFile
	port(
		i_CLK        : in std_logic;     -- Clock input
       		i_RST        : in std_logic;     -- Reset input
       		i_regWrite   : in std_logic;     -- Write Enable
       		i_rs_sel     : in std_logic_vector(4 downto 0);
       		i_rt_sel     : in std_logic_vector(4 downto 0);
       		i_rd_sel     : in std_logic_vector(4 downto 0);
       		i_rd_D	    : in std_logic_vector(31 downto 0);
       		o_rs_D       : out std_logic_vector(31 downto 0); 
       		o_rt_D	    : out std_logic_vector(31 downto 0)
		);
end component;

  signal CLK, reset, regWrite : std_logic := '0';
  signal s_rs_sel     : std_logic_vector(4 downto 0):= "00000";
  signal s_rt_sel     : std_logic_vector(4 downto 0):= "00000";
  signal s_rd_sel     : std_logic_vector(4 downto 0):= "00000";
  signal s_rd_D	      : std_logic_vector(31 downto 0) := x"00000000";
  signal s_rs_D       : std_logic_vector(31 downto 0); 
  signal s_rt_D	      : std_logic_vector(31 downto 0);


begin

  DUT0: regFile
  port map(
		i_CLK       => CLK,
       		i_RST       => reset,
		i_regWrite  => regWrite,
       		i_rs_sel    => s_rs_sel,
       		i_rt_sel    => s_rt_sel,
       		i_rd_sel    => s_rd_sel,
       		i_rd_D	    => s_rd_D,
       		o_rs_D      => s_rs_D,
       		o_rt_D	    => s_rt_D
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
    /*
    s_rs_sel <= "00000";
    s_rt_sel <= "00001";
    s_rd_sel <= "00000";
    s_rd_D   <= x"FFFF0000";

    wait for gCLK_HPER*10;
*/
    regWrite <= '1';
    s_rs_sel <= "00000";
    s_rt_sel <= "00001";
    s_rd_sel <= "00001";
    s_rd_D   <= x"00888888";

    wait for gCLK_HPER*10;

    regWrite <= '0';
    s_rs_sel <= "00001";
    s_rt_sel <= "00010";
    s_rd_sel <= "00010";
    s_rd_D   <= x"006600AA";

    wait for gCLK_HPER*10;

    regWrite <= '1';
    s_rs_sel <= "00010";
    s_rt_sel <= "00011";
    s_rd_sel <= "00011";
    s_rd_D   <= x"BB66FF22";

    wait for gCLK_HPER*10;

    regWrite <= '1';
    s_rs_sel <= "00011";
    s_rt_sel <= "00000";
    s_rd_sel <= "00000";
    s_rd_D   <= x"FFFF0000";

    wait for gCLK_HPER*10;




    s_rs_sel      <= "01100";
    s_rt_sel 	  <= "00100";
    s_rd_sel      <= "01101";
	s_rd_D   <= x"FFFF0F00";
    regWrite	  <= '1'; 


    wait for gCLK_HPER*10;

    s_rs_sel      <= "01101";
    s_rt_sel 	  <= "00101";
    s_rd_sel      <= "01110";
	s_rd_D   <= x"FFFF00F0";
    regWrite	  <= '1'; 


    wait for gCLK_HPER*10;

    s_rs_sel      <= "01110";
    s_rt_sel 	  <= "00110";
    s_rd_sel      <= "01111";
	s_rd_D   <= x"FF990000";
    regWrite	  <= '1'; 

    wait for gCLK_HPER*10;

    s_rs_sel      <= "01111";
    s_rt_sel 	  <= "00111";
    s_rd_sel      <= "10000";
	s_rd_D   <= x"FFFF0099";
    regWrite	  <= '1'; 







    wait;



/*
    FILL_MUX_INPUTS: for i in 0 to 31 loop
	s_A(i) <= to_std_logic_vector((i + 10), 32);
    end loop FILL_MUX_INPUTS;

    MUX_TEST_LOOP: for i in 0 to 31 loop

	s_S <= i;
	wait for 60 ns;
    
    end loop MUX_TEST_LOOP;
	*/	
  end process;
end mixed;

