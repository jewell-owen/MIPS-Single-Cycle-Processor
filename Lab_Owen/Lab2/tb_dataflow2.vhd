-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dataflow2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- second MIPS dataflow part of lab 2
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dataflow2 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dataflow2;

--mem load -infile dmem.hex -format hex /tb_dataflow2/d_dataflow2/dmem/ram

architecture behavior of tb_dataflow2 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer :=32;

component dataflow2 is
  port(i_WA         : in std_logic_vector(4 downto 0);       -- Write Address  input
       i_RA         : in std_logic_vector(4 downto 0);       -- Read Address A input
       i_RB         : in std_logic_vector(4 downto 0);       -- Read Addres B  input
       i_WE_REG     : in std_logic;                          -- Write Enable register input
       i_WE_MEM     : in std_logic;                          -- Write Enable memory input
       i_CLK        : in std_logic;                          -- Clock signal
       i_RST_REG    : in std_logic;                          -- Reset signal
       i_ADDSUB     : in std_logic;                          -- Add or sub signal
       i_ALUSRC     : in std_logic;                          -- Reg or imm signal ( 0 reg, 1 imm)
       i_IMM_EXT    : in std_logic;                          -- 0 extend or sign extend signal
       i_MEM_2_REG  : in std_logic;                          -- 0 puts alu into reg data, 1 puts mem into reg data
       i_IMM        : in std_logic_vector(15 downto 0));      -- Immediate input
  end component;

signal s_CLK, s_RST_REG, s_WE_REG, s_WE_MEM, s_IMM_EXT, s_MEM_2_REG, s_ADDSUB, s_ALUSRC  : std_logic;
signal s_IMM  : std_logic_vector(15 downto 0);
signal s_WA,s_RA,s_RB : std_logic_vector(4 downto 0);

begin

d_dataflow2 : dataflow2
  port map(i_WA         =>  s_WA,
 	   i_RA         =>  s_RA,      
           i_RB         =>  s_RB,             
           i_WE_REG     =>  s_WE_REG,
           i_WE_MEM     =>  s_WE_MEM,                  
           i_CLK        =>  s_CLK,      
           i_RST_REG    =>  s_RST_REG,
           i_ADDSUB     =>  s_ADDSUB,
           i_ALUSRC     =>  s_ALUSRC,
           i_IMM_EXT    =>  s_IMM_EXT,
           i_MEM_2_REG  =>  s_MEM_2_REG,
           i_IMM        =>  s_IMM);                             


