library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;


-- program counter with asynchronous PCclr
entity control_unit is
     port( 
          nReset   : in STD_LOGIC; -- low active reset signal
    	  --  start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC;    -- Clock
        -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
	       IR_in : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
            IR_inD : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
	      -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        -- imm   : out std_logic_vector(3 downto 0); -- check???
         -- status signals from ALU
     	   ALUz  : in std_logic; -- alu flags
     	    -- add ports as required here
     	   -- control signals
     	   RFs    : out std_logic_vector(1 downto 0); -- register file selected.
     	   Mre, Mwe : out std_logic; -- memory read enable, memory write enable, both RF and Memory=> M 
          ALUs : out std_logic_vector(1 downto 0); --
     	   
     	    -- add ports as required here
         Ms : inout std_logic_vector(1 downto 0);
         IRLd : inout std_logic;

         RFwa : out std_logic_vector(3 downto 0);-- RFwe is Mwe
         RFwe : out std_logic;
         OPR1a : out std_logic_vector(3 downto 0);
         OPR1e : out std_logic;
         OPR2a : out std_logic_vector(3 downto 0);
         OPR2e : out std_logic;
         IRclr : inout std_logic := '0';
        -- pc control
        PCClr : inout std_logic;
        PCinc : inout std_logic;
        PCLd : inout std_logic;
     -- mux4to1
        PCout : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
        addr_out : out std_logic_vector(DATA_WIDTH - 1 downto 0);
        alu_addr : in std_logic_vector(DATA_WIDTH - 1 downto 0); --
        IR_out1 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
        IR_for_D_pc : inout std_logic_vector(DATA_WIDTH - 1 downto 0); -- for 

        register_temp : inout std_logic_vector(DATA_WIDTH - 1 downto 0)

       

     ); 
end control_unit;


architecture control_unit_behave of control_unit is

     begin -- begin of architecture
          dut1: controller
               port map(
                    nReset, clk, IR_in, ALUz, RFs, Mre, Mwe, ALUs, Ms, IRld, RFwa, RFwe, OPR1a, OPR1e, OPR2a, OPR2e
               );

          dut2: PC
               port map (clk, PCclr, PCinc, PCLd, IR_in, PCout);
          
          dut3: IR
               port map(IRclr, IRld, clk, IR_inD, IR_in);
     
          dut4: mux4to1
               port map (alu_addr, IR_out1, PCout, register_temp, Ms, addr_out);
          


end control_unit_behave;