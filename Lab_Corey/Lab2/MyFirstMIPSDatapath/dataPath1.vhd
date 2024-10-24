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

entity dataPath1 is

  generic(N : integer := 32); 
  port(i_CLK        : in std_logic;    
       i_RST        : in std_logic;     
       i_regWrite   : in std_logic;     -- Write Enable
       i_rs_sel     : in std_logic_vector(4 downto 0);
       i_rt_sel     : in std_logic_vector(4 downto 0);
       i_rd_sel     : in std_logic_vector(4 downto 0);
       --i_rd_D	    : in std_logic_vector(31 downto 0);
       --o_rs_D       : out std_logic_vector(31 downto 0); 
       --o_rt_D	    : out std_logic_vector(31 downto 0);

       i_nAdd_Sub     : in std_logic;
       i_ALUSrc       : in std_logic;
       i_immed        : in std_logic_vector(N-1 downto 0);
       --i_DA           : in std_logic_vector(N-1 downto 0);
       --i_DB           : in std_logic_vector(N-1 downto 0);
       --o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Car          : out std_logic
  );

end dataPath1;

architecture structure of dataPath1 is

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

  signal s_Sum  : std_logic_vector(31 downto 0);
  signal s_rs_DA : std_logic_vector(31 downto 0); 
  signal s_rt_DB : std_logic_vector(31 downto 0); 

  
begin

  g_ADDSUBN: addSub_N port map(	
		i_nAdd_Sub     => i_nAdd_Sub,
       		i_ALUSrc       => i_ALUSrc,
       		i_immed        => i_immed,
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
       		i_rd_D	     => s_Sum,
       		o_rs_D       => s_rs_DA,
       		o_rt_D	     => s_rt_DB 
		);


end structure;
