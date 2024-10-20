-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- registerFile.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a MIPS register file 
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity registerFile is
  port(i_WA         : in std_logic_vector(4 downto 0);       -- Write Address  input
       i_RA         : in std_logic_vector(4 downto 0);       -- Read Address A input
       i_RB         : in std_logic_vector(4 downto 0);       -- Read Addres B  input
       i_WE         : in std_logic;                          -- Write Enable   input
       i_CLK        : in std_logic;                          -- Clock signal
       i_RST        : in std_logic;                          -- Reset signal
       i_WD         : in std_logic_vector(31 downto 0);     -- Data value A    output
       o_A          : out std_logic_vector(31 downto 0);    -- Data value A    output
       o_B          : out std_logic_vector(31 downto 0));    -- Data value B   output
end registerFile;

architecture structural of registerFile is 

  component register_N is 
     port(i_CLK       : in std_logic;                        -- Clock input
         i_RST        : in std_logic;                         -- Reset input
         i_WE         : in std_logic;                         -- Write enable input
         i_WD         : in std_logic_vector(31 downto 0);    -- Write Data value input
         o_Q          : out std_logic_vector(31 downto 0));  -- Data value output
  end component;

  component decoder5t32 is 
    port(i_WA         : in std_logic_vector(4 downto 0);      -- Write Address input
         i_WE         : in std_logic;                         --Write Enable
         o_Q          : out std_logic_vector(31 downto 0));   -- Data value output
  end component;

  component mux32t1 is
    port(D31,D30,D29,D28,D27,D26,D25,D24,D23,D22,D21,D20,D19,D18,D17,D16,D15,D14,D13,D12,D11,D10,D9,D8,D7,D6,D5,D4,D3,D2,D1,D0 : in std_logic_vector(31 downto 0);
         i_S : in std_logic_vector(4 downto 0);
         o_Q : out std_logic_vector(31 downto 0));
  end component;

signal s_DO : std_logic_vector(31 downto 0); --signal for decoder output
signal s_R0,s_R1,s_R2,s_R3,s_R4,s_R5,s_R6,s_R7,s_R8,s_R9,s_R10,s_R11,s_R12,s_R13,s_R14,s_R15,s_R16,s_R17,s_R18,s_R19,s_R20,s_R21,s_R22,s_R23,s_R24,s_R25,s_R26,s_R27,s_R28,s_R29,s_R30,s_R31 : std_logic_vector(31 downto 0); --signals for register data output

begin



d_decoder : decoder5t32
    port map (
              i_WA  =>  i_WA,
              i_WE  =>  i_WE,
              o_Q   =>  s_DO);


register0: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => '1',             -- Reset signal
              i_WE     => i_WE AND s_DO(0),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R0);             -- register data

register1: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(1),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R1);             -- register data

register2: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(2),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R2);             -- register data

register3: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(3),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R3);             -- register data

register4: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(4),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R4);             -- register data

register5: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(5),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R5);             -- register data

register6: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(6),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R6);             -- register data

register7: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(7),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R7);             -- register data

register8: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(8),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R8);             -- register data

register9: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(9),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R9);             -- register data

register10: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(10),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R10);             -- register data

register11: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(11),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R11);             -- register data

register12: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(12),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R12);             -- register data

register13: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(13),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R13);             -- register data

register14: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(14),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R14);             -- register data

register15: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(15),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R15);             -- register data

register16: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(16),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R16);             -- register data

register17: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(17),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R17);             -- register data

register18: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(18),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R18);             -- register data

register19: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(19),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R19);             -- register data

register20: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(20),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R20);             -- register data

register21: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(21),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R21);             -- register data

register22: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(22),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R22);             -- register data

register23: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(23),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R23);             -- register data

register24: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(24),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R24);             -- register data

register25: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(25),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R25);             -- register data

register26: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(26),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R26);             -- register data

register27: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(27),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R27);             -- register data

register28: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(28),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R28);             -- register data

register29: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(29),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R29);             -- register data

register30: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(30),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R30);             -- register data

register31: register_N 
   port map(
              i_CLK    => i_CLK,             -- Clock signal
              i_RST    => i_RST,             -- Reset signal
              i_WE     => i_WE AND s_DO(31),  -- WE = WE & the ith bit of decoder output
              i_WD     => i_WD,              -- Write Data
              o_Q      => s_R31);             -- register data


 muxA: mux32t1 
  port map(i_S   => i_RA,
           D31   => s_R31,
	   D30   => s_R30,
	   D29   => s_R29,
	   D28   => s_R28,
	   D27   => s_R27,
	   D26   => s_R26,
	   D25   => s_R25,
	   D24   => s_R24,
	   D23   => s_R23,
	   D22   => s_R22,
	   D21   => s_R21,
	   D20   => s_R20,
	   D19   => s_R19,
	   D18   => s_R18,
	   D17   => s_R17,
	   D16   => s_R16,
	   D15   => s_R15,
	   D14   => s_R14,
	   D13   => s_R13,
	   D12   => s_R12,
	   D11   => s_R11,
	   D10   => s_R10,
	   D9   => s_R9,
	   D8   => s_R8,
	   D7   => s_R7,
	   D6   => s_R6,
	   D5   => s_R5,
	   D4   => s_R4,
	   D3   => s_R3,
	   D2   => s_R2,
	   D1   => s_R1,
	   D0   => s_R0,
           o_Q   => o_A);

 muxB: mux32t1 
  port map(i_S   => i_RB,
           D31   => s_R31,
	   D30   => s_R30,
	   D29   => s_R29,
	   D28   => s_R28,
	   D27   => s_R27,
	   D26   => s_R26,
	   D25   => s_R25,
	   D24   => s_R24,
	   D23   => s_R23,
	   D22   => s_R22,
	   D21   => s_R21,
	   D20   => s_R20,
	   D19   => s_R19,
	   D18   => s_R18,
	   D17   => s_R17,
	   D16   => s_R16,
	   D15   => s_R15,
	   D14   => s_R14,
	   D13   => s_R13,
	   D12   => s_R12,
	   D11   => s_R11,
	   D10   => s_R10,
	   D9   => s_R9,
	   D8   => s_R8,
	   D7   => s_R7,
	   D6   => s_R6,
	   D5   => s_R5,
	   D4   => s_R4,
	   D3   => s_R3,
	   D2   => s_R2,
	   D1   => s_R1,
	   D0   => s_R0,
           o_Q   => o_B);

end structural;