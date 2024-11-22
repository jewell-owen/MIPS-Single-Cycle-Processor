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


entity hazardDetectionUnit is

  port(
       i_CLK               : in std_logic;
       i_RegWrAddrEXMEM    : in std_logic_vector(4 downto 0);
       i_MemToRegEXMEM     : in std_logic;  -- Should be mem read but we are reusing MemToReg because only lw reads from mem
       i_RegWrAddrIDEX     : in std_logic_vector(4 downto 0);
       i_RegRtAddrIDEX     : in std_logic_vector(4 downto 0);
       i_MemToRegIDEX      : in std_logic;  -- Should be mem read but we are reusing MemToReg because only lw reads from mem
       i_RegRsAddrIFID     : in std_logic_vector(4 downto 0);
       i_RegRtAddrIFID     : in std_logic_vector(4 downto 0);
       i_isBranchIFID      : in std_logic;
       i_isJump            : in std_logic;       
       o_FlushIFID         : out std_logic;
       o_Stall             : out std_logic;
       o_Flush             : out std_logic);

end hazardDetectionUnit;


architecture dataflow of hazardDetectionUnit is


begin

process_label : process( i_CLK ) --i_RegRtAddrIDEX, i_MemToRegIDEX, i_RegRsAddrIFID, i_RegRtAddrIFID

	begin

 if (rising_edge(i_CLK)) then
 
	-- case of lw values not being ready for the next instruction
        if ((i_MemToRegIDEX = '1') and ((i_RegRtAddrIDEX = i_RegRsAddrIFID) or (i_RegRtAddrIDEX = i_RegRtAddrIFID)))
                then o_Flush <= '1';

	-- case of branch values not being ready from the previous instruction
	elsif ((i_isBranchIFID = '1')  and (i_RegWrAddrIDEX /= "00000") and ((i_RegRsAddrIFID = i_RegWrAddrIDEX) or (i_RegRtAddrIFID = i_RegWrAddrIDEX)) )
		then o_Flush <= '1';

	-- case of branch directly follows a lw needing two stalls
	elsif ((i_isBranchIFID = '1') and (i_MemToRegEXMEM = '1') and (i_RegWrAddrEXMEM /= "00000") and ((i_RegRsAddrIFID = i_RegWrAddrEXMEM) or (i_RegRtAddrIFID = i_RegWrAddrEXMEM)))
		then o_Flush <= '1';

	--elsif (i_isJump = '1')
                --then o_FlushIFID <= '1';

        else
                o_Flush <= '0';
	end if;
else 
	o_Flush <= '0';

end if;

 if (rising_edge(i_CLK)) then
 
	--case of flushing the instruction after jump or branch to retrieve target address
        if ((i_MemToRegIDEX = '1') and ((i_RegRtAddrIDEX = i_RegRsAddrIFID) or (i_RegRtAddrIDEX = i_RegRtAddrIFID)))
                then o_FlushIFID <= '0';

	--case of flushing the instruction after jump or branch to retrieve target address
	elsif ((i_isBranchIFID = '1')  and (i_RegWrAddrIDEX /= "00000") and ((i_RegRsAddrIFID = i_RegWrAddrIDEX) or (i_RegRtAddrIFID = i_RegWrAddrIDEX)) )
		then o_FlushIFID <= '0';

	--case of flushing the instruction after jump or branch to retrieve target address
	elsif ((i_isBranchIFID = '1') and (i_MemToRegEXMEM = '1') and (i_RegWrAddrEXMEM /= "00000") and ((i_RegRsAddrIFID = i_RegWrAddrEXMEM) or (i_RegRtAddrIFID = i_RegWrAddrEXMEM)))
		then o_FlushIFID <= '0';

	--case of flushing the instruction after jump or branch to retrieve target address
	elsif (i_isJump = '1')
                then o_FlushIFID <= '1';

        else
                o_FlushIFID <= '0';
	end if;
else 
	o_FlushIFID <= '0';

end if;


 if (falling_edge(i_CLK)) then

	-- case of lw values not being ready for later instructions
        if ((i_MemToRegIDEX = '1') and ((i_RegRtAddrIDEX = i_RegRsAddrIFID) or (i_RegRtAddrIDEX = i_RegRtAddrIFID))) 
                then o_Stall <= '1';

	-- case of branch values not being ready from previous instructions
	elsif ((i_isBranchIFID = '1')  and (i_RegWrAddrIDEX /= "00000") and ((i_RegRsAddrIFID = i_RegWrAddrIDEX) or (i_RegRtAddrIFID = i_RegWrAddrIDEX)) )
		then o_Stall <= '1';
	
	-- case of branch directly follows a lw needing two stalls
	elsif ((i_isBranchIFID = '1') and (i_MemToRegEXMEM = '1') and (i_RegWrAddrEXMEM /= "00000") and ((i_RegRsAddrIFID = i_RegWrAddrEXMEM) or (i_RegRtAddrIFID = i_RegWrAddrEXMEM)))
		then o_Stall <= '1';
        else
               o_Stall <= '0';
	end if;



end if;


end process;









end dataflow;
