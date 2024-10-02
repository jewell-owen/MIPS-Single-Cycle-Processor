-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-bit ripple-carry
-- full adder using structural VHDL.
--
--
-- NOTES:
-- Created 9/4/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adder_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width.
  port(i_C          : in std_logic;
       i_A         : in std_logic_vector(N-1 downto 0);
       i_B         : in std_logic_vector(N-1 downto 0);
       o_S          : out std_logic_vector(N-1 downto 0);
       o_C          : out std_logic);

end adder_N;


architecture structure of adder_N is

  -- 1-bit full adder
  component adder1bit
    port(i_C          : in std_logic;
         i_D0         : in std_logic;
         i_D1         : in std_logic;
         o_S          : out std_logic;
         o_C          : out std_logic);
  end component;


  -- Signals to carry the carry-bit from each 1-bit full adder to the next
  signal s_C       : std_logic_vector(N downto 0);


begin

  s_C(0) <= i_C;

  -- Instantiate N mux instances.
  G_NBit_Adder: for i in 0 to N-1 generate
    ADDERI: adder1bit port map(
	      i_C     => s_C(i),
	      i_D0    => i_A(i),
	      i_D1    => i_B(i),
	      o_S     => o_S(i),
	      o_C     => s_C(i+1));
  end generate G_NBit_Adder;

  o_C <= s_C(N);


  end structure;
