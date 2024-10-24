-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_barrelShifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- barrel shifter logic
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_barrelShifter is
  generic(gCLK_HPER   : time := 50 ns);
end tb_barrelShifter;

architecture behavior of tb_barrelShifter is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer :=32;

component barrelShifter is
   port(i_Shft_Type_Sel    : in std_logic;                              -- 1 bit select input: 0 = Logical (Add 0's), 1 = (Arithmetic (Add sign bits)
        i_Shft_Dir         : in std_logic;                              -- 0 for left shift, and 1 for right shift   (USE SHIFT TYPE 0 FOR LEFT SHIFT)
        i_Shft_Amt         : in std_logic_vector(4 downto 0);           -- 5 bit vector input for shift amount 0-31
        i_D                : in std_logic_vector(31 downto 0);          -- 32 bit data input
        o_O                : out std_logic_vector(31 downto 0));       -- 32 bit data output

end component;

signal s_D, s_O            : std_logic_vector(31 downto 0);
signal s_Shift_Amount      : std_logic_vector(4 downto 0);  
signal s_Shift_Type,s_Shift_Dir, s_CLK : std_logic;

begin 

b_barrelShifter : barrelShifter
  port map(i_Shft_Type_Sel    =>   s_Shift_Type,
           i_Shft_Dir         =>   s_Shift_Dir,
 	   i_Shft_Amt         =>   s_Shift_Amount,      
           i_D                =>   s_D,                  
           o_O                =>   s_O); 

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
---------------------------------START RIGHT SHIFTS------------------------------------------------------------

    -- Case 1: 0x00000000 shifted by 0    (Logical Shift)    Expected: 0x00000000
   s_Shift_Type        <= '0';
   s_Shift_Dir         <= '1';
   s_Shift_Amount      <= "00000";     
   s_D                 <= "00000000000000000000000000000000";         

    wait for cCLK_PER;

    -- Case 2: 10xFFFFFFFF shifted by 16  (Logical Shift)    Expected: 0x0000FFFF
   s_Shift_Type        <= '0';
   s_Shift_Dir         <= '1';
   s_Shift_Amount      <= "10000";     
   s_D                 <= "11111111111111111111111111111111";         

    wait for cCLK_PER;

    -- Case 3: 0x00000000 shifted by 16   (Logical Shift)    Expected: 0x00000000
   s_Shift_Type        <= '0';
   s_Shift_Dir         <= '1';
   s_Shift_Amount      <= "10000";     
   s_D                 <= "00000000000000000000000000000000";         

    wait for cCLK_PER;

    -- Case 4: 0xAAAAAAAA shifted by 5   (Logical Shift)     Expected: 0x05555555
   s_Shift_Type        <= '0';
   s_Shift_Dir         <= '1';
   s_Shift_Amount      <= "00101";     
   s_D                 <= "10101010101010101010101010101010";         

    wait for cCLK_PER;

    -- Case 5: 0x00000000 shifted by 0    (Arithmetic Shift)    Expected: 0x00000000
   s_Shift_Type        <= '1';
   s_Shift_Dir         <= '1';
   s_Shift_Amount      <= "00000";     
   s_D                 <= "00000000000000000000000000000000";         

    wait for cCLK_PER;

    -- Case 6: 10xFFFFFFFF shifted by 16  (Arithmetic Shift)    Expected: 0xFFFFFFFF
   s_Shift_Type        <= '1';
   s_Shift_Dir         <= '1';
   s_Shift_Amount      <= "10000";     
   s_D                 <= "11111111111111111111111111111111";         

    wait for cCLK_PER;

    -- Case 7: 0x00000000 shifted by 16   (Arithmetic Shift)    Expected: 0x00000000
   s_Shift_Type        <= '1';
   s_Shift_Dir         <= '1';
   s_Shift_Amount      <= "10000";     
   s_D                 <= "00000000000000000000000000000000";         

    wait for cCLK_PER;

    -- Case 8: 0xAAAAAAAA shifted by 5   (Arithmetic Shift)     Expected: 0xFD555555
   s_Shift_Type        <= '1';
   s_Shift_Dir         <= '1';
   s_Shift_Amount      <= "00101";     
   s_D                 <= "10101010101010101010101010101010";       

    wait for cCLK_PER;

-----------------------------END RIGHT SHIFTS------------------------------------------------------------


---------------------------------START LEFT SHIFTS------------------------------------------------------------

    -- Case 9: 0x00000000 shifted by 0    (Left Shift)    Expected: 0x00000000
   s_Shift_Type        <= '0';
   s_Shift_Dir         <= '0';
   s_Shift_Amount      <= "00000";     
   s_D                 <= "00000000000000000000000000000000";         

    wait for cCLK_PER;

    -- Case 10: 10xFFFFFFFF shifted by 16  (Left Shift)    Expected: 0xFFFF0000
   s_Shift_Type        <= '0';
   s_Shift_Dir         <= '0';
   s_Shift_Amount      <= "10000";     
   s_D                 <= "11111111111111111111111111111111";         

    wait for cCLK_PER;

    -- Case 11: 0x00000000 shifted by 16   (Left Shift)    Expected: 0x00000000
   s_Shift_Type        <= '0';
   s_Shift_Dir         <= '0';
   s_Shift_Amount      <= "10000";     
   s_D                 <= "00000000000000000000000000000000";         

    wait for cCLK_PER;

    -- Case 12: 0xAAAAAAAA shifted by 5   (Left Shift)     Expected: 0x05555540
   s_Shift_Type        <= '0';
   s_Shift_Dir         <= '0';
   s_Shift_Amount      <= "00101";     
   s_D                 <= "10101010101010101010101010101010";  
      
    wait for cCLK_PER;


-----------------------------END LEFT SHIFTS------------------------------------------------------------


 
    wait;
  end process;
  
end behavior;



