-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- addSub_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-bit full
-- adder/subtractor using structural VHDL, generics, and more.
--
--
-- NOTES:
-- Created 9/4/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity addSub_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width.
  port(i_nAdd_Sub   : in std_logic;
       i_DA          : in std_logic_vector(N-1 downto 0);
       i_DB          : in std_logic_vector(N-1 downto 0);
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


  -- Signals to carry the inverted B input
  signal s_InvB    : std_logic_vector(N-1 downto 0);
  -- Signals to carry the normal or inverted B input depending on i_nAddSub
  signal s_MuxB    : std_logic_vector(N-1 downto 0);


begin

  g_NbitInv: onesComp_N port map (
		  i_A => i_DB,
		  o_F => s_InvB);


  g_NbitMux: mux2t1_N port map (
		  i_S => i_nAdd_Sub,
		  i_D0 => i_DB,
		  i_D1 => s_InvB,
		  o_O => s_MuxB);

  g_NbitAdder: adder_N port map (
		  i_C => i_nAdd_Sub,
		  i_A => i_DA,
		  i_B => s_MuxB,
		  o_S => o_Sum,
		  o_C => o_Car);


  end structure;
