-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_mux32t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- mux32t1
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux32t1 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_mux32t1;

architecture behavior of tb_mux32t1 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component mux32t1
    port(D31,D30,D29,D28,D27,D26,D25,D24,D23,D22,D21,D20,D19,D18,D17,D16,D15,D14,D13,D12,D11,D10,D9,D8,D7,D6,D5,D4,D3,D2,D1,D0 : in std_logic_vector(31 downto 0);
        i_S : in std_logic_vector(4 downto 0);
        o_Q : out std_logic_vector(31 downto 0));

  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK  : std_logic;
  signal s_IS : std_logic_vector(4 downto 0);
  signal s_Q : std_logic_vector(31 downto 0);
  signal s_D31,s_D30,s_D29,s_D28,s_D27,s_D26,s_D25,s_D24,s_D23,s_D22,s_D21,s_D20,s_D19,s_D18,s_D17,s_D16,s_D15,s_D14,s_D13,s_D12,s_D11,s_D10,s_D9,s_D8,s_D7,s_D6,s_D5,s_D4,s_D3,s_D2,s_D1,s_D0 : std_logic_vector(31 downto 0);
  


begin

  DUT: mux32t1 
  port map(i_S   => s_IS,
           D31   => s_D31,
	   D30   => s_D30,
	   D29   => s_D29,
	   D28   => s_D28,
	   D27   => s_D27,
	   D26   => s_D26,
	   D25   => s_D25,
	   D24   => s_D24,
	   D23   => s_D23,
	   D22   => s_D22,
	   D21   => s_D21,
	   D20   => s_D20,
	   D19   => s_D19,
	   D18   => s_D18,
	   D17   => s_D17,
	   D16   => s_D16,
	   D15   => s_D15,
	   D14   => s_D14,
	   D13   => s_D13,
	   D12   => s_D12,
	   D11   => s_D11,
	   D10   => s_D10,
	   D9   => s_D9,
	   D8   => s_D8,
	   D7   => s_D7,
	   D6   => s_D6,
	   D5   => s_D5,
	   D4   => s_D4,
	   D3   => s_D3,
	   D2   => s_D2,
	   D1   => s_D1,
	   D0   => s_D0,
           o_Q   => s_Q);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
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
    -- Case 0
    s_IS <= "00000";
    s_D0 <= "10101010101010101010101010101010"; --A
    wait for cCLK_PER;

    -- Case 1
    s_IS <= "00001";
    s_D1 <= "10111011101110111011101110111011"; --B
    wait for cCLK_PER;

    -- Case 2
    s_IS <= "00010";
    s_D2 <= "11001100110011001100110011001100"; --C
    wait for cCLK_PER;

    -- Case 3
    s_IS <= "00011";
    s_D3 <= "11011101110111011101110111011101"; --D
    wait for cCLK_PER;

    -- Case 28
    s_IS <= "11100";
    s_D28 <= "11101110111011101110111011101110";--E
    wait for cCLK_PER;

    -- Case 29
    s_IS <= "11101";
    s_D29 <= "11111111111111111111111111111111";--F
    wait for cCLK_PER;

    -- Case 30
    s_IS <= "11110";
    s_D30 <= "00010001000100010001000100010001";--1
    wait for cCLK_PER;

    -- Case 31
    s_IS <= "11111";
    s_D31 <= "00100010001000100010001000100010";--2
    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;
