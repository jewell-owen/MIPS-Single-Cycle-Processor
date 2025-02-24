-------------------------------------------------------------------------
-- Luca Cano
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- ControlUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contain a Control  
-- implementation.
-------------------------------------------------------------------------

-- Over the weekend will finish the implementation according to the CPRE 381 Project 1 Schematics
-- Specifically will focus on the input implemtation with the instruction memory module. 


library IEEE;
use IEEE.std_logic_1164.all;

entity controlUnit is
  port(op_Code	    		: in std_logic_vector(5 downto 0);
	Funct		    	: in std_logic_vector(5 downto 0);
	RegDst		    	: out std_logic;
	MemtoReg 	   	: out std_logic;
	MemWrite 	    	: out std_logic;
	ALUSrc 		   	: out std_logic;
	RegWrite 	   	: out std_logic;
	UnsignedNoOverflow	: out std_logic;
	ALUControl	    	: out std_logic_vector(3 downto 0);
	beq 		    	: out std_logic;
 	bne 		    	: out std_logic;
	j  		        : out std_logic;
	jr 		        : out std_logic;
	sltu            	: out std_logic;
	shiftVariable   	: out std_logic;
	upper_immediate 	: out std_logic;
	signSel		 	: out std_logic;
	halt                    : out std_logic);



end controlUnit;

architecture behavioral of controlUnit is
signal opCode                   : std_logic_vector(5 downto 0);
signal	functCode	: std_logic_vector(5 downto 0);
signal	code		: std_logic_vector(5 downto 0);
signal	R_type		: std_logic := '0';
signal s_halt                   : std_logic := '0';

