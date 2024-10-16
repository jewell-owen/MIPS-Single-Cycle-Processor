-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the modified full adder and subtractor
-- 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_BReg       : in std_logic_vector(N-1 downto 0);
       i_BImm       : in std_logic_vector(N-1 downto 0);
       i_AddSub     : in std_logic;
       i_ALUsrc     : in std_logic;
       o_S          : out std_logic_vector(N-1 downto 0));
end alu;

architecture structural of alu is

component mux2t1_N is
generic(N : integer := 32);
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component fullAddSub_N2 is
generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       i_AddSubCI   : in std_logic;
       o_CO         : out std_logic;
       o_S          : out std_logic_vector(N-1 downto 0));
  end component;

signal s_MO : std_logic_vector(31 downto 0); -- mux out signal
signal s_CO : std_logic; -- carry out signal

begin

m_mux  : mux2t1_N 
   port map(i_S      => i_ALUsrc,      
            i_D0     => i_BReg,  
            i_D1     => i_Bimm,  
            o_O      => s_MO);

f_fullAdd : fullAddSub_N2 
  port map(i_A          =>  i_A,
           i_B          =>  s_MO,
           i_AddSubCI  =>  i_AddSub,
           o_CO         =>  s_CO,
           o_S          =>  o_S);

end structural;
