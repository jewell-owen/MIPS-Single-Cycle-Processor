-------------------------------------------------------------------------
-- Owen Jewell
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- reg_EXMEM.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a N-bit register
-- for the IF/ID pipeline register
--
--
-- NOTES:
-- Created 11/05/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity reg_EXMEM is

  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_PCnext     : in std_logic_vector(31 downto 0);     -- fetch calculated PC
       o_PCnext     : out std_logic_vector(31 downto 0);     -- fetch calculated PC
       i_Branch     : in std_logic;     -- Branch control signal
       i_MemWr      : in std_logic;     -- MemWr control signal
       i_RegWr      : in std_logic;     -- RegWr control signal
       i_MemToReg   : in std_logic;     -- MemToReg control signal
       i_AluZero    : in std_logic;     -- ALu is 0 control signal
       i_isJumpReg    : in std_logic;   -- JumpReg control signal
       o_AluZero    : in std_logic;     -- ALu is 0 control signal
       o_isJumpReg    : in std_logic;   -- JumpReg control signal
       o_Branch     : out std_logic;     -- Branch control signal
       o_MemWr      : out std_logic;     -- MemWr control signal
       o_RegWr      : out std_logic;     -- RegWr control signal
       o_MemToReg   : out std_logic;     -- MemToReg control signal
       i_RegWrAddr  : in std_logic_vector(4 downto 0);     -- RegWrAddr
       o_RegWrAddr  : in std_logic_vector(4 downto 0);     -- RegWrAddr
       i_isJump     : in std_logic;     -- RegWr control signal
       i_luiCtrl    : in std_logic;     -- RegWr control signal
       i_Imm        : in std_logic_vector(15 downto 0);;     -- RegWr control signal
       o_isJump     : in std_logic;     -- RegWr control signal
       o_luiCtrl    : in std_logic;     -- RegWr control signal
       o_Imm        : in std_logic_vector(15 downto 0);
       i_AluOut     : in std_logic_vector(31 downto 0);     -- Alu input
       i_RdDataB    : in std_logic_vector(31 downto 0);     -- Read Data B input
       i_PC         : in std_logic_vector(31 downto 0);     -- PC input
       o_AluOut     : out std_logic_vector(31 downto 0);    -- Alu output
       o_RdDataB    : out std_logic_vector(31 downto 0);     -- Read Data B output
       o_PC         : out std_logic_vector(31 downto 0));   -- Pc output  -- Pc output

end reg_EXMEM;

architecture structure of reg_EXMEM is


  component dffg
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic;     -- Data value input
         o_Q          : out std_logic);   -- Data value output
  end component;


begin


  G_NBit_RegALU: for i in 0 to 31 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_AluOut(i),
	      o_Q       => o_AluOut(i));
  end generate G_NBit_RegALU;

  G_NBit_RegPC: for i in 0 to 31 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_PC(i),
	      o_Q       => o_PC(i));
  end generate G_NBit_RegPC;

  G_NBit_RegRdDtaB: for i in 0 to 31 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_RdDataB(i),
	      o_Q       => o_RdDataB(i));
  end generate G_NBit_RegRdDtaB;

 G_NBit_RegPCNext: for i in 0 to 31 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_PCnext(i),
	      o_Q       => o_PCnext(i));
  end generate G_NBit_RegPCNext;

G_NBit_RegRegWr: for i in 0 to 4 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_RegWrAddr(i),
	      o_Q       => o_RegWrAddr(i));
  end generate G_NBit_RegRegWr;

G_NBit_RegIMM: for i in 0 to 15 generate
    REGI: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_Imm(i),
	      o_Q       => o_Imm(i));
  end generate G_NBit_RegIMM;

 isJump: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_isJump,
	      o_Q       => o_isJump);

 luiCtrl: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_luiCtrl,
	      o_Q       => o_luiCtrl);

 Branch: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_Branch,
	      o_Q       => o_Branch);

 MemWr: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_MemWr,
	      o_Q       => o_MemWr);

 RegWr: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_RegWr,
	      o_Q       => o_RegWr);

 MemToReg: dffg port map(
	      i_CLK     => i_CLK,
	      i_RST     => i_RST,
	      i_WE      => i_WE,
	      i_D       => i_MemToReg,
	      o_Q       => o_MemToReg);

  
end structure;
