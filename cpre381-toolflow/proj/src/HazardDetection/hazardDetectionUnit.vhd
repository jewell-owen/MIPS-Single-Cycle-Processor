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

  port(i_RegRdAddrMEMWB    : in std_logic_vector(4 downto 0);
       i_RegWriteMEMWB     : in std_logic;
       i_RegRdAddrEXMEM    : in std_logic_vector(4 downto 0);
       i_RegWriteEXMEM     : in std_logic;
       i_RegRsAddrIDEX     : in std_logic_vector(4 downto 0);
       i_RegRtAddrIDEX     : in std_logic_vector(4 downto 0);
       i_MemToRegIDEX      : in std_logic;  -- Should be mem read but we are reusing MemToReg because only lw reads from mem
       i_RegRsAddrIFID     : in std_logic_vector(4 downto 0);
       i_RegRtAddrIFID     : in std_logic_vector(4 downto 0);
       o_Stall             : out std_logic;
       o_Flush             : out std_logic;
       o_forwardA          : out std_logic_vector(1 downto 0);
       o_forwardB          : out std_logic_vector(1 downto 0));

end hazardDetectionUnit;


architecture dataflow of hazardDetectionUnit is

signal s_Out : std_logic;

begin

process_label : process(i_RegRdAddrMEMWB, i_RegWriteMEMWB, i_RegRdAddrEXMEM, i_RegWriteEXMEM, i_RegRsAddrIDEX, i_RegRtAddrIDEX, i_MemToRegIDEX, i_RegRsAddrIFID, i_RegRtAddrIFID )

	begin

-------------------Forwarding A Logic ----------------------------------------------------------
	if ((i_RegWriteEXMEM = '1') and (i_RegRdAddrEXMEM = i_RegRsAddrIDEX) and (i_RegRdAddrEXMEM /= "00000"))
		then o_forwardA <= "10";

	elsif ((i_RegWriteMEMWB = '1') and (i_RegRdAddrMEMWB /= "00000") and  not ((i_RegWriteEXMEM = '1') and (i_RegRdAddrEXMEM /= "00000") and (i_RegRdAddrEXMEM = i_RegRsAddrIDEX)) and (i_RegRdAddrMEMWB = i_RegRsAddrIDEX)) 
		then o_forwardA <= "01";

	else
		o_forwardA <= "00";
	end if;
-------------------Forwarding A Logic ----------------------------------------------------------



-------------------Forwarding B Logic ----------------------------------------------------------
	if ((i_RegWriteEXMEM = '1') and (i_RegRdAddrEXMEM = i_RegRtAddrIDEX) and (i_RegRdAddrEXMEM /= "00000"))
		then o_forwardB <= "10";

	elsif ((i_RegWriteMEMWB = '1') and (i_RegRdAddrMEMWB /= "00000") and not ((i_RegWriteEXMEM = '1') and (i_RegRdAddrEXMEM /= "00000") and (i_RegRdAddrEXMEM = i_RegRtAddrIDEX)) and (i_RegRdAddrMEMWB = i_RegRtAddrIDEX)) 
		then o_forwardB <= "01";

	else
		o_forwardB <= "00";
	end if;
-------------------Forwarding B Logic ----------------------------------------------------------

        if ((i_MemToRegIDEX = '1') and ((i_RegRtAddrIDEX = i_RegRsAddrIFID) or (i_RegRtAddrIDEX = i_RegRtAddrIFID)))
                then s_Out <= '1';
        else
                s_Out <= '0';
	end if;

o_Flush <= s_Out;
o_Stall <= s_Out;

end process;









end dataflow;
