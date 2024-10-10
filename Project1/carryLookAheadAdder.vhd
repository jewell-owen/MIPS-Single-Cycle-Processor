-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- carryLookaheadAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a N Bit
-- look ahead adder
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

---------------------------------------------------------------------
--Over Flow Calculation:
-- take the xor of Cn-1 and Cout to get over flow.
--   |   Cn-1 | Cout | Overflow  |
--   |  ________________________ |
--   |     0  |   0  |   0       |
--   |     0  |   1  |   1       |
--   |     1  |   0  |   1       |
--   |     1  |   1  |   0       |
---------------------------------------------------------------------

entity carryLookaheadAdder is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       i_nAddSub    : in std_logic;
       o_C          : out std_logic;
       o_O          : out std_logic;
       o_S          : out std_logic_vector(31 downto 0));

end carryLookaheadAdder;

architecture structural of fullAddSub_N is

component fullAddSub_N is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       i_AddSubCI   : in std_logic;
       o_CO         : out std_logic;
       o_S          : out std_logic_vector(31 downto 0));

end component;

component xorg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

--Signals


begin


end structural;