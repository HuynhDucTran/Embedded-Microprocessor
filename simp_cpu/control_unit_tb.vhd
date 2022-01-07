
library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.sys_definition.all;
 
use std.textio.all;
 
entity control_unit_tb is

end control_unit_tb;

 
 
architecture control_unit_tb_behave of control_unit_tb is

  signal nReset   :  STD_LOGIC := '1'; -- low active reset signal
    --  start : in STD_LOGIC;    -- high active Start: enable cpu
    signal  clk   :  STD_LOGIC := '0';    -- Clock
    -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
    signal IR_in :  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
    signal  IR_inD :  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
    -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
    -- imm   : out std_logic_vector(3 downto 0); -- check???
      -- status signals from ALU
      signal  ALUz  :  std_logic := '0'; -- alu flags
        -- add ports as required here
      -- control signals
      signal  RFs    :  std_logic_vector(1 downto 0) := "00"; -- register file selected.
      signal Mre :  std_logic := '0'; -- memory read enable, memory write enable, both RF and Memory=> M 
      signal Mwe :  std_logic := '0'; -- memory read enable, memory write enable, both RF and Memory=> M 

      signal  ALUs :  std_logic_vector(1 downto 0) := "00"; --
      
        -- add ports as required here
        signal Ms : std_logic_vector(1 downto 0) := "00";
        signal  IRLd : std_logic := '0';

        signal  RFwa : std_logic_vector(3 downto 0) := x"0";-- RFwe is Mwe
        signal  RFwe : std_logic := '0';
        signal  OPR1a : std_logic_vector(3 downto 0) := x"0";
        signal  OPR1e : std_logic := '0';
        signal OPR2a : std_logic_vector(3 downto 0) := x"0";
        signal  OPR2e : std_logic := '0';
        signal  IRclr : std_logic := '0';
    -- pc control
    signal  PCClr : std_logic := '0';
    signal  PCinc : std_logic := '0';
    signal  PCLd : std_logic := '0';
  -- mux4to1
  signal  PCout : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
  signal  addr_out : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
  signal  alu_addr : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
  signal  IR_out1 : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
  signal  IR_for_D_pc : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";

  signal  register_temp : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     --datapath
     signal RFin : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal  OPr1 : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal OPr2 : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal IR_out_for_RF_1:  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"0000"; -- port B
     --Data_out: inout  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000C"; -- port C IR_inD
     signal  ALUr :  std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";-- port A
     signal gpio_register_array :  register_file_array (15 downto 0) := (others => (others => '0'));

Begin
  -- write your code here
  clk <= not clk after 10 ns; -- T = 20 ns
  dut1: control_unit 
    port map (nReset, clk, IR_in, IR_inD, ALUz, RFs, Mre, Mwe, ALUs, Ms, IRLd, RFwa, RFwe,
              OPr1a, OPR1e, OPR2a, OPR2e, IRclr, PCclr, PCinc, PCLd, PCout, addr_out, alu_addr, IR_out1, IR_out_for_RF_1, register_temp);
 
  mypr9: process
  begin
     PCclr <= '1';
     wait for 20 ns;
     
 
  end process;
End control_unit_tb_behave;