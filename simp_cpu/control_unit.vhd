library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;


-- program counter with asynchronous PCclr
entity control_unit is
     
end control_unit;


architecture control_unit_behave of control_unit is
    signal  nReset   :  STD_LOGIC := '1'; -- low active reset signal
    	  --  start : in STD_LOGIC;    -- high active Start: enable cpu
     signal         clk   :  STD_LOGIC := '0';    -- Clock
        -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
     signal IR_in :  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0007"; -- input to decode
     signal IR_inD :  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := X"1007"; -- input to decode
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
     
     begin -- begin of architecture
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
              port map (alu_addr, IR_out1, PCout, register_temp, Ms, addr_out);
          clk <= not clk after 10 ns; -- T = 20 ns
          mypr12: process 
               begin -- begin of process
                    nReset <= '0';
                    wait for 20 ns;
                    nReset <= '1';
                    wait for 200 ns;

               end process;
          
          
          

end control_unit_behave;