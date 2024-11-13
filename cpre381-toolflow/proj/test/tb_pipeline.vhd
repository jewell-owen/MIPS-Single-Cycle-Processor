-------------------------------------------------------------------------
-- Luca Cano
-- Iowa State University
-------------------------------------------------------------------------

-- tb_pipeline.vhd

-------------------------------------------------------------------------
-- DESCRIPTION: instantiates all four of the registers in a
-- single design. Show that values that are stored in the initial IF/ID register are
-- available as expected four cycles later, and that new values can be inserted into the
-- pipeline every single cycle. Most importantly, this testbench should also test that
-- each pipeline register can be individually stalled or flushed.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pipeline is
  generic(helper        : time := 10 ns;
          N             : integer := 32);
end tb_pipeline;

architecture mixed of tb_pipeline is

component reg_IFID is
   port(clock        : in std_logic;
        i_RST        : in std_logic;
        i_WE         : in std_logic;
        i_PC         : in std_logic_vector(N-1 downto 0);
        i_Instr      : in std_logic_vector(N-1 downto 0);
        o_PC         : out std_logic_vector(N-1 downto 0);
        o_Instr      : out std_logic_vector(N-1 downto 0));
end component;

component reg_IDEX is
   port(clock        : in std_logic;
        i_RST        : in std_logic;
        i_WE         : in std_logic;
        i_Halt       : in std_logic;
        i_Branch     : in std_logic;
        i_MemToReg   : in std_logic;
        i_RegWr      : in std_logic;
        i_MemWr      : in std_logic;
        i_isJump     : in std_logic;
        i_isJumpReg  : in std_logic;
        i_RegDst     : in std_logic;
        i_luiCtrl    : in std_logic;
        i_AluSrc     : in std_logic;
        i_AluCtrl    : in std_logic_vector(3 downto 0);
        i_RegWrAddr  : in std_logic_vector(4 downto 0);
        i_Imm        : in std_logic_vector(15 downto 0);
        i_Instr      : in std_logic_vector(N-1 downto 0);
        i_A          : in std_logic_vector(N-1 downto 0);
        i_B          : in std_logic_vector(N-1 downto 0);
        i_SignExt    : in std_logic_vector(N-1 downto 0);
        i_PC         : in std_logic_vector(N-1 downto 0);
        o_Halt       : out std_logic;
        o_Branch     : out std_logic;
        o_MemToReg   : out std_logic;
        o_RegWr      : out std_logic;
        o_MemWr      : out std_logic;
        o_isJump     : out std_logic;
        o_isJumpReg  : out std_logic;
        o_RegDst     : out std_logic;
        o_luiCtrl    : out std_logic;
        o_AluSrc     : out std_logic;
        o_AluCtrl    : out std_logic_vector(3 downto 0);
        o_RegWrAddr  : out std_logic_vector(4 downto 0);
        o_Imm        : out std_logic_vector(15 downto 0);
        o_Instr      : out std_logic_vector(N-1 downto 0);
        o_A          : out std_logic_vector(N-1 downto 0);
        o_B          : out std_logic_vector(N-1 downto 0);
        o_SignExt    : out std_logic_vector(N-1 downto 0);
        o_PC         : out std_logic_vector(N-1 downto 0));
end component;

component reg_EXMEM is
   port(clock        : in std_logic;
        i_RST        : in std_logic;
        i_WE         : in std_logic;
        i_Halt       : in std_logic;
        i_Branch     : in std_logic;
        i_MemToReg   : in std_logic;
        i_RegWr      : in std_logic;
        i_MemWr      : in std_logic;
        i_isJump     : in std_logic;
        i_isJumpReg  : in std_logic;
        i_AluZero    : in std_logic;
        i_luiCtrl    : in std_logic;
        i_RegWrAddr  : in std_logic_vector(4 downto 0);
        i_Imm        : in std_logic_vector(15 downto 0);
        i_PCnext     : in std_logic_vector(N-1 downto 0);
        i_AluOut     : in std_logic_vector(N-1 downto 0);
        i_RdDataB    : in std_logic_vector(N-1 downto 0);
        i_PC         : in std_logic_vector(N-1 downto 0);
        o_Halt       : out std_logic;
        o_Branch     : out std_logic;
        o_MemToReg   : out std_logic;
        o_RegWr      : out std_logic;
        o_MemWr      : out std_logic;
        o_isJump     : out std_logic;
        o_isJumpReg  : out std_logic;
        o_AluZero    : out std_logic;
        o_luiCtrl    : out std_logic;
        o_RegWrAddr  : out std_logic_vector(4 downto 0);
        o_Imm        : out std_logic_vector(15 downto 0);
        o_PCnext     : out std_logic_vector(N-1 downto 0);
        o_AluOut     : out std_logic_vector(N-1 downto 0);
        o_RdDataB    : out std_logic_vector(N-1 downto 0);
        o_PC         : out std_logic_vector(N-1 downto 0));
end component;


