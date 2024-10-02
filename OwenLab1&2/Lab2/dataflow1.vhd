-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- dataflow1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a MIPS dataflow 
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity dataflow1 is
  port(i_WA         : in std_logic_vector(4 downto 0);       -- Write Address  input
       i_RA         : in std_logic_vector(4 downto 0);       -- Read Address A input
       i_RB         : in std_logic_vector(4 downto 0);       -- Read Addres B  input
       i_WE         : in std_logic;                          -- Write Enable   input
       i_CLK        : in std_logic;                          -- Clock signal
       i_RST        : in std_logic;                          -- Reset signal
       i_ADDSUB     : in std_logic;                          -- Add or sub signal
       i_ALUSRC     : in std_logic;                          -- Reg or imm signal
       i_IMM        : in std_logic_vector(31 downto 0);      -- Immediate input
       i_WD         : in std_logic_vector(31 downto 0));     -- Write data input
  end dataflow1;

architecture structural of dataflow1 is

component alu is
generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_BReg       : in std_logic_vector(N-1 downto 0);
       i_BImm       : in std_logic_vector(N-1 downto 0);
       i_AddSub     : in std_logic;
       i_ALUsrc     : in std_logic;
       o_S          : out std_logic_vector(N-1 downto 0));
end component;

component registerFile is
  port(i_WA         : in std_logic_vector(4 downto 0);       -- Write Address  input
       i_RA         : in std_logic_vector(4 downto 0);       -- Read Address A input
       i_RB         : in std_logic_vector(4 downto 0);       -- Read Addres B  input
       i_WE         : in std_logic;                          -- Write Enable   input
       i_CLK        : in std_logic;                          -- Clock signal
       i_RST        : in std_logic;                          -- Reset signal
       i_WD         : in std_logic_vector(31 downto 0);     -- Data value A    output
       o_A          : out std_logic_vector(31 downto 0);    -- Data value A    output
       o_B          : out std_logic_vector(31 downto 0));    -- Data value B   output
end component;

signal s_OA,s_OB,s_D : std_logic_vector(31 downto 0);

begin

r_registerFile : registerFile
  port map(i_WA  =>  i_WA,
 	   i_RA  =>  i_RA,      
           i_RB  =>  i_RB,             
           i_WE  =>  i_WE,                 
           i_CLK =>  i_CLK,      
           i_RST =>  i_RST,                              
           i_WD  =>  s_D,     
           o_A   =>  s_OA,
           o_B   =>  s_OB);

a_alu : alu
  port map(i_A       =>  s_OA,
 	   i_BReg    =>  s_OB,      
           i_BImm    =>  i_IMM,             
           i_AddSub  =>  i_ADDSUB,                 
           i_ALUsrc  =>  i_ALUSRC,      
           o_S       =>  s_D);    

end structural;
