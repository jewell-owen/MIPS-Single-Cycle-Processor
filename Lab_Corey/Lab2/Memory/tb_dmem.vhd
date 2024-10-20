-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_dataPath1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for a datapath.
--              
-- Created 9/22/24.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std_unsigned.all;
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;     

      


entity tb_dmem is 
  generic(gCLK_HPER   : time := 50 ns);
end tb_dmem;


architecture mixed of tb_dmem is

constant cCLK_PER  : time := gCLK_HPER * 2;


component mem

	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '0';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end component;



  signal CLK	     : std_logic := '0';
  signal s_we		: std_logic := '1';
  signal s_addr 	: std_logic_vector((10-1) downto 0);
  signal s_data		: std_logic_vector((32-1) downto 0);
  signal s_q 		: std_logic_vector((32-1) downto 0);


begin

  DUT0: mem
  port map(		
		clk		=>  CLK,
		addr	        =>  s_addr,
		data	        =>  s_data,
		we		=>  s_we,
		q		=>  s_q
		);


  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;
 
  
  P_TEST_CASES: process
  begin
   
    s_data <= x"00000000";
    s_we   <= '0';




    s_addr <= "0000000000";
    wait for cCLK_PER;

    s_addr <= "0000000001";
    wait for cCLK_PER;

    s_addr <= "0000000010";
    wait for cCLK_PER;

    s_addr <= "0000000011";
    wait for cCLK_PER;

    s_addr <= "0000000100";
    wait for cCLK_PER;

    s_addr <= "0000000101";
    wait for cCLK_PER;

    s_addr <= "0000000110";
    wait for cCLK_PER;

    s_addr <= "0000000111";
    wait for cCLK_PER;

    s_addr <= "0000001000";
    wait for cCLK_PER;

    s_addr <= "0000001001";
    wait for cCLK_PER;

    --s_addr <= "0000000000";
    --wait for cCLK_PER;

------------------------------------------------------ writing


    s_data <= x"FFFFFFFF";
    s_we   <= '1';
    s_addr <= "0100000000";
    wait for cCLK_PER;

    s_data <= x"00000002";
    s_we   <= '1';
    s_addr <= "0100000001";
    wait for cCLK_PER;

    s_data <= x"FFFFFFFD";
    s_we   <= '1';
    s_addr <= "0100000010";
    wait for cCLK_PER;

    s_data <= x"00000004";
    s_we   <= '1';
    s_addr <= "0100000011";
    wait for cCLK_PER;

    s_data <= x"00000005";
    s_we   <= '1';
    s_addr <= "0100000100";
    wait for cCLK_PER;




    s_data <= x"00000006";
    s_we   <= '1';
    s_addr <= "0100000101";
    wait for cCLK_PER;

    s_data <= x"FFFFFFF9";
    s_we   <= '1';
    s_addr <= "0100000110";
    wait for cCLK_PER;

    s_data <= x"FFFFFFF8";
    s_we   <= '1';
    s_addr <= "0100000111";
    wait for cCLK_PER;

    s_data <= x"00000009";
    s_we   <= '1';
    s_addr <= "0100001000";
    wait for cCLK_PER;

    s_data <= x"FFFFFFF6";
    s_we   <= '1';
    s_addr <= "0100001001";
    wait for cCLK_PER;

    
------------------------------------------------------reading

    s_data <= x"00000000";
    s_we   <= '0';

	wait;


    s_addr <= "0100000000";
    wait for cCLK_PER;

    s_addr <= "0100000001";
    wait for cCLK_PER;

    s_addr <= "0100000010";
    wait for cCLK_PER;

    s_addr <= "0100000011";
    wait for cCLK_PER;

    s_addr <= "0100000100";
    wait for cCLK_PER;





    s_addr <= "0100000101";
    wait for cCLK_PER;

    s_addr <= "0100000110";
    wait for cCLK_PER;

    s_addr <= "0100000111";
    wait for cCLK_PER;

    s_addr <= "0100001000";
    wait for cCLK_PER;

    s_addr <= "0100001001";
    wait for cCLK_PER;



    wait;



  end process;
end mixed;