P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;

 -- Testbench process  
  P_TB: process
  begin

    -- Case 1: addi $25, $0, 0    EXPECTED = 0

   s_WA        <= "11001";
   s_RA        <= "00000";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

    -- Case 2: addi $26, $0, 256    EXPECTED = 256

   s_WA        <= "11010";
   s_RA        <= "00000";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000100000000";       
                             
    wait for cCLK_PER;

    -- Case 3: lw $1, 0($25)    EXPECTED = $1 = FFFFFFFF = -1

   s_WA        <= "00001";
   s_RA        <= "11001";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '1';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

    -- Case 4: lw $2, 1($25)    EXPECTED = $2 = 00000002

   s_WA        <= "00010";
   s_RA        <= "11001";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '1';
   s_IMM     <= "0000000000000001";       
                             
    wait for cCLK_PER;

    -- Case 5: add $1, $1, $2    EXPECTED = -1 + 2 = 1

   s_WA        <= "00001";
   s_RA        <= "00001";
   s_RB        <= "00010";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '0';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

    -- Case 6: sw $1, 0($26)    EXPECTED = store 1

   s_WA        <= "00000";
   s_RA        <= "11010";
   s_RB        <= "00001";
   s_WE_REG    <= '0';
   s_WE_MEM    <= '1';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

    -- Case 7: lw $2, 2($25)    EXPECTED = $2 = -3

   s_WA        <= "00010";
   s_RA        <= "11001";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '1';
   s_IMM     <= "0000000000000010";       
                             
    wait for cCLK_PER;

 -- Case 8: add $1, $1, $2    EXPECTED = 1 + -3 = -2

   s_WA        <= "00001";
   s_RA        <= "00001";
   s_RB        <= "00010";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '0';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

    -- Case 9: sw $1, 4($26)    EXPECTED = store -2 at addr 256 + 4

   s_WA        <= "00000";
   s_RA        <= "11010";
   s_RB        <= "00001";
   s_WE_REG    <= '0';
   s_WE_MEM    <= '1';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000100";       
                             
    wait for cCLK_PER;

    -- Case 10: lw $2, 3($25)    EXPECTED = $2 = 4

   s_WA        <= "00010";
   s_RA        <= "11001";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '1';
   s_IMM     <= "0000000000000011";       
                             
    wait for cCLK_PER;

 -- Case 11: add $1, $1, $2    EXPECTED = -2 + 4 = 2

   s_WA        <= "00001";
   s_RA        <= "00001";
   s_RB        <= "00010";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '0';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

    -- Case 12: sw $1, 8($26)    EXPECTED = store 2

   s_WA        <= "00000";
   s_RA        <= "11010";
   s_RB        <= "00001";
   s_WE_REG    <= '0';
   s_WE_MEM    <= '1';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000001000";       
                             
    wait for cCLK_PER;

    -- Case 13: lw $2, 4($25)    EXPECTED = $2 = 5

   s_WA        <= "00010";
   s_RA        <= "11001";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '1';
   s_IMM     <= "0000000000000100";       
                             
    wait for cCLK_PER;

 -- Case 14: add $1, $1, $2    EXPECTED = 2 + 5 = 7

   s_WA        <= "00001";
   s_RA        <= "00001";
   s_RB        <= "00010";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '0';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

    -- Case 15: sw $1, 12($26)    EXPECTED = Store 7

   s_WA        <= "00000";
   s_RA        <= "11010";
   s_RB        <= "00001";
   s_WE_REG    <= '0';
   s_WE_MEM    <= '1';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000001100";       
                             
    wait for cCLK_PER;

    -- Case 16: lw $2, 5($25)    EXPECTED = $2 = 6

   s_WA        <= "00010";
   s_RA        <= "11001";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '1';
   s_IMM     <= "0000000000000101";       
                             
    wait for cCLK_PER;

 -- Case 17: add $1, $1, $2    EXPECTED = 7 + 6 = 13

   s_WA        <= "00001";
   s_RA        <= "00001";
   s_RB        <= "00010";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '0';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

    -- Case 18: sw $1, 16($26)    EXPECTED = store 13

   s_WA        <= "00000";
   s_RA        <= "11010";
   s_RB        <= "00001";
   s_WE_REG    <= '0';
   s_WE_MEM    <= '1';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000010000";       
                             
    wait for cCLK_PER;

    -- Case 19: lw $2, 6($25)    EXPECTED = $2 = -7

   s_WA        <= "00010";
   s_RA        <= "11001";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '1';
   s_IMM     <= "0000000000000110";       
                             
    wait for cCLK_PER;

 -- Case 20: add $1, $1, $2    EXPECTED = 13 + -7 = 6

   s_WA        <= "00001";
   s_RA        <= "00001";
   s_RB        <= "00010";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '0';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000000000000000";       
                             
    wait for cCLK_PER;

 -- Case 20: addi $27, $0, 512    EXPECTED = 512

   s_WA        <= "11011";
   s_RA        <= "00000";
   s_RB        <= "00000";
   s_WE_REG    <= '1';
   s_WE_MEM    <= '0';
   s_RST_REG   <= '0';
   s_ADDSUB    <= '0';            
   s_ALUSRC    <= '1';
   s_IMM_EXT   <= '0';
   s_MEM_2_REG <= '0';
   s_IMM     <= "0000001000000000";       
                             
    wait for cCLK_PER;






    wait;
  end process;
  
end behavior;
