-------------------------------------------------------------------------
-- Corey Heithoff
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux32t1_new.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32:1 mux
--
--
-- NOTES:
-- Created 9/11/24
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity mux32t1_new is

	port(
		i_S : in integer range 0 to 31;
		i_D : in array_logic_vector(0 to 31)(31 downto 0);
		o_F : out std_logic_vector(31 downto 0)
	);
end entity mux32t1_new;

architecture mux_arch of mux32t1_new is

begin

o_F <= i_D(i_S);

end mux_arch;
