-- Nguyen Kiem Hung
-- datapath for microprocessor

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.sys_definition.all;

entity datapath is
  --generic (
       -- DATA_WIDTH        :     integer   := 16;     -- Word Width
       -- ADDR_WIDTH        :     integer   := 16      -- Address width
       -- );
   port ( -- you will need to add more ports here as design grows
          nReset     : in STD_LOGIC;
          clk     : in STD_LOGIC;
	        --imm     : in std_logic_vector(7 downto 0);
	        -- Data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
          -- Data_out: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
          -- add ports as required

          -- port for register file
          RFwe: in std_logic := '1';
          RFwa: in std_logic_vector(3 downto 0) := x"2"; -- write to register 2
          OPr1a: in std_logic_vector(3 downto 0) := x"2";
          OPr2a: in std_logic_vector(3 downto 0);
          OPr1e: in std_logic := '1';
          OPr2e: in std_logic;

          RFin : inout std_logic_vector(DATA_WIDTH - 1 downto 0);

          OPr1 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
          OPr2 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);

          -- port for alu
          ALUs : in std_logic_vector(1 downto 0);
          ALUz : out std_logic;
          ALUr : inout std_logic_vector(DATA_WIDTH - 1 downto 0);-- port A

          -- port for mux4to1

          IR_out_for_RF_1: IN  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000B"; -- port B
          Data_out: IN  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000C"; -- port C
          register_temp : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
          RFs : IN 	 std_logic_vector (1 downto 0) := "10";-- select C port
         gpio_register_array : inout register_file_array (15 downto 0) := (others => (others => '0'))

        );
end datapath;

architecture struct of datapath is
    -- declare

    
begin
-- write your code here

	--ALU_U: alu port map (?);
    alu_u: alu port map(ALUs, ALUz, ALUr, OPr1, OPr2);
  --RF_U: REG_FILE port map (?);
     RF_U: register_file port map (clk, RFwe, RFwa, OPr1a, OPr2a, OPr1e, OPr2e,RFin, OPr1, OPr2, gpio_register_array);
  -- MUX_U: MUX4to1 port map(?);
    MUX4to1_U: mux4to1 port map (ALUr, IR_out_for_RF_1, Data_out, register_temp, RFs, RFin);

   -- mypr6: process(clk)

   --   begin -- begin of process
   --     if (rising_edge(clk)) then


     --   end if;

    --  end process;
end struct;


