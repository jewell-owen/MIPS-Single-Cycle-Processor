-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_alu.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- starter alu component
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_alu is
  generic(gCLK_HPER   : time := 50 ns);
end tb_alu;

architecture behavior of tb_alu is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer :=32;

component alu is
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_BReg       : in std_logic_vector(N-1 downto 0);
       i_BImm       : in std_logic_vector(N-1 downto 0);
       i_AddSub     : in std_logic;
       i_ALUsrc     : in std_logic;
       o_S          : out std_logic_vector(N-1 downto 0));
end component;

signal s_A, s_BReg, s_BImm, s_O : std_logic_vector(N-1 downto 0); 
signal s_AddSub, s_ALUsrc, s_CLK : std_logic;

begin 

a_alu : alu
  port map(i_A       =>  s_A,
 	   i_BReg    =>  s_BReg,      
           i_BImm    =>  s_BImm,             
           i_AddSub  =>  s_AddSub,                 
           i_ALUsrc  =>  s_ALUsrc,      
           o_S       =>  s_O); 

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

    -- Case 1: A + B --> 88888888 + 77777777 = FFFFFFFF
   s_A       <= "10001000100010001000100010001000";
   s_BReg    <= "01110111011101110111011101110111";    
   s_BImm    <= "11111111111111111111111111111111";        
   s_AddSub  <= '0';            
   s_ALUsrc  <= '0';                       

    wait for cCLK_PER;

    -- Case 2: A + Imm --> 88888888 + 77777777 = FFFFFFFF
   s_A       <= "10001000100010001000100010001000";
   s_BReg    <= "11111111111111111111111111111111";    
   s_BImm    <= "01110111011101110111011101110111";        
   s_AddSub  <= '0';            
   s_ALUsrc  <= '1';                       

    wait for cCLK_PER;

    -- Case 3: A - B --> 88888888 - 77777777 = 11111111
   s_A       <= "10001000100010001000100010001000";
   s_BReg    <= "01110111011101110111011101110111";    
   s_BImm    <= "11111111111111111111111111111111";        
   s_AddSub  <= '1';            
   s_ALUsrc  <= '0';                        

    wait for cCLK_PER;

    -- Case 4: A - Imm --> 88888888 - 77777777 = 11111111
   s_A       <= "10001000100010001000100010001000";
   s_BReg    <= "11111111111111111111111111111111";    
   s_BImm    <= "01110111011101110111011101110111";        
   s_AddSub  <= '1';            
   s_ALUsrc  <= '1';                       

    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;




