-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_decoder5t32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a 5:32 decoder.
--              
-- Created 9/11/24.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;             

entity tb_decoder5t32 is 
end tb_decoder5t32;


architecture mixed of tb_decoder5t32 is

  component decoder5t32

    port(i_S          : in std_logic_vector(4 downto 0);
         o_F          : out std_logic_vector(31 downto 0));

  end component;


  signal s_S   : std_logic_vector(4 downto 0) := "00000";
  signal s_F   : std_logic_vector(31 downto 0) := x"00000000";
  

begin

  DUT0: decoder5t32
  port map(
            i_S     => s_S,
            o_F     => s_F);
 
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    

    s_S    <= "00000";  wait for 60 ns;-- Expect: s_F equals x"00000001"

    s_S    <= "00001";  wait for 60 ns;-- Expect: s_F equals x"00000002"

    s_S    <= "00010";  wait for 60 ns;-- Expect: s_F equals x"00000004"

    s_S    <= "00011";  wait for 60 ns;-- Expect: s_F equals x"00000008"


    s_S    <= "00100";  wait for 60 ns;-- Expect: s_F equals x"00000010"

    s_S    <= "00101";  wait for 60 ns;-- Expect: s_F equals x"00000020"

    s_S    <= "00110";  wait for 60 ns;-- Expect: s_F equals x"00000040"

    s_S    <= "00111";  wait for 60 ns;-- Expect: s_F equals x"00000080"


    s_S    <= "01000";  wait for 60 ns;
    s_S    <= "01001";  wait for 60 ns;
    s_S    <= "01010";  wait for 60 ns;
    s_S    <= "01011";  wait for 60 ns;

    s_S    <= "01100";  wait for 60 ns;
    s_S    <= "01101";  wait for 60 ns;
    s_S    <= "01110";  wait for 60 ns;
    s_S    <= "01111";  wait for 60 ns;


    s_S    <= "10000";  wait for 60 ns;
    s_S    <= "10001";  wait for 60 ns;
    s_S    <= "10010";  wait for 60 ns;
    s_S    <= "10011";  wait for 60 ns;

    s_S    <= "10100";  wait for 60 ns;
    s_S    <= "10101";  wait for 60 ns;
    s_S    <= "10110";  wait for 60 ns;
    s_S    <= "10111";  wait for 60 ns;


    s_S    <= "11000";  wait for 60 ns;-- Expect: s_F equals x"01000000"

    s_S    <= "11001";  wait for 60 ns;-- Expect: s_F equals x"02000000"

    s_S    <= "11010";  wait for 60 ns;-- Expect: s_F equals x"04000000"

    s_S    <= "11011";  wait for 60 ns;-- Expect: s_F equals x"08000000"


    s_S    <= "11100";  wait for 60 ns;-- Expect: s_F equals x"1000000"

    s_S    <= "11101";  wait for 60 ns;-- Expect: s_F equals x"2000000"

    s_S    <= "11110";  wait for 60 ns;-- Expect: s_F equals x"4000000"

    s_S    <= "11111";  wait for 60 ns;-- Expect: s_F equals x"8000000"


    wait;

  end process;

end mixed;
