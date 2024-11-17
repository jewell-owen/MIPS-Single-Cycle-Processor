-------------------------------------------------------------------------
-- Owen Jewell
-- CprE 381
-- Iowa State University
-------------------------------------------------------------------------


-- hazardDetectionUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of the 
-- forwarding unit
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--https://stackoverflow.com/questions/59782631/type-error-resolving-infix-expression-or-as-type-std-standard-boolean

entity hazardDetectionUnit is

  port(i_RegRdAddrMEMWB    : in std_logic;
       i_RegWriteMEMWB     : in std_logic;
       i_RegRdAddrEXMEM    : in std_logic;
       i_RegWriteEXMEM     : in std_logic;
       i_RegRsAddrIDEX     : in std_logic;
       i_RegRtAddrIDEX     : in std_logic;
       i_MemToRegIDEX      : in std_logic;  -- Should be mem read but we are reusing MemToReg because only lw reads from mem
       i_RegRsAddrIFID     : in std_logic;
       i_RegRtAddrIFID     : in std_logic;
       o_Stall             : out std_logic;
       o_forwardA          : out std_logic_vector(1 downto 0);
       o_forwardB          : out std_logic_vector(1 downto 0));

end hazardDetectionUnit;


architecture dataflow of hazardDetectionUnit is

begin

process is
	begin

-------------------Forwarding A Logic ----------------------------------------------------------
	if ((i_RegWriteEXMEM = '1') and (i_RegRdAddrEXMEM = i_RegRsAddrIDEX)) 
		then o_forwardA <= "10";

	elsif ((i_RegWriteMEMWB = '1') and (i_RegRdAddrMEMWB = '1') and (i_RegWriteEXMEM = '1') and (i_RegRdAddrEXMEM = '1') and (i_RegRdAddrEXMEM = i_RegRsAddrIDEX) and (i_RegRdAddrMEMWB = i_RegRsAddrIDEX)) 
		then o_forwardA <= "01";

	else
		o_forwardA <= "00";
	end if;
-------------------Forwarding A Logic ----------------------------------------------------------



-------------------Forwarding B Logic ----------------------------------------------------------
	if ((i_RegWriteEXMEM = '1') and (i_RegRdAddrEXMEM = i_RegRtAddrIDEX)) 
		then o_forwardB <= "10";

	elsif ((i_RegWriteMEMWB = '1') and (i_RegRdAddrMEMWB = '1') and (i_RegWriteEXMEM = '1') and (i_RegRdAddrEXMEM = '1') and (i_RegRdAddrEXMEM = i_RegRtAddrIDEX) and (i_RegRdAddrMEMWB = i_RegRtAddrIDEX)) 
		then o_forwardB <= "01";

	else
		o_forwardB <= "00";
	end if;
-------------------Forwarding B Logic ----------------------------------------------------------

        if ((i_MemToRegIDEX = '1') and ((i_RegRtAddrIDEX = i_RegRsAddrIFID) or (i_RegRtAddrIDEX = i_RegRtAddrIFID)))
                then o_Stall <= '1';
        else
                o_Stall <= '0';
	end if;

end process;









end dataflow;
