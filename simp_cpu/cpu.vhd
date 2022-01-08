-- Nguyen Kiem Hung
-- cpu : the top level entity

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

-- 
entity cpu is
  
   
end cpu;


architecture struc of cpu is

-- declare internal signals here
          -- Mov R0,3 => R0 = M(3) 0000 0000 0000 0011  
          signal  nReset   :  STD_LOGIC := '1'; -- low active reset signal
    	  --  start : in STD_LOGIC;    -- high active Start: enable cpu
     signal         clk   :  STD_LOGIC := '0';    -- Clock
        -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
     signal IR_in :  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
     signal IR_inD :  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := X"0000"; -- input to decode
    -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
 -- imm   : out std_logic_vector(3 downto 0); -- check???
  -- status signals from ALU
  signal ALUz  :  std_logic := '0'; -- alu flags
       -- add ports as required here
      -- control signals
      signal RFs    :  std_logic_vector(1 downto 0) := "00"; -- register file selected.
      signal Mre:  std_logic := '0'; -- memory read enable, memory write enable, both RF and Memory=> M 
      signal Mwe :  std_logic := '0'; -- memory read enable, memory write enable, both RF and Memory=> M 
      signal ALUs :  std_logic_vector(1 downto 0) := "00"; --

      
       -- add ports as required here
       signal  Ms : std_logic_vector(1 downto 0) := "00";
       signal IRLd : std_logic := '0';

       signal  RFwa : std_logic_vector(3 downto 0) := x"0";-- RFwe is Mwe
       signal   RFwe : std_logic := '0';
       signal  OPR1a : std_logic_vector(3 downto 0) := x"0";
       signal  OPR1e : std_logic := '0';
       signal  OPR2a : std_logic_vector(3 downto 0) := x"0";
       signal  OPR2e : std_logic := '0';
       signal  IRclr : std_logic := '0';
     -- pc control
     signal PCClr : std_logic := '0';
     signal  PCinc : std_logic := '0';
     signal  PCLd : std_logic := '0';
     -- mux4to1
     signal   PCout : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal  addr_out : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal  alu_addr : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal IR_out1 : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal  IR_for_D_pc : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";

     signal  register_temp : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal check_over_instruction : std_logic := '0';
     signal fetch_flag:  std_logic := '0';

     signal RFin : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal OPr1 : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal OPr2 : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
     signal IR_out_for_RF_1:  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"0000"; -- port B
     --Data_out:  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000C"; -- port C IR_inD
     signal ALUr : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";-- port A
     signal gpio_register_array : register_file_array (15 downto 0) := (x"0001", x"0002", x"0003", x"0004", x"0004",x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004");

    signal data_out :  std_logic_vector(DATA_WIDTH - 1 downto 0);
begin

-- write your code here

  --ctrl_U: controller port map(?);
  dut1: controller
  port map(
       nReset, clk, IR_in, ALUz, RFs, Mre, Mwe, ALUs, Ms, IRld, RFwa, RFwe, OPR1a, OPR1e, OPR2a, OPR2e,
      PCClr, PCinc, PCLd, check_over_instruction, fetch_flag
  );

dut2: pc
  port map (clk, PCclr, PCinc, PCLd, IR_in, PCout);

dut3: IR
port map(IRclr, IRld, clk, IR_inD, IR_in);

dut4: mux4to1
 --port map (alu_addr, IR_out1, PCout, register_temp, Ms, addr_out);
 port map (alu_addr, IR_in, PCout, register_temp, Ms, addr_out);

  --Dp_U: datapath port map(?);
    dut5:register_file port map (clk, RFwe, RFwa, OPr1a, OPr2a, OPr1e, OPr2e, RFin, OPr1, OPr2, gpio_register_array);

    dut6: alu port map (ALUs, ALUz, ALUr, OPr1, OPr2);

    dut7: mux4to1 port map (ALUr, IR_out_for_RF_1, IR_inD, register_temp, RFs, RFin);
  --Mem_U: dpmem port map (?);
  
dut8: dpmem
--port map (clk, nReset, addr_out, Mwe, OPr1, Mre, IR_inD);
port map (clk, nReset, addr_out, Mwe, OPr1, Mre, IR_inD);

							
    clk <= not clk after 10 ns; -- T = 20 ns
    mypr13: process 
         begin -- begin of process
              nReset <= '0';
              wait for 20 ns;
              nReset <= '1';
              wait for 300 ns;
              

         end process;
    

end struc;




