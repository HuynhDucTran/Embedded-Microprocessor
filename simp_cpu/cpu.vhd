-- Nguyen Kiem Hung
-- cpu : the top level entity

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

-- 
entity cpu is
  
   port ( nReset   : in STD_LOGIC; -- low active reset signal
    --  start : in STD_LOGIC;    -- high active Start: enable cpu
      clk   : in STD_LOGIC;    -- Clock
    -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
      IR_in : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
        IR_inD : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
    -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
    -- imm   : out std_logic_vector(3 downto 0); -- check???
      -- status signals from ALU
      ALUz  : inout std_logic; -- alu flags
        -- add ports as required here
      -- control signals
      RFs    : inout std_logic_vector(1 downto 0); -- register file selected.
      Mre, Mwe : inout std_logic; -- memory read enable, memory write enable, both RF and Memory=> M 
      ALUs : inout std_logic_vector(1 downto 0); --
      
        -- add ports as required here
      Ms : inout std_logic_vector(1 downto 0);
      IRLd : inout std_logic;

      RFwa : inout std_logic_vector(3 downto 0);-- RFwe is Mwe
      RFwe : inout std_logic;
      OPR1a : inout std_logic_vector(3 downto 0);
      OPR1e : inout std_logic;
      OPR2a : inout std_logic_vector(3 downto 0);
      OPR2e : inout std_logic;
      IRclr : inout std_logic := '0';
    -- pc control
    PCClr : inout std_logic;
    PCinc : inout std_logic;
    PCLd : inout std_logic;
  -- mux4to1
    PCout : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
    addr_out : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
    alu_addr : inout std_logic_vector(DATA_WIDTH - 1 downto 0); --
    IR_out1 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
    IR_for_D_pc : inout std_logic_vector(DATA_WIDTH - 1 downto 0); -- for 

    register_temp : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
     --datapath
     RFin : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
     OPr1 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
     OPr2 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
     IR_out_for_RF_1: inout  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000B"; -- port B
     --Data_out: inout  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000C"; -- port C IR_inD
     ALUr : inout std_logic_vector(DATA_WIDTH - 1 downto 0);-- port A
     gpio_register_array : inout register_file_array (15 downto 0) := (others => (others => '0'))
        );
end cpu;


architecture struc of cpu is

-- declare internal signals here
          -- Mov R0,3 => R0 = M(3) 0000 0000 0000 0011  
          


begin

-- write your code here

  --ctrl_U: controller port map(?);
  dut1: control_unit 
    port map (nReset, clk, IR_in, IR_inD, ALUz, RFs, Mre, Mwe, ALUs, Ms, IRLd, RFwa, RFwe,
              OPr1a, OPR1e, OPR2a, OPR2e, IRclr, PCclr, PCinc, PCLd, PCout, addr_out, alu_addr, IR_out1, IR_out_for_RF_1, register_temp);

  --Dp_U: datapath port map(?);
  dut2: datapath
    port map (nReset, clk, RFwe, RFwa, OPr1a, OPr2a, OPr1e, OPr2e, RFin, OPr1, OPr2, ALUs, ALUz, ALUr, 
              IR_out_for_RF_1, IR_inD, register_temp, RFs, gpio_register_array);
  --Mem_U: dpmem port map (?);
  dut3: dpmem
    port map (clk, nReset, addr_out, Mwe, OPr1, Mre, IR_inD);
							

end struc;




