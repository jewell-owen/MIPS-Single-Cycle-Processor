-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- dataPath.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a MIPS datapath.
--
--
-- NOTES:
-- Created 9/22/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std_unsigned.all;
use IEEE.numeric_std.all;

library work;
use work.array_type.all;

entity dataPath2 is

  generic(VALUE32 : integer := 32;
	  VALUE16 : integer := 16
	); 
  port(i_CLK        : in std_logic;    
       i_RST        : in std_logic;     
       i_regWrite   : in std_logic;     -- Write Enable
       i_rs_sel     : in std_logic_vector(4 downto 0);
       i_rt_sel     : in std_logic_vector(4 downto 0);
       i_rd_sel     : in std_logic_vector(4 downto 0);

       i_nAdd_Sub     : in std_logic;
       i_ALUSrc       : in std_logic;
       o_Car          : out std_logic;

	i_signSel 	: in std_logic;
	i_imm 		: in std_logic_vector(VALUE16-1 downto 0);

	i_mem_we	: in std_logic;
	i_mem2reg	: in std_logic
  );

end dataPath2;

architecture structure of dataPath2 is

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


  component addSub_N
  	generic(N : integer := 32); 
  	port(	i_nAdd_Sub     : in std_logic;
       		i_ALUSrc       : in std_logic;
       		i_immed        : in std_logic_vector(N-1 downto 0);
       		i_DA           : in std_logic_vector(N-1 downto 0);
       		i_DB           : in std_logic_vector(N-1 downto 0);
       		o_Sum          : out std_logic_vector(N-1 downto 0);
       		o_Car          : out std_logic
		);
  end component;


  component mem
	generic (
		DATA_WIDTH : natural := 32;--8
		ADDR_WIDTH : natural := 10--12
		);
	port (
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
		);
  end component;


  component sign_ext
  	generic(	
		INPUT_BIT_LENGTH   : integer := 16;
		OUTPUT_BIT_LENGTH  : integer := 32); 

  	port(		
		i_signSel : in std_logic;
		i_imm 	: in std_logic_vector(INPUT_BIT_LENGTH-1 downto 0);
		o_imm 	: out std_logic_vector(OUTPUT_BIT_LENGTH-1 downto 0)
		);
  end component;

  -- N-bit 2:1 Mux
  component mux2t1_N
    generic(N : integer := 32); 
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));
  end component;



  signal s_Sum   : std_logic_vector(31 downto 0);
  signal s_rs_DA : std_logic_vector(31 downto 0); 
  signal s_rt_DB : std_logic_vector(31 downto 0); 
  signal s_imm   : std_logic_vector(31 downto 0); 
  signal s_mem_q : std_logic_vector(31 downto 0); 
  signal s_regf_in_D : std_logic_vector(31 downto 0); 

  
begin

  g_ADDSUBN: addSub_N port map(	
		i_nAdd_Sub     => i_nAdd_Sub,
       		i_ALUSrc       => i_ALUSrc,
       		i_immed        => s_imm,--s_imm
       		i_DA           => s_rs_DA,
       		i_DB           => s_rt_DB,
       		o_Sum          => s_Sum,
       		o_Car          => o_Car
		);


  g_REGFILE: regFile port map(
		i_CLK        => i_CLK,
       		i_RST        => i_RST,
		i_regWrite   => i_regWrite,
       		i_rs_sel     => i_rs_sel,
       		i_rt_sel     => i_rt_sel,
       		i_rd_sel     => i_rd_sel,
       		i_rd_D	     => s_regf_in_D,--s_regf_in_D
       		o_rs_D       => s_rs_DA,
       		o_rt_D	     => s_rt_DB 
		);


  g_SIGNEXT: sign_ext port map(
		i_signSel 	=> i_signSel,
		i_imm 		=> i_imm, 
		o_imm 		=> s_imm 
		);


  g_MEM: mem port map(
		clk		=> i_CLK, 
		addr	        => s_Sum(9 downto 0), 
		data	        => s_rt_DB, 
		we		=> i_mem_we, 
		q		=> s_mem_q 
		);

  g_NbitMux: mux2t1_N port map (
		i_S  	=> i_mem2reg,
		i_D0 	=> s_Sum,   -- take sum of adder when sel = 0
		i_D1 	=> s_mem_q, -- take output of memory when sel = 1
		o_O 	=> s_regf_in_D
		);



end structure;
