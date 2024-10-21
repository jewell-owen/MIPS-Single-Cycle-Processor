-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-- 10/14/2024 by Corey Heithoff
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

  component fetchLogic is
    port(
	i_CLK, i_RST, is_Brch, is_Jump, is_JumpReg, is_zero		: in std_logic;
	i_instr, i_immed, i_rs_data					: in std_logic_vector(31 downto 0);
	o_PC, o_PCfour							: out std_logic_vector(31 downto 0)
	);

  end component;


  component controlUnit is
    port(
	op_Code	    		: in std_logic_vector(5 downto 0);
	Funct		    	: in std_logic_vector(5 downto 0);
	RegDst		    	: out std_logic;
	MemtoReg 	   	: out std_logic;
	MemWrite 	    	: out std_logic;
	ALUSrc 		   	: out std_logic;
	RegWrite 	   	: out std_logic;
	ALUControl	    	: out std_logic_vector(3 downto 0);
	beq 		    	: out std_logic;
 	bne 		    	: out std_logic;
	j  		        : out std_logic;
	jr 		        : out std_logic;
	sltu            	: out std_logic;
	shiftVariable   	: out std_logic;
	upper_immediate 	: out std_logic;
	signSel		 	: out std_logic;
	halt                    : out std_logic
	);
  end component;


  component sign_ext is
  	generic(	
		INPUT_BIT_LENGTH   : integer := 16;
		OUTPUT_BIT_LENGTH  : integer := 32); 

  	port(		
		i_signSel : in std_logic;
		i_imm 	: in std_logic_vector(INPUT_BIT_LENGTH-1 downto 0);
		o_imm 	: out std_logic_vector(OUTPUT_BIT_LENGTH-1 downto 0)
		);
  end component;


  component regFile
  	port(	i_CLK        : in std_logic;     
       		i_RST        : in std_logic; 
       		i_regWrite   : in std_logic;     -- Write Enable    
       		i_rs_sel     : in std_logic_vector(4 downto 0);
       		i_rt_sel     : in std_logic_vector(4 downto 0);
       		i_rd_sel     : in std_logic_vector(4 downto 0);
       		i_rd_D	     : in std_logic_vector(31 downto 0);
       		o_rs_D       : out std_logic_vector(31 downto 0); 
       		o_rt_D	     : out std_logic_vector(31 downto 0)
  		);
  end component;


  component mux2t1_N is
    port(i_S                  : in std_logic;
         i_D0                 : in std_logic_vector(31 downto 0);
         i_D1                 : in std_logic_vector(31 downto 0);
         o_O                  : out std_logic_vector(31 downto 0));
  end component;

  component alu is
    port(i_A			: in std_logic_vector(31 downto 0);
	i_B			: in std_logic_vector(31 downto 0);
	i_BrrlShamt		: in std_logic_vector(4 downto 0);
	i_AluCntrl		: in std_logic_vector(3 downto 0);
	o_Zero			: out std_logic;
	o_C			: out std_logic;
	o_O			: out std_logic;
	o_AluOut		: out std_logic_vector(31 downto 0)
	);
  end component;

  component org2
    port(i_A          : in std_logic;
         i_B          : in std_logic;
         o_F          : out std_logic);
  end component;



  signal s_rs_DA, s_rt_DB, s_imm, s_PCfour, s_aluOut, s_ialuB, s_DMemOrAlu, s_DMemOrAluOrLui, s_RegWrAddrLong				: std_logic_vector(31 downto 0);  
  signal s_is_Jump, s_is_JumpReg, s_is_zero, s_aluCar, s_aluSrc, s_regDst, s_MemtoReg, s_is_Lui, s_signExtSel, s_BrchEq, s_BrchNe, temp, tempt		: std_logic;
  signal s_rs_sel,s_rt_sel    														: std_logic_vector(4 downto 0);
  signal s_aluctr    															: std_logic_vector(3 downto 0);
  



