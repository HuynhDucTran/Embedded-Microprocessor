
library ieee;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.sys_definition.all;
 
use std.textio.all;
 
entity cpu_tb is

end cpu_tb;

 
 
architecture behavior of cpu_tb is

  signal nReset   :  STD_LOGIC; -- low active reset signal
    --  start : in STD_LOGIC;    -- high active Start: enable cpu
    signal  clk   :  STD_LOGIC := '0';    -- Clock
    -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
    signal IR_in :  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
    signal  IR_inD :  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
    -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
    -- imm   : out std_logic_vector(3 downto 0); -- check???
      -- status signals from ALU
      signal  ALUz  :  std_logic; -- alu flags
        -- add ports as required here
      -- control signals
      signal  RFs    :  std_logic_vector(1 downto 0); -- register file selected.
      signal Mre, Mwe :  std_logic; -- memory read enable, memory write enable, both RF and Memory=> M 
      signal  ALUs :  std_logic_vector(1 downto 0); --
      
        -- add ports as required here
        signal Ms : std_logic_vector(1 downto 0);
        signal  IRLd : std_logic;

        signal  RFwa : std_logic_vector(3 downto 0);-- RFwe is Mwe
        signal  RFwe : std_logic;
        signal  OPR1a : std_logic_vector(3 downto 0);
        signal  OPR1e : std_logic;
        signal OPR2a : std_logic_vector(3 downto 0);
        signal  OPR2e : std_logic;
        signal  IRclr : std_logic := '0';
    -- pc control
    signal  PCClr : std_logic;
    signal  PCinc : std_logic;
    signal  PCLd : std_logic;
  -- mux4to1
  signal  PCout : std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal  addr_out : std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal  alu_addr : std_logic_vector(DATA_WIDTH - 1 downto 0); --
  signal  IR_out1 : std_logic_vector(DATA_WIDTH - 1 downto 0);
  signal  IR_for_D_pc : std_logic_vector(DATA_WIDTH - 1 downto 0); -- for 

  signal  register_temp : std_logic_vector(DATA_WIDTH - 1 downto 0);
     --datapath
     signal RFin : std_logic_vector(DATA_WIDTH - 1 downto 0);
     signal  OPr1 : std_logic_vector(DATA_WIDTH - 1 downto 0);
     signal OPr2 : std_logic_vector(DATA_WIDTH - 1 downto 0);
     signal IR_out_for_RF_1:  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000B"; -- port B
     --Data_out: inout  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000C"; -- port C IR_inD
     signal  ALUr :  std_logic_vector(DATA_WIDTH - 1 downto 0);-- port A
     signal gpio_register_array :  register_file_array (15 downto 0) := (others => (others => '0'));

Begin
  -- write your code here
  clk <= not clk after 10 ns; -- T = 20 ns
  
  
End behavior;