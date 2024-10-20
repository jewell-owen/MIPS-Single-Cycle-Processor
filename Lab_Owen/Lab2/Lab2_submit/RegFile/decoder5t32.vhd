-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- decoder5t32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a dataflow implementation of an 
-- 5 to 32 bit decoder
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity decoder5t32 is
  port(i_WA         : in std_logic_vector(4 downto 0);       -- Write Address input
       i_WE         : in std_logic;                          --Write Enable
       o_Q          : out std_logic_vector(31 downto 0));    -- Data value output
end decoder5t32;

architecture dataflow of decoder5t32 is
begin
  process (i_WA,i_WE)
  begin
  
  o_Q <= (others => '0');

  if i_WE = '1' then
  case i_WA is 
    when "00000" =>
       o_Q(0) <= '1';
    when "00001" =>
       o_Q(1) <= '1';
    when "00010" =>
       o_Q(2) <= '1';
    when "00011" =>
       o_Q(3) <= '1';
    when "00100" =>
       o_Q(4) <= '1';
    when "00101" =>
       o_Q(5) <= '1';
    when "00110" =>
       o_Q(6) <= '1';
    when "00111" =>
       o_Q(7) <= '1';
    when "01000" =>
       o_Q(8) <= '1';
    when "01001" =>
       o_Q(9) <= '1';
    when "01010" =>
       o_Q(10) <= '1';
    when "01011" =>
       o_Q(11) <= '1';
    when "01100" =>
       o_Q(12) <= '1';
    when "01101" =>
       o_Q(13) <= '1';
    when "01110" =>
       o_Q(14) <= '1';
    when "01111" =>
       o_Q(15) <= '1';
    when "10000" =>
       o_Q(16) <= '1';
    when "10001" =>
       o_Q(17) <= '1';
    when "10010" =>
       o_Q(18) <= '1';
    when "10011" =>
       o_Q(19) <= '1';
    when "10100" =>
       o_Q(20) <= '1';
    when "10101" =>
       o_Q(21) <= '1';
    when "10110" =>
       o_Q(22) <= '1';
    when "10111" =>
       o_Q(23) <= '1';
    when "11000" =>
       o_Q(24) <= '1';
    when "11001" =>
       o_Q(25) <= '1';
    when "11010" =>
       o_Q(26) <= '1';
    when "11011" =>
       o_Q(27) <= '1';
    when "11100" =>
       o_Q(28) <= '1';
    when "11101" =>
       o_Q(29) <= '1';
    when "11110" =>
       o_Q(30) <= '1';
    when "11111" =>
       o_Q(31) <= '1';
    when others =>
       null;
end case;
end if;
end process;

end dataflow;
