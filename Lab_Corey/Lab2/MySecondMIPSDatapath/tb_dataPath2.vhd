-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_dataPath2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the datapath 2.
--              
-- Created 9/26/24.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std_unsigned.all;
use IEEE.std_logic_textio.all;  
library std;
use std.env.all;                
use std.textio.all;     

library work;
use work.array_type.all;        


entity tb_dataPath2 is 
  generic(gCLK_HPER   : time := 10 ns);
end tb_dataPath2;


architecture mixed of tb_dataPath2 is

constant cCLK_PER  : time := gCLK_HPER * 2;


component dataPath2

  generic(VALUE32 : integer := 32;
	  VALUE16 : integer := 16
	); 
  port(i_CLK        : in std_logic;    
       i_RST        : in std_logic;     
       i_regWrite   : in std_logic;     -- Write Enable for registers
       i_rs_sel     : in std_logic_vector(4 downto 0);
       i_rt_sel     : in std_logic_vector(4 downto 0);
       i_rd_sel     : in std_logic_vector(4 downto 0);

       i_nAdd_Sub     : in std_logic;
       i_ALUSrc       : in std_logic;
       o_Car          : out std_logic;

	i_signSel 	: in std_logic;
	i_imm 		: in std_logic_vector(VALUE16-1 downto 0);

	i_mem_we	: in std_logic; -- Write Enable for memory
	i_mem2reg	: in std_logic
  	);
end component;

  signal CLK, reset, regWrite   : std_logic := '0';
  signal s_rs_sel     : std_logic_vector(4 downto 0);
  signal s_rt_sel     : std_logic_vector(4 downto 0);
  signal s_rd_sel     : std_logic_vector(4 downto 0);

  signal s_nAdd_Sub   : std_logic := '0';
  signal s_ALUSrc     : std_logic := '0';
  --signal s_immed    : std_logic_vector(32-1 downto 0) := x"00000000";
  signal s_oCar       : std_logic;

  signal s_signSel   : std_logic := '0';
  signal s_imm       : std_logic_vector(16-1 downto 0) := x"0000";

  signal s_mem_we    : std_logic := '0';
  signal s_mem2reg   : std_logic := '0';


begin

  DUT0: dataPath2
  port map(
		i_CLK       => CLK,
       		i_RST       => reset,
		i_regWrite  => regWrite,
       		i_rs_sel    => s_rs_sel,
       		i_rt_sel    => s_rt_sel,
       		i_rd_sel    => s_rd_sel,
		i_nAdd_Sub     => s_nAdd_Sub,
	    	i_ALUSrc       => s_ALUSrc,
	    	--i_immed        => s_immed,
            	o_Car          => s_oCar,
		i_signSel 	=> s_signSel,	
		i_imm 		=> s_imm,	
		i_mem_we	=> s_mem_we,	
		i_mem2reg	=> s_mem2reg	
		);


  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  --P_RST: process
  --begin
  --	reset <= '0';   
  --  wait for gCLK_HPER/2;
	--reset <= '1';
  --  wait for gCLK_HPER*2;
	--reset <= '0';
	--wait;
  --end process;  
 
  
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2;
    
reset <= '1';
wait for gCLK_HPER*2;
reset <= '0';
    
--addi $25, $0, 0
    s_rs_sel      <= "00000"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "11001"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--addi $26, $0, 256
    s_rs_sel      <= "00000"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "11010"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0040";	-- ********************** changed from 256 = 0x0100 into 64 because ram is word addressable

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--lw $1, 0($25)
    s_rs_sel      <= "11001"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "00001"; 	-- distination 
				--*********************** MIPS Green Sheet says destination for lw is defined by RT addr, but 
				-- datapath decoder (controls all writing) only takes input from RD addr, so I put the destination in RD
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '0';
    s_mem2reg     <= '1';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--lw $2, 4($25)
    s_rs_sel      <= "11001"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "00010"; 	-- distination
				--*********************** MIPS Green Sheet says destination for lw is defined by RT addr, but 
				-- datapath decoder (controls all writing) only takes input from RD addr, so I put the destination in RD
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0001";  -- ********************** changed from 4 = 0x0004 into 1 because ram is word addressable

    s_mem_we      <= '0';
    s_mem2reg     <= '1';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--add $1, $1, $2
    s_rs_sel      <= "00001"; 	-- A or rs
    s_rt_sel 	  <= "00010"; 	-- B or rt
    s_rd_sel      <= "00001"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '0';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--sw $1, 0($26)
    s_rs_sel      <= "11010"; 	-- A or rs
    s_rt_sel 	  <= "00001"; 	-- B or rt
    s_rd_sel      <= "00000"; 	-- distination
    regWrite	  <= '0';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '1';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

------------------------------------------------------------------------- Done with first 6 instruction: Next is lw $2, 8($25)

--lw $2, 8($25)
    s_rs_sel      <= "11001"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "00010"; 	-- distination
				--*********************** MIPS Green Sheet says destination for lw is defined by RT addr, but 
				-- datapath decoder (controls all writing) only takes input from RD addr, so I put the destination in RD
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0002";   -- ********************** changed from 8 = 0x0008 into 2 because ram is word addressable

    s_mem_we      <= '0';
    s_mem2reg     <= '1';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--add $1, $1, $2
    s_rs_sel      <= "00001"; 	-- A or rs
    s_rt_sel 	  <= "00010"; 	-- B or rt
    s_rd_sel      <= "00001"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '0';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--sw $1, 4($26)
    s_rs_sel      <= "11010"; 	-- A or rs
    s_rt_sel 	  <= "00001"; 	-- B or rt
    s_rd_sel      <= "00000"; 	-- distination
    regWrite	  <= '0';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0001";   -- ********************** changed from 4 = 0x0004 into 1 because ram is word addressable

    s_mem_we      <= '1';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

