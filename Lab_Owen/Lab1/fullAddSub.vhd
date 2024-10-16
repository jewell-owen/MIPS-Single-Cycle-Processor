-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- fullAddSub.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a 1 bit
-- full adder and subtractor
-------------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;

entity fullAddSub is

  port(i_A           : in std_logic;
       i_B           : in std_logic;
       i_AddSubCI    : in std_logic;
       o_CO          : out std_logic;
       o_S           : out std_logic);

end fullAddSub;

architecture structure of fullAddSub is

component fullAdder is
    port(i_A           : in std_logic;
         i_B           : in std_logic;
         i_CI          : in std_logic;
         o_CO          : out std_logic;
         o_S           : out std_logic);
end component;

component mux2t1 is
    port(i_S                  : in std_logic;
         i_D0                 : in std_logic;
         i_D1                 : in std_logic;
         o_O                  : out std_logic);
end component;

component onesComp is
    port(i_I                  : in std_logic;
         o_O                  : out std_logic);
  end component;


-- Signal to store s inverse B
signal s_XB : std_logic;
-- Signal to store mux output
signal s_OM : std_logic;

begin

g_onesComp: onesComp
     port map(
              i_I      => i_B,      
              o_O      => s_XB);

m_mux2t1: mux2t1
     port map(
              i_S      => i_AddSubCI,      
              i_D0     => i_B,  
              i_D1     => s_XB,  
              o_O      => s_OM);

f_fullAdder: fullAdder
     port map(
         i_A          =>  i_A,
         i_B          =>  s_OM,
         i_CI         =>  i_AddSubCI,
         o_CO         =>  o_CO,
         o_S          =>  o_S);


end structure;