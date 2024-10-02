-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_dataflow.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2:1
-- mux using dataflow VHDL.
--
--
-- NOTES:
-- Created 9/3/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_dataflow is

  port(i_S          : in std_logic;
       i_D0         : in std_logic;
       i_D1         : in std_logic;
       o_O          : out std_logic);

end mux2t1_dataflow;


architecture dataflow of mux2t1_dataflow is
begin

  o_O <= i_D1 when (i_S = '1') else
         i_D0 when (i_S = '0') else
	 '0';

end dataflow;
