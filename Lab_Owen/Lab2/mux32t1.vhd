-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- mux32t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a dataflow implementation of an 
-- 32 to 1 mux
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux32t1 is 
   port(D31,D30,D29,D28,D27,D26,D25,D24,D23,D22,D21,D20,D19,D18,D17,D16,D15,D14,D13,D12,D11,D10,D9,D8,D7,D6,D5,D4,D3,D2,D1,D0 : in std_logic_vector(31 downto 0);
        i_S : in std_logic_vector(4 downto 0);
        o_Q : out std_logic_vector(31 downto 0));
end mux32t1;


architecture dataflow of mux32t1 is 
begin
   with i_S select
o_Q <= D0 when "00000", -- 0
       D1 when "00001", -- 1
       D2 when "00010", -- 2
       D3 when "00011", -- 3
       D4 when "00100", -- 4
       D5 when "00101", -- 5
       D6 when "00110", -- 6
       D7 when "00111", -- 7
       D8 when "01000", -- 8
       D9 when "01001", -- 9
       D10 when "01010", -- 10
       D11 when "01011", -- 11
       D12 when "01100", -- 12
       D13 when "01101", -- 13
       D14 when "01110", -- 14
       D15 when "01111", -- 15
       D16 when "10000", -- 16
       D17 when "10001", -- 17
       D18 when "10010", -- 18
       D19 when "10011", -- 19
       D20 when "10100", -- 20
       D21 when "10101", -- 21
       D22 when "10110", -- 22
       D23 when "10111", -- 23
       D24 when "11000", -- 24
       D25 when "11001", -- 25
       D26 when "11010", -- 26
       D27 when "11011", -- 27
       D28 when "11100", -- 28
       D29 when "11101", -- 29
       D30 when "11110", -- 30
       D31 when "11111", -- 31
       "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" when others;

end dataflow;