begin
	opCode <= op_Code;
	functCode <= funct;
	code <= functCode	when(opCode = "000000")else
	        opCode;
	R_type <= '1'		when(opCode = "000000")else
	        '0';

	p_whichInstr : process(code, R_type) is
	begin
			--recognizing op code then basing what instruction it goes off of the function code
			
				--Instruction -> "NOOP"
				if(code = "111111") then
					RegDst          <= '0';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '0';
					MemWrite        <= '0';
					ALUControl      <= "0000";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
					shiftVariable   <= '0';
					signSel	        <= '1';
					upper_immediate <= '0';
					UnsignedNoOverflow <= '1';
                		
				--Instruction -> "add"
				elsif (code = "100000") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0010";
					--These apply to all
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '0';


				--Instruction -> "addu"
				elsif (code = "100001") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0010";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';
				
				--Instruction -> "and"
				elsif (code = "100100") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "1110";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "nor"
				elsif (code = "100111") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0000";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "xor"
				elsif (code = "100110") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0100";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "or"
				elsif (code = "100101") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0001";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';
	
				--Instruction -> "slt"
				elsif (code = "101010") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0111";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "sltu"
				elsif (code = "101011" and R_type= '1') then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0111";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '1';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "sll"
				elsif (code = "000000" and R_type = '1') then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "1101";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "srl"
				elsif (code = "000010" and R_type = '1') then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "1001";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "sra"
				elsif (code = "000011" and R_type = '1') then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "1000";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "sllv"
				elsif (code = "000100" and R_type = '1') then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "XXXX";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '1';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "srlv"
				elsif (code = "000110") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "XXXX";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '1';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';
				
				--Instruction -> "srav"
				elsif (code = "000111") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "XXXX";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '1';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';
		
				--Instruction -> "sub"	
				elsif (code = "100010") then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0011";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '0';
				
				--Instruction -> "subu"
				elsif (code = "100011" and R_type = '1') then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '1';
					MemWrite        <= '0';
					ALUControl      <= "0011";
					beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '0';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

				--Instruction -> "jr" //jump and register
				elsif(code = "001000"and R_type='1') then
					RegDst          <= '1';
					ALUSrc          <= '0';
					MemtoReg        <= '0';
					RegWrite        <= '0';
					MemWrite        <= '0';
					ALUControl      <= "XXXX";
                    			beq             <= '0';
					bne             <= '0';
					j               <= '0';
					jr              <= '1';
					sltu            <= '0';
                    			shiftVariable   <= '0';
					signSel	        <= '1';
                    			upper_immediate <= '0';
					UnsignedNoOverflow <= '1';

			--Immediate instructions
			--Instruction -> "addi"
			elsif (code = "001000" and R_type='0') then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "0010";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '0';

			--Instruction -> "addiu"
			elsif (code = "001001") then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "0010";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';


			--Instruction -> "andi"
			elsif (code = "001100") then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "1110";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '0';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';


			--Instruction -> "lui"
			elsif (code = "001111") then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "1001";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '1';
				UnsignedNoOverflow <= '1';


			--Instruction -> "xori"
			elsif (code = "001110") then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "0100";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '0';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';


			--Instruction -> "ori"
			elsif (code = "001101") then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "0001";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '0';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';

			
			--Instruction -> "slti"
		 	elsif (code = "001010") then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "0111";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';


			--Instruction -> "sltiu"
			elsif (code = "001011") then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "0111";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '1';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';


			--Load and Store Instructions
			--Instruction -> "lw"
			elsif (code = "100011" and R_type = '0') then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '1';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "0010";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';


			--Instruction -> "sw"
			elsif (code = "101011" and R_type = '0') then
				RegDst          <= '0';
				ALUSrc          <= '1';
				MemtoReg        <= '0';
				RegWrite        <= '0';
				MemWrite        <= '1';
				ALUControl      <= "0010";
				beq             <= '0';
                		bne             <= '0';
                		j               <= '0';
                		jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';


			--Branch Instructions
			--Instruction -> "beq"
			elsif (code = "000100"  and R_type = '0') then
				RegDst          <= '0';
				ALUSrc          <= '0';
				MemtoReg        <= '0';
				RegWrite        <= '0';
				MemWrite        <= '0';
				ALUControl      <= "1010";
				beq             <= '1';
				bne             <= '0';
				j               <= '0';
				jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';


			--Instruction -> "bne"
			elsif (code = "000101") then
				RegDst          <= '0';
				ALUSrc          <= '0';
				MemtoReg        <= '0';
				RegWrite        <= '0';
				MemWrite        <= '0';
				ALUControl      <= "1011";
				beq             <= '0';
                		bne             <= '1';
				j               <= '0';
				jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';

			--Instruction -> "j"
			elsif (code = "000010" and R_type = '0') then
				RegDst          <= '0';
				ALUSrc          <= '0';
				MemtoReg        <= '0';
				RegWrite        <= '0';
				MemWrite        <= '0';
				ALUControl      <= "XXXX";
				beq             <= '0';
				bne             <= '0';
				j               <= '1';
				jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';
			
			--Instruction -> "jal"
			elsif (code = "000011" and R_type = '0') then
				RegDst          <= '0';
				ALUSrc          <= '0';
				MemtoReg        <= '0';
				RegWrite        <= '1';
				MemWrite        <= '0';
				ALUControl      <= "XXXX";
				beq             <= '0';
				bne             <= '0';
				j               <= '1';
				jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
				UnsignedNoOverflow <= '1';
                		
			--Instruction -> "halt"
			elsif (code = "010100") then
				RegDst          <= '0';
				ALUSrc          <= '0';
				MemtoReg        <= '0';
				RegWrite        <= '0';
				MemWrite        <= '0';
				ALUControl      <= "XXXX";
				beq             <= '0';
                		bne             <= '0';
				j               <= '0';
				jr              <= '0';
                		sltu            <= '0';
                		shiftVariable   <= '0';
				signSel	        <= '1';
                		upper_immediate <= '0';
                		s_halt          <= '1';
				UnsignedNoOverflow <= '1';

		end if;
		
end process p_whichInstr;
	
	halt <= s_halt;
	
end behavioral;

