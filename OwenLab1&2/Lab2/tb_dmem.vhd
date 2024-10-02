-------------------------------------------------------------------------
-- Owen Jewell
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dmem.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- dmen.hex file
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dmem is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dmem;

architecture behavior of tb_dmem is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

component mem is
   port(clk		: in std_logic;
	addr	        : in std_logic_vector((9) downto 0);
	data	        : in std_logic_vector((31) downto 0);
	we		: in std_logic := '1';
	q		: out std_logic_vector((31) downto 0));
end component;

signal s_CLK, s_WE : std_logic;
signal s_ADDR : std_logic_vector((9) downto 0);
signal s_DATA, s_Q : std_logic_vector((31) downto 0);

begin

dmem : mem
  port map(clk   => s_CLK,
           addr  => s_ADDR,
           data  => s_DATA,
           we    => s_WE,
           q     => s_Q);

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

  --Read 1
  s_ADDR  <= "0000000000";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 1
  s_ADDR  <= "0100000000";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 1
  s_ADDR  <= "0100000000";
  s_WE <= '0';

  wait for cCLK_PER;

 --Read 2
  s_ADDR  <= "0000000001";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 2
  s_ADDR  <= "0100000001";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 2
  s_ADDR  <= "0100000001";
  s_WE <= '0';

  wait for cCLK_PER;

  --Read 3
  s_ADDR  <= "0000000011";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 3
  s_ADDR  <= "0100000011";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 3
  s_ADDR  <= "0100000011";
  s_WE <= '0';

  wait for cCLK_PER;

 --Read 4
  s_ADDR  <= "0000000100";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 4
  s_ADDR  <= "0100000100";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 4
  s_ADDR  <= "0100000100";
  s_WE <= '0';

  wait for cCLK_PER;

  --Read 5
  s_ADDR  <= "0000000101";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 5
  s_ADDR  <= "0100000101";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 5
  s_ADDR  <= "0100000101";
  s_WE <= '0';

  wait for cCLK_PER;

 --Read 6
  s_ADDR  <= "0000000110";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 6
  s_ADDR  <= "0100000110";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 6
  s_ADDR  <= "0100000110";
  s_WE <= '0';

  wait for cCLK_PER;

  --Read 7
  s_ADDR  <= "0000000111";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 7
  s_ADDR  <= "0100000111";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 7
  s_ADDR  <= "0100000111";
  s_WE <= '0';

  wait for cCLK_PER;

 --Read 8
  s_ADDR  <= "0000001000";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 8
  s_ADDR  <= "0100001000";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 8
  s_ADDR  <= "0100001000";
  s_WE <= '0';

  wait for cCLK_PER;

  --Read 9
  s_ADDR  <= "0000001001";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 9
  s_ADDR  <= "0100001001";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 9
  s_ADDR  <= "0100001001";
  s_WE <= '0';

  wait for cCLK_PER;

 --Read 10
  s_ADDR  <= "0000001010";
  s_WE <= '0';

  wait for cCLK_PER;

  --Load 10
  s_ADDR  <= "0100001010";
  s_DATA  <= s_Q;
  s_WE <= '1';

  wait for cCLK_PER;

 --Reread 10
  s_ADDR  <= "0100001010";
  s_WE <= '0';

  wait for cCLK_PER;



    wait;
  end process;
  
end behavior;