component reg_MEMWB is
   port(clock        : in std_logic;
        i_RST        : in std_logic;
        i_WE         : in std_logic;
        i_Halt       : in std_logic;
        i_Branch     : in std_logic;
        i_MemToReg   : in std_logic;
        i_RegWr      : in std_logic;
        i_isJump     : in std_logic;
        i_luiCtrl    : in std_logic;
        i_RegWrAddr  : in std_logic_vector(4 downto 0);
        i_Imm        : in std_logic_vector(15 downto 0);
        i_MemData    : in std_logic_vector(N-1 downto 0);
        i_AluOut     : in std_logic_vector(N-1 downto 0);
        i_PC         : in std_logic_vector(N-1 downto 0);
        o_Halt       : out std_logic;
        o_Branch     : out std_logic;
        o_MemToReg   : out std_logic;
        o_RegWr      : out std_logic;
        o_isJump     : out std_logic;
        o_luiCtrl    : out std_logic;
        o_RegWrAddr  : out std_logic_vector(4 downto 0);
        o_Imm        : out std_logic_vector(15 downto 0);
        o_MemData    : out std_logic_vector(N-1 downto 0);
        o_AluOut     : out std_logic_vector(N-1 downto 0);
        o_PC         : out std_logic_vector(N-1 downto 0));
end component;

-- Clock signal and reset
signal clock	                : std_logic := '0';
signal flush_IFID	            : std_logic := '0';
signal flush_IDEX	            : std_logic := '0';
signal flush_EXMEM	            : std_logic := '0';
signal flush_MEMWB	            : std_logic := '0';
signal stall_IFID		        : std_logic := '1';
signal stall_IDEX		        : std_logic := '1';
signal stall_EXMEM		        : std_logic := '1';
signal stall_MEMWB		        : std_logic := '1';


-- Expanded signal declarations
signal s_PC                     : std_logic_vector(31 downto 0);
signal s_inst                   : std_logic_vector(31 downto 0);
signal s_rt1                    : std_logic_vector(31 downto 0);
signal s_rd1                    : std_logic_vector(31 downto 0);
signal s_immediateExtend        : std_logic_vector(31 downto 0);
signal s_ALUOut_MEM             : std_logic_vector(31 downto 0);
signal s_ALUb                   : std_logic_vector(31 downto 0);
signal s_sltu1_MEM              : std_logic_vector(31 downto 0);
signal s_upperImmediateD_MEM    : std_logic_vector(31 downto 0);
signal s_DMEM                   : std_logic_vector(31 downto 0);
signal s_ALU_WB                 : std_logic_vector(31 downto 0);
signal s_upperImmediateD_WB     : std_logic_vector(31 downto 0);
signal s_sltu1_WB               : std_logic_vector(31 downto 0);

signal s_writeaddr_EX           : std_logic_vector(4 downto 0);
signal s_writeaddr_MEM          : std_logic_vector(4 downto 0);
signal s_rd                     : std_logic_vector(4 downto 0);
signal s_rt                     : std_logic_vector(4 downto 0);
signal s_shamt                  : std_logic_vector(4 downto 0);
signal s_writeaddr_WB           : std_logic_vector(4 downto 0);
signal s_Op                     : std_logic_vector(2 downto 0);

signal s_upperImmediate_EX      : std_logic;
signal s_upperImmediate_MEM     : std_logic;
signal s_sltu_EX                : std_logic;
signal s_sltu_MEM               : std_logic;
signal s_jal_EX                 : std_logic;
signal s_jal_MEM                : std_logic;
signal s_memToReg_EX            : std_logic;
signal s_memToReg_MEM           : std_logic;
signal s_regWrite_EX            : std_logic;
signal s_regWrite_MEM           : std_logic;
signal s_memWrite_EX            : std_logic;
signal s_memWrite_MEM           : std_logic;
signal s_ALUSrc                 : std_logic;
signal s_sl                     : std_logic;
signal s_sr                     : std_logic;
signal s_ALUControl             : std_logic;
signal s_ShiftVariable          : std_logic;
signal s_upperImmediate_WB      : std_logic;
signal s_sltu_WB                : std_logic;
signal s_jal_WB                 : std_logic;
signal s_memToReg_WB            : std_logic;
signal s_regWrite_WB            : std_logic;


-- Clock generation and component instantiation
begin
-- Clock generation
P_clock: process
begin
  clock <= '1';
  wait for helper;
  clock <= '0';
  wait for helper;
end process;


-- Instantiation of Pipeline Registers with full signal mapping

u_IFID: reg_IFID
  port map(
    clock      => clock,
    i_RST      => flush_IFID,
    i_WE       => stall_IFID,
    i_PC       => x"00400000",
    i_Instr    => x"CFF02312",
    o_PC       => s_PC,
    o_Instr    => s_inst
  );

