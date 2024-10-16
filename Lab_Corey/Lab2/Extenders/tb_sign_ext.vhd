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

      


entity tb_sign_ext is 
end tb_sign_ext;


architecture mixed of tb_sign_ext is




component sign_ext

  generic(	INPUT_BIT_LENGTH : integer := 16;
		OUTPUT_BIT_LENGTH  : integer := 32); 

  port(		i_signSel : in std_logic;
		i_imm : in std_logic_vector(INPUT_BIT_LENGTH-1 downto 0);
		o_imm : out std_logic_vector(OUTPUT_BIT_LENGTH-1 downto 0)
	);

end component;



  signal s_signSel	: std_logic := '1';
  signal s_i_imm 	: std_logic_vector(16-1 downto 0);
  signal s_o_imm	: std_logic_vector(32-1 downto 0);
  


begin

  DUT0: sign_ext
  port map(		
		i_signSel	=>  s_signSel,
		i_imm	        =>  s_i_imm,
		o_imm	        =>  s_o_imm
		);


  
  P_TEST_CASES: process
  begin
   

	s_signSel <= '0';
	s_i_imm <= x"0001";

	wait for 50 ns;


	s_signSel <= '1';
	s_i_imm <= x"FFFF";

	wait for 50 ns;


	s_signSel <= '0';
	s_i_imm <= x"8888";

	wait for 50 ns;


	s_signSel <= '1';
	s_i_imm <= x"0000";

	wait for 50 ns;


	s_signSel <= '1';
	s_i_imm <= x"0056";




    wait;



  end process;
end mixed;

