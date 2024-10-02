-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1D.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a dataflow implementation of a 2 to 1 mux.
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1D is

  port(i_D0          : in std_logic;
       i_D1          : in std_logic;
       i_S	     : in std_logic;
       o_O           : out std_logic);

end mux2t1D;

architecture dataflow of mux2t1D is
begin

  o_O <= (i_D0 and (not i_S)) or (i_D1 and i_S);
  
end dataflow;