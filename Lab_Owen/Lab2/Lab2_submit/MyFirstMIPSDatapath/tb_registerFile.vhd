-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_registerFile.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- MIPS register file
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_registerFile is
  generic(gCLK_HPER   : time := 50 ns);
end tb_registerFile;

architecture behavior of tb_registerFile is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

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


signal s_CLK, s_RST, s_WE  : std_logic;
signal s_WD, s_OA, s_OB : std_logic_vector(31 downto 0);
signal s_WA,s_RA,s_RB : std_logic_vector(4 downto 0);

begin 

r_registerFile : registerFile
  port map(i_WA  =>  s_WA,
 	   i_RA  =>  s_RA,      
           i_RB  =>  s_RB,             
           i_WE  =>  s_WE,                 
           i_CLK =>  s_CLK,      
           i_RST =>  s_RST,                              
           i_WD  =>  s_WD,     
           o_A   =>  s_OA,
           o_B   =>  s_OB);   


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

    -- Read from register 0 and register 0
   s_WA  <= "00000";
   s_RA  <= "00000";    
   s_RB  <= "00000";        
   s_WE  <= '0';            
   s_RST <= '0';                       
   s_WD  <= "00000000000000000000000000000000";

    wait for cCLK_PER;

    -- Write AAAAAAAA to register 1
   s_WA  <= "00001";
   s_RA  <= "00000";   
   s_RB  <= "00000";        
   s_WE  <= '1';            
   s_RST <= '0';                       
   s_WD  <= "10101010101010101010101010101010";

    wait for cCLK_PER;

    -- Write BBBBBBBB to register 2
   s_WA  <= "00010";
   s_RA  <= "00000";   
   s_RB  <= "00000";        
   s_WE  <= '1';            
   s_RST <= '0';                       
   s_WD  <= "10111011101110111011101110111011";

    wait for cCLK_PER;


    -- Read from register 1 and register 2
   s_WA  <= "00000";
   s_RA  <= "00001";    
   s_RB  <= "00010";        
   s_WE  <= '0';            
   s_RST <= '0';                       
   s_WD  <= "00000000000000000000000000000000";

    wait for cCLK_PER;



   -- Try to Write AAAAAAAA to register 0
   s_WA  <= "00000";
   s_RA  <= "00000";   
   s_RB  <= "00000";        
   s_WE  <= '1';            
   s_RST <= '0';                       
   s_WD  <= "10101010101010101010101010101010";

    wait for cCLK_PER;

    -- Try Write CCCCCCCC to register 1, Enable = 0
   s_WA  <= "00010";
   s_RA  <= "00000";   
   s_RB  <= "00000";        
   s_WE  <= '0';            
   s_RST <= '0';                       
   s_WD  <= "10111011101110111011101110111011";

    wait for cCLK_PER;


    -- Read from register 0 and register 1
   s_WA  <= "00000";
   s_RA  <= "00000";    
   s_RB  <= "00001";        
   s_WE  <= '0';            
   s_RST <= '0';                       
   s_WD  <= "00000000000000000000000000000000";

    wait for cCLK_PER;

 -- Reset Register 2
   s_WA  <= "00010";
   s_RA  <= "00000";   
   s_RB  <= "00000";        
   s_WE  <= '0';            
   s_RST <= '1';                       
   s_WD  <= "10111011101110111011101110111011";

    wait for cCLK_PER;


    -- Read from register 2 and register 0
   s_WA  <= "00000";
   s_RA  <= "00010";    
   s_RB  <= "00000";        
   s_WE  <= '0';            
   s_RST <= '0';                       
   s_WD  <= "00000000000000000000000000000000";

    wait for cCLK_PER;



    wait;
  end process;
  
end behavior;