-------------------------------------------------------------------------
-- Owen Jewell
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- stackPointerRegister.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a register file.
--
--
-- NOTES:
-- Created 9/22/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.numeric_std_unsigned.all;
use IEEE.numeric_std.all;

library work;
use work.MIPS_types.all;

-- $sp	29	0x7fffeffc

entity stackPointerRegister is
  
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(31 downto 0);     -- Data value inputs
       o_Q          : out std_logic_vector(31 downto 0));   -- Data value outputs

end stackPointerRegister;

architecture structure of stackPointerRegister is

  component dffg
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
  end component;

  component dffgPC
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
  end component;


begin

  G_NBit_Reg0: for i in 0 to 1 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_D(i),
	      o_Q       => o_Q(i));
  end generate G_NBit_Reg0;

  G_NBit_Reg1: for i in 2 to 11 generate
    REGI: dffgPC port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_D(i),
	      o_Q       => o_Q(i));
  end generate G_NBit_Reg1;

    REGI_0: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_D(12),
	      o_Q       => o_Q(12));

  G_NBit_Reg2: for i in 13 to 30 generate
    REGI: dffgPC port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_D(i),
	      o_Q       => o_Q(i));
  end generate G_NBit_Reg2;

    REGI_1: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_D(31),
	      o_Q       => o_Q(31));


end structure;
