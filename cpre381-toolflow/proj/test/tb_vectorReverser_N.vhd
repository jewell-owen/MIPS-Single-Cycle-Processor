-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_vectorReverser_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- vector order reverse
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_vectorReverser_N is
  generic(gCLK_HPER   : time := 50 ns);
end tb_vectorReverser_N;

architecture behavior of tb_vectorReverser_N is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer :=32;


component vectorReverser_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
   port(i_D                : in std_logic_vector(N-1 downto 0);          -- 32 bit data input
        o_O                : out std_logic_vector(N-1 downto 0));        -- 32 bit data output

end component;

signal s_D, s_O            : std_logic_vector(31 downto 0);
signal s_CLK               : std_logic;

begin 

v_vectorReverser_N : vectorReverser_N
  port map(      
           i_D                =>   s_D,                  
           o_O                =>   s_O); 

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

    -- Case 1: 0x00000000      Expected: 0x00000000   
   s_D                 <= "00000000000000000000000000000000";         

    wait for cCLK_PER;

    -- Case 2: 0xFFFFFFFF     Expected: 0xFFFFFFFF
   s_D                 <= "11111111111111111111111111111111";         

    wait for cCLK_PER;

    -- Case 3: 0x0000FFFF     Expected: 0xFFFF0000
   s_D                 <= "00000000000000001111111111111111";         

    wait for cCLK_PER;

    -- Case 4: 0xFFFF0000     Expected: 0x0000FFFF
 
   s_D                 <= "11111111111111110000000000000000";         

    wait for cCLK_PER;

    -- Case 5: 0xAAAAAAAA     Expected: 0x55555555
 
   s_D                 <= "10101010101010101010101010101010";         

    wait for cCLK_PER;


 
    wait;
  end process;
  
end behavior;