----------------------------------------------------------------------- ^^^^^^ lw, add, sw group 1

--lw $2, 12($25)
    s_rs_sel      <= "11001"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "00010"; 	-- distination
				--*********************** MIPS Green Sheet says destination for lw is defined by RT addr, but 
				-- datapath decoder (controls all writing) only takes input from RD addr, so I put the destination in RD
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0003";   -- ********************** changed from 12 = 0x000C into 3 because ram is word addressable

    s_mem_we      <= '0';
    s_mem2reg     <= '1';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--add $1, $1, $2
    s_rs_sel      <= "00001"; 	-- A or rs
    s_rt_sel 	  <= "00010"; 	-- B or rt
    s_rd_sel      <= "00001"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '0';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--sw $1, 8($26)
    s_rs_sel      <= "11010"; 	-- A or rs
    s_rt_sel 	  <= "00001"; 	-- B or rt
    s_rd_sel      <= "00000"; 	-- distination
    regWrite	  <= '0';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0002";   -- ********************** changed from 8 = 0x0008 into 2 because ram is word addressable

    s_mem_we      <= '1';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

----------------------------------------------------------------------- ^^^^^^ lw, add, sw group 2

--lw $2, 16($25)
    s_rs_sel      <= "11001"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "00010"; 	-- distination
				--*********************** MIPS Green Sheet says destination for lw is defined by RT addr, but 
				-- datapath decoder (controls all writing) only takes input from RD addr, so I put the destination in RD
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0004";   -- ********************** changed from 16 = 0x0010 into 4 because ram is word addressable

    s_mem_we      <= '0';
    s_mem2reg     <= '1';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--add $1, $1, $2
    s_rs_sel      <= "00001"; 	-- A or rs
    s_rt_sel 	  <= "00010"; 	-- B or rt
    s_rd_sel      <= "00001"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '0';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--sw $1, 12($26)
    s_rs_sel      <= "11010"; 	-- A or rs
    s_rt_sel 	  <= "00001"; 	-- B or rt
    s_rd_sel      <= "00000"; 	-- distination
    regWrite	  <= '0';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0003";   -- ********************** changed from 12 = 0x000C into 3 because ram is word addressable

    s_mem_we      <= '1';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

----------------------------------------------------------------------- ^^^^^^ lw, add, sw group 3

--lw $2, 20($25)
    s_rs_sel      <= "11001"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "00010"; 	-- distination
				--*********************** MIPS Green Sheet says destination for lw is defined by RT addr, but 
				-- datapath decoder (controls all writing) only takes input from RD addr, so I put the destination in RD
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0005";   -- ********************** changed from 20 = 0x0014 into 5 because ram is word addressable

    s_mem_we      <= '0';
    s_mem2reg     <= '1';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--add $1, $1, $2
    s_rs_sel      <= "00001"; 	-- A or rs
    s_rt_sel 	  <= "00010"; 	-- B or rt
    s_rd_sel      <= "00001"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '0';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--sw $1, 16($26)
    s_rs_sel      <= "11010"; 	-- A or rs
    s_rt_sel 	  <= "00001"; 	-- B or rt
    s_rd_sel      <= "00000"; 	-- distination
    regWrite	  <= '0';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0004";   -- ********************** changed from 16 = 0x0010 into 4 because ram is word addressable

    s_mem_we      <= '1';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

----------------------------------------------------------------------- ^^^^^^ lw, add, sw group 4 (last)

--lw $2, 24($25)
    s_rs_sel      <= "11001"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "00010"; 	-- distination
				--*********************** MIPS Green Sheet says destination for lw is defined by RT addr, but 
				-- datapath decoder (controls all writing) only takes input from RD addr, so I put the destination in RD
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0006";   -- ********************** changed from 24 = 0x0018 into 6 because ram is word addressable

    s_mem_we      <= '0';
    s_mem2reg     <= '1';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--add $1, $1, $2
    s_rs_sel      <= "00001"; 	-- A or rs
    s_rt_sel 	  <= "00010"; 	-- B or rt
    s_rd_sel      <= "00001"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '0';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0000";

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--addi $21, $0, 512
    s_rs_sel      <= "00000"; 	-- A or rs
    s_rt_sel 	  <= "00000"; 	-- B or rt
    s_rd_sel      <= "11011"; 	-- distination
    regWrite	  <= '1';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '0';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"0080";   -- ********************** changed from 512 = 0x0200 into 128 because ram is word addressable

    s_mem_we      <= '0';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

--sw $1, -4($27)
    s_rs_sel      <= "11011"; 	-- A or rs
    s_rt_sel 	  <= "00001"; 	-- B or rt
    s_rd_sel      <= "00000"; 	-- distination
    regWrite	  <= '0';  

    s_nAdd_Sub    <= '0';  	-- 0 for ADD &  1 for SUB
    s_ALUSrc      <= '1';  	-- 0 for B   &  1 for Imm

    s_signSel     <= '1';  	-- 0 for 0s  &  1 for 1s
    s_imm         <= x"FFFF";   -- ********************** changed from -4 = 0x0100 into -1 because ram is word addressable
	
    s_mem_we      <= '1';
    s_mem2reg     <= '0';  	-- 0 for SUM &  1 for MEM

    wait for gCLK_HPER*2;

----------------------------------------------------------------------- ^^^^^^ lw, add, addi, sw group at end

	wait;


  end process;
end mixed;

