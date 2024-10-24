------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- barrelShifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the project1 implementation of a
-- barrel shifter
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity barrelShifter is
   port(i_Shft_Type_Sel    : in std_logic;                              -- 1 bit select input: 0 = Logical (Add 0's), 1 = (Arithmetic (Add sign bits)
        i_Shft_Dir         : in std_logic;                              -- 0 for left shift, and 1 for right shift   (USE SHIFT TYPE 0 FOR LEFT SHIFT)
        i_Shft_Amt         : in std_logic_vector(4 downto 0);           -- 5 bit vector input for shift amount 0-31
        i_D                : in std_logic_vector(31 downto 0);          -- 32 bit data input
        o_O                : out std_logic_vector(31 downto 0));       -- 32 bit data output

end barrelShifter;

architecture structural of barrelShifter is

  component mux2t1 is
    port(i_S                  : in std_logic;
         i_D0                 : in std_logic;
         i_D1                 : in std_logic;
         o_O                  : out std_logic);
  end component;

  component mux2t1_N is
    port(i_S                  : in std_logic;
         i_D0                 : in std_logic_vector(31 downto 0);
         i_D1                 : in std_logic_vector(31 downto 0);
         o_O                  : out std_logic_vector(31 downto 0));
  end component;

component vectorReverser_N is
   port(i_D                : in std_logic_vector(31 downto 0);          -- 32 bit data input
        o_O                : out std_logic_vector(31 downto 0));        -- 32 bit data output

end component;

--signal to carry output of muxe wave 1,2,3 and 4
signal s_Mux_Wave1_O,s_Mux_Wave2_O,s_Mux_Wave3_O,s_Mux_Wave4_O, s_Rev_D, s_INPUT, s_FINAL_MUX_OUT, s_SECOND_REVERSE : std_logic_vector(31 downto 0);
signal s_EXT_BIT : std_logic;

begin

VECTORREVERSER: vectorReverser_N port map(
              i_D                => i_D,
              o_O                => s_Rev_D);


-- Extension bit select mux 
EXTENSIONMUX: mux2t1 port map(
              i_S      => i_Shft_Type_Sel,    -- All instances share the same select input.
              i_D0     => '0',                -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => i_D(31),           -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_EXT_BIT);            -- ith instance's data output hooked up to ith data output.

-- Shift direction select 
DIRECTIONMUX: mux2t1_N port map(
              i_S      => i_Shft_Dir,    -- All instances share the same select input.
              i_D0     => s_Rev_D,                -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => i_D,           -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_INPUT);            -- ith instance's data output hooked up to ith data output.


-----------------------------------------------MUX WAVE 1 START-----------------------------------------------MUX WAVE 1 START-----------------------------------------
 -- Instantiate cascading mux wave 1
  G_MUX_WAVE_START_1: for i in 0 to 30 generate
    MUXI1START: mux2t1 port map(
              i_S      => i_Shft_Amt(0),      -- All instances share the same select input.
              i_D0     => s_INPUT(i),             -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_INPUT(i+1),           -- ith instance's data 1 input hooked up to ith + 1 data 1 input.
              o_O      => s_Mux_Wave1_O(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_START_1;

 --31st mux in mux wave 1
 WAVE1MUX31: mux2t1 port map(
              i_S      => i_Shft_Amt(0),     --Same select
              i_D0     => s_INPUT(31),           --Last data input
              i_D1     => s_EXT_BIT,         --Last input is ext bit
              o_O      => s_Mux_Wave1_O(31));       

-----------------------------------------------MUX WAVE 1 END-----------------------------------------------MUX WAVE 1 END---------------------------------------------
-----------------------------------------------MUX WAVE 2 START---------------------------------------------MUX WAVE 2 START-------------------------------------------
 -- Instantiate cascading mux wave 2
  G_MUX_WAVE_START_2: for i in 0 to 29 generate
    MUXI2START: mux2t1 port map(
              i_S      => i_Shft_Amt(1),      -- All instances share the same select input.
              i_D0     => s_Mux_Wave1_O(i),   -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_Mux_Wave1_O(i+2), -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_Mux_Wave2_O(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_START_2;

  G_MUX_WAVE_END_2: for i in 30 to 31 generate
    MUXI2END: mux2t1 port map(
              i_S      => i_Shft_Amt(1),      -- All instances share the same select input.
              i_D0     => s_Mux_Wave1_O(i),   -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_EXT_BIT,           -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_Mux_Wave2_O(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_END_2;
-----------------------------------------------MUX WAVE 2 END-----------------------------------------------MUX WAVE 2 END---------------------------------------------
-----------------------------------------------MUX WAVE 3 START---------------------------------------------MUX WAVE 3 START-------------------------------------------
 -- Instantiate cascading mux wave 3
  G_MUX_WAVE_START_3: for i in 0 to 27 generate
    MUXI3START: mux2t1 port map(
              i_S      => i_Shft_Amt(2),      -- All instances share the same select input.
              i_D0     => s_Mux_Wave2_O(i),   -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_Mux_Wave2_O(i+4), -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_Mux_Wave3_O(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_START_3;

  G_MUX_WAVE_END_3: for i in 28 to 31 generate
    MUXI3END: mux2t1 port map(
              i_S      => i_Shft_Amt(2),      -- All instances share the same select input.
              i_D0     => s_Mux_Wave2_O(i),   -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_EXT_BIT,          -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_Mux_Wave3_O(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_END_3;
-----------------------------------------------MUX WAVE 3 END-----------------------------------------------MUX WAVE 3 END---------------------------------------------
-----------------------------------------------MUX WAVE 4 START---------------------------------------------MUX WAVE 4 START-------------------------------------------
 -- Instantiate cascading mux wave 4
  G_MUX_WAVE_START_4: for i in 0 to 23 generate
    MUXI4START: mux2t1 port map(
              i_S      => i_Shft_Amt(3),      -- All instances share the same select input.
              i_D0     => s_Mux_Wave3_O(i),   -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_Mux_Wave3_O(i+8), -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_Mux_Wave4_O(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_START_4;

  G_MUX_WAVE_END_4: for i in 24 to 31 generate
    MUXI4END: mux2t1 port map(
              i_S      => i_Shft_Amt(3),      -- All instances share the same select input.
              i_D0     => s_Mux_Wave3_O(i),   -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_EXT_BIT,          -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_Mux_Wave4_O(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_END_4;
-----------------------------------------------MUX WAVE 4 END-----------------------------------------------MUX WAVE 4 END---------------------------------------------
-----------------------------------------------MUX WAVE 5 START---------------------------------------------MUX WAVE 5 START-------------------------------------------
 -- Instantiate cascading mux wave 5
  G_MUX_WAVE_START_5: for i in 0 to 15 generate
    MUXI5START: mux2t1 port map(
              i_S      => i_Shft_Amt(4),      -- All instances share the same select input.
              i_D0     => s_Mux_Wave4_O(i),   -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_Mux_Wave4_O(i+16),-- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => s_FINAL_MUX_OUT(i));            -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_START_5;

  G_MUX_WAVE_END_5: for i in 16 to 31 generate
    MUXI5END: mux2t1 port map(
              i_S      => i_Shft_Amt(4),      -- All instances share the same select input.
              i_D0     => s_Mux_Wave4_O(i),   -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => s_EXT_BIT,          -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => S_FINAL_MUX_OUT(i));            -- ith instance's data output hooked up to ith data output.

  end generate G_MUX_WAVE_END_5;
-----------------------------------------------MUX WAVE 5 END-----------------------------------------------MUX WAVE 5 END---------------------------------------------
  
--Re reverse for left shift case
FINALVECTORREVERSER: vectorReverser_N port map(
              i_D                => s_FINAL_MUX_OUT,
              o_O                => s_SECOND_REVERSE);



-- Re reverse  if direction was left 
FINALDIRECTIONMUX: mux2t1_N port map(
              i_S      => i_Shft_Dir,    -- All instances share the same select input.
              i_D0     => s_SECOND_REVERSE,                -- ith instance's data 0 input hooked up to ith data 0 input.
              i_D1     => S_FINAL_MUX_OUT,           -- ith instance's data 1 input hooked up to ith data 1 input.
              o_O      => o_O);            -- ith instance's data output hooked up to ith data output.




end structural;