u_IDEX: reg_IDEX
  port map(
    clock          => clock,
    i_RST          => flush_IDEX,
    i_WE           => stall_IDEX,
    i_Halt         => '0',
    i_Branch       => '0',
    i_MemToReg     => '1',
    i_RegWr        => '1',
    i_MemWr        => '1',
    i_isJump       => '1',
    i_isJumpReg    => '0',
    i_RegDst       => '0',
    i_luiCtrl      => '0',
    i_AluSrc       => '0',
    i_AluCtrl      => "0101",
    i_RegWrAddr    => s_inst(15 downto 11),
    i_Imm          => x"0001",
    i_Instr        => s_inst,
    i_A            => x"0000000A",
    i_B            => x"0000000B",
    i_SignExt      => s_immediateExtend,
    i_PC           => s_PC,
    o_Halt         => open,
    o_Branch       => open,
    o_MemToReg     => s_memToReg_EX,
    o_RegWr        => s_regWrite_EX,
    o_MemWr        => s_memWrite_EX,
    o_isJump       => s_jal_EX,
    o_isJumpReg    => open,
    o_RegDst       => open,
    o_luiCtrl      => open,
    o_AluSrc       => s_ALUSrc,
    o_AluCtrl      => s_ALUControl,
    o_RegWrAddr    => s_writeaddr_EX,
    o_Imm          => open,
    o_Instr        => open,
    o_A            => s_rt1,
    o_B            => s_rd1,
    o_SignExt      => open,
    o_PC           => open
  );

u_EXMEM: reg_EXMEM
  port map(
    clock         => clock,
    i_RST         => flush_EXMEM,
    i_WE          => stall_EXMEM,
    i_Halt        => '0',
    i_Branch      => '0',
    i_MemToReg    => s_memToReg_EX,
    i_RegWr       => s_regWrite_EX,
    i_MemWr       => s_memWrite_EX,
    i_isJump      => s_jal_EX,
    i_isJumpReg   => '0',
    i_AluZero     => '0',
    i_luiCtrl     => '0',
    i_RegWrAddr   => s_writeaddr_EX,
    i_Imm         => x"0001",
    i_PCnext      => s_PC,
    i_AluOut      => s_ALUb,
    i_RdDataB     => s_rd1,
    i_PC          => s_PC,
    o_Halt        => open,
    o_Branch      => open,
    o_MemToReg    => s_memToReg_MEM,
    o_RegWr       => s_regWrite_MEM,
    o_MemWr       => s_memWrite_MEM,
    o_isJump      => s_jal_MEM,
    o_isJumpReg   => open,
    o_AluZero     => open,
    o_luiCtrl     => open,
    o_RegWrAddr   => s_writeaddr_MEM,
    o_Imm         => open,
    o_PCnext      => open,
    o_AluOut      => s_ALUOut_MEM,
    o_RdDataB     => s_sltu1_MEM,
    o_PC          => open
  );

u_MEMWB: reg_MEMWB
  port map(
    clock         => clock,
    i_RST         => flush_MEMWB,
    i_WE          => stall_MEMWB,
    i_Halt        => '0',
    i_Branch      => '0',
    i_MemToReg    => s_memToReg_MEM,
    i_RegWr       => s_regWrite_MEM,
    i_isJump      => s_jal_MEM,
    i_luiCtrl     => '0',
    i_RegWrAddr   => s_writeaddr_MEM,
    i_Imm         => x"0001",
    i_MemData     => s_DMEM,
    i_AluOut      => s_ALUOut_MEM,
    i_PC          => s_PC,
    o_Halt        => open,
    o_Branch      => open,
    o_MemToReg    => s_memToReg_WB,
    o_RegWr       => s_regWrite_WB,
    o_isJump      => s_jal_WB,
    o_luiCtrl     => open,
    o_RegWrAddr   => s_writeaddr_WB,
    o_Imm         => open,
    o_MemData     => s_upperImmediateD_WB,
    o_AluOut      => s_ALU_WB,
    o_PC          => open
  );


-- Process to simulate stalling and flushing
generic_datapath_test: process
begin
    -- Initial flush of all registers
    flush_IFID <= '1';
    flush_IDEX <= '1';
    flush_EXMEM <= '1';
    flush_MEMWB <= '1';
    wait for helper;

    -- Remove flush and allow data flow
    flush_IFID <= '0';
    flush_IDEX <= '0';
    flush_EXMEM <= '0';
    flush_MEMWB <= '0';
    wait for 4 * helper;

    -- Test stalling all registers
    stall_IFID <= '0';
    stall_IDEX <= '0';
    stall_EXMEM <= '0';
    stall_MEMWB <= '0';
    wait for 2 * helper;

    -- Enable stalls and verify data retention
    stall_IFID <= '1';
    stall_IDEX <= '1';
    stall_EXMEM <= '1';
    stall_MEMWB <= '1';
    wait for 4 * helper;

    -- Apply selective flush and stall tests
    flush_IFID <= '1'; wait for helper;
    flush_IFID <= '0'; flush_IDEX <= '1'; wait for helper;
    flush_IDEX <= '0'; flush_EXMEM <= '1'; wait for helper;
    flush_EXMEM <= '0'; flush_MEMWB <= '1'; wait for helper;

    -- Final reset of flush and stall signals
    flush_IFID <= '0';
    flush_IDEX <= '0';
    flush_EXMEM <= '0';
    flush_MEMWB <= '0';
    stall_IFID <= '0';
    stall_IDEX <= '0';
    stall_EXMEM <= '0';
    stall_MEMWB <= '0';

    -- Complete the simulation
    wait;
end process;

end mixed;

