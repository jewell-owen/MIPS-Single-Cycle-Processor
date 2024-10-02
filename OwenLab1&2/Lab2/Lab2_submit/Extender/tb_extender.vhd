-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- extender component
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_extender is
  generic(gCLK_HPER   : time := 50 ns);
end tb_extender;

architecture behavior of tb_extender is

constant cCLK_PER  : time := gCLK_HPER * 2;

component extender is 
   port (i_IMM  :  in std_logic_vector(15 downto 0);     --16 bit immediate input
         i_EXTS :  in std_logic;                         --Extension select 0 = 0 extend, 1 = sign extend
         o_Q    :  out std_logic_vector(31 downto 0));    --32 output immediate
end component;

signal s_CLK, s_EXTS : std_logic;
signal s_IMM : std_logic_vector(15 downto 0);
signal s_Q : std_logic_vector(31 downto 0);

begin

e_extender : extender
	port map(i_IMM   =>  s_IMM,
		 i_EXTS  =>  s_EXTS,
		 o_Q     =>  s_Q);

P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin


-- Case : 1

  s_IMM  <= "0000111100001111";
  s_EXTS <= '0';

  wait for cCLK_PER;

-- Case : 2

  s_IMM  <= "1111000011110000";
  s_EXTS <= '0';

  wait for cCLK_PER;

-- Case : 3

  s_IMM  <= "0000111100001111";
  s_EXTS <= '1';

  wait for cCLK_PER;

-- Case : 4

  s_IMM  <= "1111000011110000";
  s_EXTS <= '1';

  wait for cCLK_PER;


    wait;
  end process;
  
end behavior;
		