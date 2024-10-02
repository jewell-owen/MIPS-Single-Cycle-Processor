-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structure implementation of a 2 to 1 mux.
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is

  port(i_D0          : in std_logic;
       i_D1          : in std_logic;
       i_S	     : in std_logic;
       o_O           : out std_logic);

end mux2t1;

architecture structure of mux2t1 is
-- Describe the component entities as defined in andg2.vhd, org2.vhd, notg.vhd

component invg
    port(i_A          : in std_logic;
         o_F          : out std_logic);
  end component;

  component andg2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

  component org2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;

-- Signal to store s inverse
signal s_I : std_logic;
-- Signal to store 1st and gate
signal s_A1 : std_logic;
-- Signal to store 2nd and gate
signal s_A2 : std_logic;

begin

-----------------------------------------------------------------------------------
g_Not: invg
    port MAP(i_A             => i_S,
             o_F            => s_I);

g_And1: andg2
    port MAP(i_A             => i_D0,
             i_B             => s_I,
             o_F            => s_A1);

g_And2: andg2
    port MAP(i_A             => i_S,
             i_B             => i_D1,
             o_F            => s_A2);

g_Or: org2
    port MAP(i_A             => s_A1,
             i_B             => s_A2,
             o_F            => o_O);

end structure;