---------------------------------------------------------------------------------------------------------

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 

  g_SIGNEXT: sign_ext port map(
		i_signSel 	=> s_signExtSel,
		i_imm 		=> s_Inst(15 downto 0), 
		o_imm 		=> s_imm 
		);

  g_REGFILE: regFile port map(
		i_CLK        => iCLK, 
       		i_RST        => iRST, 
		i_regWrite   => s_RegWr, 
       		i_rs_sel     => s_Inst(25 downto 21),
       		i_rt_sel     => s_Inst(20 downto 16),
       		i_rd_sel     => s_RegWrAddr, 
       		i_rd_D	     => s_RegWrData, 
       		o_rs_D       => s_rs_DA,
       		o_rt_D	     => s_rt_DB 	--outputs to s_DMemData too
		);

  s_DMemData <= s_rt_DB;

  g_NBITMUX_RegWrAddr: mux2t1_N port map (
		i_S => s_regDst,	
		i_D0(31 downto 5) => "000000000000000000000000000", -- 27 zeros and 5 address bits
		i_D0(4 downto 0) => s_Inst(20 downto 16), 
		i_D1(31 downto 5) => "000000000000000000000000000", -- 27 zeros and 5 address bits
		i_D1(4 downto 0) => s_Inst(15 downto 11), 
		o_O => s_RegWrAddrLong
		);

  s_RegWrAddr <= s_RegWrAddrLong(4 downto 0);

  g_NBITMUX_ALUB: mux2t1_N port map (
		i_S => s_aluSrc,	
		i_D0 => s_rt_DB,   
		i_D1 => s_imm, 
		o_O => s_ialuB
		);

  g_NBITMUX_JumpLink: mux2t1_N port map (
		i_S => s_is_Jump,	
		i_D0 => s_DMemOrAluOrLui,  
		i_D1 => s_PCfour, 
		o_O => s_RegWrData
		);

  g_NBITMUX_MemtoReg: mux2t1_N port map (
		i_S => s_MemtoReg,	
		i_D0 => s_aluOut,   
		i_D1 => s_DMemOut, 
		o_O => s_DMemOrAlu
		);

  g_NBITMUX_Lui: mux2t1_N port map (
		i_S => s_is_Lui,	
		i_D0 => s_DMemOrAlu,   
		i_D1(31 downto 16) => s_Inst(15 downto 0), -- Lui: upper 16 bits is immediate value and lower 16 bits is filled with zeros
		i_D1(15 downto 0) => x"0000",
		o_O => s_DMemOrAluOrLui
		);

  g_FETCHLOGIC : fetchLogic port map(
		i_CLK       	=> iCLK, 
       		i_RST       	=> iRST, 
		is_Brch  	=> s_BrchEq OR s_BrchNe,
		is_Jump  	=> s_is_Jump,
		is_JumpReg  	=> s_is_JumpReg,
		is_zero  	=> s_is_zero,
		i_instr    	=> s_Inst, 
		i_immed    	=> s_imm, 
		i_rs_data    	=> s_rs_DA, 
		o_PC		=> s_NextInstAddr, 
		o_PCfour	=> s_PCfour 
		);

  g_CONTRUNIT : controlUnit port map(
		op_Code	    		=> s_Inst(31 downto 26),	
		Funct		    	=> s_Inst(5 downto 0),	
		RegDst		    	=> s_regDst,	
		MemtoReg 	   	=> s_MemtoReg,	
		MemWrite 	    	=> s_DMemWr,	
		ALUSrc 		   	=> s_aluSrc,	
		RegWrite 	   	=> s_RegWr,
		ALUControl	    	=> s_aluctr,	
		beq 		    	=> s_BrchEq,	-- only need one branch control so they are ORed
 		bne 		    	=> s_BrchNe,	
		j  		        => s_is_Jump,	-- used to j and jal control
		jr 		        => s_is_JumpReg,	
		sltu            	=> temp,	-- not needed?
		shiftVariable   	=> tempt,	-- not needed?
		upper_immediate 	=> s_is_Lui,	
		signSel 		=> s_signExtSel,
		halt                    => s_Halt	
		);

  g_ALU : alu port map(
		i_A			=> s_rs_DA,
		i_B			=> s_ialuB,
		i_BrrlShamt		=> s_Inst(10 downto 6),
		i_AluCntrl		=> s_aluctr,
		o_Zero			=> s_is_zero,
		o_C			=> s_aluCar,
		o_O			=> s_Ovfl,
		o_AluOut		=> s_aluOut 	--outputs to s_DMemData too
		);

 oALUOut <= s_aluOut;




end structure;

