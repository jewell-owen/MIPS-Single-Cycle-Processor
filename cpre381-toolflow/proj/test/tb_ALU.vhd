-------------------------------------------------------------------------
-- Jason Di Giovanni
-- Iowa State University
-------------------------------------------------------------------------

-- tb_ALU.vhd

-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- updated ALU
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ALU is
  generic(gCLK_HPER   : time := 50 ns);
end tb_ALU;

architecture behavior of tb_ALU is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer :=32;


component ALU is
	generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
   		port(A          : in std_logic;
		B               : in std_logic;
		ALUOP           : in std_logic;
        	F               : out std_logic;
		Carryout	: out std_logic;
		Overflow	: out std_logic;
		Zero		: out std_logic);
end component;

signal A, B, ALUOP, F, Carryout, Overflow, Zero	: std_logic;

begin
DUT0: ALU
	port map(A		=> A,
		B		=> B,
		ALUOP		=> ALUOP,
		F		=> F,	
		Carryout	=> Carryout,
		Overflow	=> Overflow,
		Zero		=> Zero);

P_TB: process

end behavior;