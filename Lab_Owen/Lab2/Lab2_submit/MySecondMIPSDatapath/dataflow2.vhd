-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- dataflow2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the second implementation of a MIPS dataflow 
-- for lab  2
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity dataflow2 is
  port(i_WA         : in std_logic_vector(4 downto 0);       -- Write Address  input
       i_RA         : in std_logic_vector(4 downto 0);       -- Read Address A input
       i_RB         : in std_logic_vector(4 downto 0);       -- Read Addres B  input
       i_WE_REG     : in std_logic;                          -- Write Enable register input
       i_WE_MEM     : in std_logic;                          -- Write Enable memory input
       i_CLK        : in std_logic;                          -- Clock signal
       i_RST_REG    : in std_logic;                          -- Reset signal
       i_ADDSUB     : in std_logic;                          -- Add or sub signal
       i_ALUSRC     : in std_logic;                          -- Reg or imm signal
       i_IMM_EXT    : in std_logic;                          -- 0 extend or sign extend signal
       i_MEM_2_REG  : in std_logic;                          -- 0 puts alu into reg data, 1 puts mem into reg data
       i_IMM        : in std_logic_vector(15 downto 0));      -- Immediate input
  end dataflow2;

architecture structural of dataflow2 is

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

component mem is
   port(clk		: in std_logic;
	addr	        : in std_logic_vector((9) downto 0);
	data	        : in std_logic_vector((31) downto 0);
	we		: in std_logic := '1';
	q		: out std_logic_vector((31) downto 0));
end component;

component extender is 
   port (i_IMM  :  in std_logic_vector(15 downto 0);     --16 bit immediate input
         i_EXTS :  in std_logic;                         --Extension select 0 = 0 extend, 1 = sign extend
         o_Q    :  out std_logic_vector(31 downto 0));    --32 output immediate
end component;

component deextender is
   port (i_I    :  in std_logic_vector(31 downto 0);     --32 bit input
         o_Q    :  out std_logic_vector(9 downto 0));    --10 bit output 
end component;


component mux2t1_N is
generic(N : integer := 32);
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

signal s_OA,s_OB,s_EXT_IMM,s_ALU_OUT,s_MEM_OUT,s_MUX_OUT : std_logic_vector(31 downto 0);
signal s_DEXT_ADDR : std_logic_vector(9 downto 0);
signal s_CLK : std_logic;


begin

r_registerFile : registerFile
  port map(i_WA  =>  i_WA,
 	   i_RA  =>  i_RA,      
           i_RB  =>  i_RB,             
           i_WE  =>  i_WE_REG,                 
           i_CLK =>  i_CLK,      
           i_RST =>  i_RST_REG,                              
           i_WD  =>  s_MUX_OUT,     
           o_A   =>  s_OA,
           o_B   =>  s_OB);

e_extender : extender
	port map(i_IMM   =>  i_IMM,
		 i_EXTS  =>  i_IMM_EXT,
		 o_Q     =>  s_EXT_IMM);

a_alu : alu
  port map(i_A       =>  s_OA,
 	   i_BReg    =>  s_OB,      
           i_BImm    =>  s_EXT_IMM,             
           i_AddSub  =>  i_ADDSUB,                 
           i_ALUsrc  =>  i_ALUSRC,      
           o_S       =>  s_ALU_OUT); 

d_deextender : deextender
        port map(i_I     =>  s_ALU_OUT,
		 o_Q     =>  s_DEXT_ADDR);

dmem : mem
  port map(clk   => i_CLK,
           addr  => s_DEXT_ADDR,
           data  => s_OB,
           we    => i_WE_MEM,
           q     => s_MEM_OUT);

m_mux  : mux2t1_N 
   port map(i_S      => i_MEM_2_REG,      
            i_D0     => s_ALU_OUT,  
            i_D1     => s_MEM_OUT,  
            o_O      => s_MUX_OUT);   

end structural;
