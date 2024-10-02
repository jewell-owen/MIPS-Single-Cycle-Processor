-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- addSub_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-bit full
-- adder/subtractor using structural VHDL, generics, and more.
-- Also contains immediate value capability.
--
-- NOTES:
-- Created 9/22/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity addSub_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width.
  port(i_nAdd_Sub     : in std_logic;
       i_ALUSrc       : in std_logic;
       i_immed        : in std_logic_vector(N-1 downto 0);
       i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Car          : out std_logic);

end addSub_N;


architecture structure of addSub_N is

  -- N-bit full adder
  component adder_N
    generic(N : integer := 32); 
    port(i_C          : in std_logic;
         i_A          : in std_logic_vector(N-1 downto 0);
         i_B          : in std_logic_vector(N-1 downto 0);
         o_S          : out std_logic_vector(N-1 downto 0);
         o_C          : out std_logic);
  end component;

  -- N-bit Inverter
  component onesComp_N
    generic(N : integer := 32); 
    port(i_A         : in std_logic_vector(N-1 downto 0);
         o_F         : out std_logic_vector(N-1 downto 0));
  end component;

  -- N-bit 2:1 Mux
  component mux2t1_N
    generic(N : integer := 32); 
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));
  end component;


  -- Signals to carry the inverted (B or immediate value) input
  signal s_InvB_ALU    : std_logic_vector(N-1 downto 0);
  -- Signals to carry the value depending on i_nAddSub and i_ALUSrc
  signal s_MuxB    : std_logic_vector(N-1 downto 0);
  -- Signals to carry the (normal B or immediate value) input depending on i_ALUSrc
  signal s_MuxB_ALU    : std_logic_vector(N-1 downto 0);


begin

  g_NbitMux: mux2t1_N port map (
		  i_S => i_ALUSrc,
		  i_D0 => i_DB,   
		  i_D1 => i_immed, 
		  o_O => s_MuxB_ALU);

  g_NbitInv: onesComp_N port map (
		  i_A => s_MuxB_ALU,
		  o_F => s_InvB_ALU);

  g_NbitMux2: mux2t1_N port map (
		  i_S => i_nAdd_Sub,
		  i_D0 => s_MuxB_ALU,
		  i_D1 => s_InvB_ALU,
		  o_O => s_MuxB);

  g_NbitAdder: adder_N port map (
		  i_C => i_nAdd_Sub,
		  i_A => i_DA,
		  i_B => s_MuxB,
		  o_S => o_Sum,
		  o_C => o_Car);


  end structure;
