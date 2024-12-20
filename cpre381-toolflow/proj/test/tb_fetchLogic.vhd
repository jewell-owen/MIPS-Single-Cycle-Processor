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

entity tb_fetchLogic is
  generic(gCLK_HPER   : time := 50 ns);
end tb_fetchLogic;

architecture behavior of tb_fetchLogic is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer :=32;

component fetchLogic is
   port(i_CLK, i_RST, is_Brch, is_Jump, is_JumpReg, is_zero		: in std_logic;
	i_instr, i_immed, i_rs_data					: in std_logic_vector(31 downto 0);
	o_PC								: out std_logic_vector(31 downto 0)
	);

end component;



signal s_instr, s_immed, s_rs_data, so_PC          			: std_logic_vector(31 downto 0);  
signal CLK, reset, s_is_Brch, s_is_Jump, s_is_JumpReg, s_is_zero 	: std_logic;

begin 

g_FETCHLOGIC : fetchLogic port map(
		i_CLK       	=> CLK,
       		i_RST       	=> reset,
		is_Brch  	=> s_is_Brch,
		is_Jump  	=> s_is_Jump,
		is_JumpReg  	=> s_is_JumpReg,
		is_zero  	=> s_is_zero,
		i_instr    	=> s_instr,
		i_immed    	=> s_immed,
		i_rs_data    	=> s_rs_data,
		o_PC		=> so_PC
		);


P_CLK: process
  begin
    CLK <= '0';
    wait for gCLK_HPER;
    CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
-- Testbench process  
P_TB: process
begin

---------------------------------Initialization------------------------------------------------------------

s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

reset <= '1';
wait for gCLK_HPER*2;
reset <= '0';
wait for gCLK_HPER/2;

---------------------------------regular fetch logic------------------------------------------------------------

-- Case 1: PC = 0x00000000    (normal PC + 4)    Expected: 0x00000004
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;

-- Case 2: PC = 0x00000004    (normal PC + 4)    Expected: 0x00000008
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;

-- Case 3: PC = 0x00000008    (normal PC + 4)    Expected: 0x0000000C
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;

-- Case 4: PC = 0x0000000C    (normal PC + 4)    Expected: 0x00000010
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;

---------------------------------branch fetch logic------------------------------------------------------------

-- Case 5: PC = 0x00000010    (Branch offset = 0x00020000)    Expected: 0x00080014
s_is_Brch		<= '1';
s_is_zero		<= '1';
s_immed			<= x"00020000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;

-- Case 6: PC = 0x00080014    (normal PC + 4)    Expected: 0x00080018
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;

---------------------------------jump fetch logic------------------------------------------------------------

-- Case 7: PC = 0x00080018    (jump address = 0x00300004)    Expected: 0x00C00010
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '1';
s_instr			<= x"00300004";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;

-- Case 8: PC = 0x00C00010    (normal PC + 4)    Expected: 0x00C00014
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;

---------------------------------jump register fetch logic------------------------------------------------------------

-- Case 9: PC = 0x00C00014    (jump register = 0x2020FF50)    Expected: 0x2020FF50
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '1';
s_rs_data		<= x"2020FF50";

wait for cCLK_PER;

-- Case 10: PC = 0x2020FF50    (normal PC + 4)    Expected: 0x2020FF54
s_is_Brch		<= '0';
s_is_zero		<= '0';
s_immed			<= x"00000000";

s_is_Jump		<= '0';
s_instr			<= x"00000000";

s_is_JumpReg		<= '0';
s_rs_data		<= x"00000000";

wait for cCLK_PER;





 
wait;
end process;
  
end behavior;



