-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_deextender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- deextender component
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_deextender is
  generic(gCLK_HPER   : time := 50 ns);
end tb_deextender;

architecture behavior of tb_deextender is

constant cCLK_PER  : time := gCLK_HPER * 2;

component deextender is 
   port (i_I    :  in std_logic_vector(31 downto 0);     --16 bit immediate input                 --Extension select 0 = 0 extend, 1 = sign extend
         o_Q    :  out std_logic_vector(9 downto 0));    --32 output immediate
end component;

signal s_CLK : std_logic;
signal s_IMM : std_logic_vector(31 downto 0);
signal s_Q : std_logic_vector(9 downto 0);

begin

d_deextender : deextender
	port map(i_I   =>  s_IMM,
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

  s_IMM  <= "00000000000000000000000000000000";

  wait for cCLK_PER;

-- Case : 2

  s_IMM  <= "11111111111111111111111111111111";

  wait for cCLK_PER;

-- Case : 3

  s_IMM  <= "11111111111111110000000000000000";

  wait for cCLK_PER;

-- Case : 4

  s_IMM  <= "00000000000000001111111111111111";

  wait for cCLK_PER;


    wait;
  end process;
  
end behavior;
		