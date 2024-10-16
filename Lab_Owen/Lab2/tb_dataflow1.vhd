-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dataflow1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- first MIPS dataflow part of lab 2
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dataflow1 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dataflow1;


architecture behavior of tb_dataflow1 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer :=32;


component dataflow1 is
  port(i_WA         : in std_logic_vector(4 downto 0);       -- Write Address  input
       i_RA         : in std_logic_vector(4 downto 0);       -- Read Address A input
       i_RB         : in std_logic_vector(4 downto 0);       -- Read Addres B  input
       i_WE         : in std_logic;                          -- Write Enable   input
       i_CLK        : in std_logic;                          -- Clock signal
       i_RST        : in std_logic;                          -- Reset signal
       i_ADDSUB     : in std_logic;                          -- Add or sub signal
       i_ALUSRC     : in std_logic;                          -- Reg or imm signal
       i_IMM        : in std_logic_vector(31 downto 0);     -- Immediate input
       i_WD         : in std_logic_vector(31 downto 0));      -- Write data input
end component;

signal s_CLK, s_RST, s_WE, s_ADDSUB, s_ALUSRC  : std_logic;
signal s_WD, s_IMM : std_logic_vector(31 downto 0);
signal s_WA,s_RA,s_RB : std_logic_vector(4 downto 0);

begin

d_dataflow1 : dataflow1
  port map(i_WA     =>  s_WA,
 	   i_RA     =>  s_RA,      
           i_RB     =>  s_RB,             
           i_WE     =>  s_WE,                 
           i_CLK    =>  s_CLK,      
           i_RST    =>  s_RST,
           i_ADDSUB => s_ADDSUB,
           i_ALUSRC => s_ALUSRC,
           i_IMM    => s_IMM,                              
           i_WD     =>  s_WD); 


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

    -- Case 1: addi $1, $0, 1    EXPECTED = 1

   s_WA      <= "00001";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000001";        
                      
    wait for cCLK_PER;

    -- Case 2: addi $2, $0, 2    EXPECTED = 2

   s_WA      <= "00010";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000010";        
                      
    wait for cCLK_PER;

    -- Case 3: addi $3, $0, 3    EXPECTED = 3

   s_WA      <= "00011";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000011";        
                      
    wait for cCLK_PER;

    -- Case 4: addi $4, $0, 4    EXPECTED = 4

   s_WA      <= "00100";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000100";        
                      
    wait for cCLK_PER;

    -- Case 5: addi $5, $0, 5    EXPECTED = 5

   s_WA      <= "00101";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000101";        
                      
    wait for cCLK_PER;

    -- Case 6: addi $6, $0, 6    EXPECTED = 6

   s_WA      <= "00110";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000110";        
                      
    wait for cCLK_PER;

    -- Case 7: addi $7, $0, 7    EXPECTED = 7

   s_WA      <= "00111";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000111";        
                      
    wait for cCLK_PER;

    -- Case 8: addi $8, $0, 8    EXPECTED = 8

   s_WA      <= "01000";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000001000";        
                      
    wait for cCLK_PER;

    -- Case 9: addi $9, $0, 9    EXPECTED = 9

   s_WA      <= "01001";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000001001";        
                      
    wait for cCLK_PER;

    -- Case 10: addi $10, $0, 10    EXPECTED = A

   s_WA      <= "01010";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000001010";        
                      
    wait for cCLK_PER;

    -- Case 11: add $11, $1, $2    EXPECTED = 1 + 2 = 3

   s_WA      <= "01011";
   s_RA      <= "00001";
   s_RB      <= "00010";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 12: sub $12, $11, $3    EXPECTED = 3 - 3 = 0

   s_WA      <= "01100";
   s_RA      <= "01011";
   s_RB      <= "00011";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '1';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 13: add $13, $12, $4    EXPECTED = 0 + 4 = 4

   s_WA      <= "01101";
   s_RA      <= "01100";
   s_RB      <= "00100";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 14: sub $14, $13, $5   EXPECTED =  4 - 5 = -1 (FFFFFFFF)

   s_WA      <= "01110";
   s_RA      <= "01101";
   s_RB      <= "00101";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '1';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 15: add $15, $14, $6    EXPECTED = -1 + 6 = 5

   s_WA      <= "01111";
   s_RA      <= "01110";
   s_RB      <= "00110";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 16: sub $16, $15, $7   EXPECTED =  5 - 7 = -2 (FFFFFFFE)

   s_WA      <= "10000";
   s_RA      <= "01111";
   s_RB      <= "00111";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '1';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 17: add $17, $16, $8    EXPECTED = -2 + 8 = 6

   s_WA      <= "10001";
   s_RA      <= "10000";
   s_RB      <= "01000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 18: sub $18, $17, $9   EXPECTED =  6 - 9 = -3 (FFFFFFFD)

   s_WA      <= "10010";
   s_RA      <= "10001";
   s_RB      <= "01001";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '1';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 19: add $19, $18, $10    EXPECTED = -3 + 10 = 7

   s_WA      <= "10011";
   s_RA      <= "10010";
   s_RB      <= "01010";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;

    -- Case 20: addi $20, $0, -35    EXPECTED = -35 (FFFFFFDD)

   s_WA      <= "10100";
   s_RA      <= "00000";
   s_RB      <= "00000";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '1';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "11111111111111111111111111011101";        
                      
    wait for cCLK_PER;

    -- Case 21: add $21, $19, $20    EXPECTED = 7 + -35 = -22 (FFFFFFE4)

   s_WA      <= "10101";
   s_RA      <= "10011";
   s_RB      <= "10100";
   s_WE      <= '1';
   s_RST     <= '0';
   s_ADDSUB  <= '0';            
   s_ALUSRC  <= '0';
   s_WD      <= "00000000000000000000000000000000";         
   s_IMM     <= "00000000000000000000000000000000";        
                      
    wait for cCLK_PER;






    wait;
  end process;
  
end behavior;


