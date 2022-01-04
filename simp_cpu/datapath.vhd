-- Nguyen Kiem Hung
-- datapath for microprocessor

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

entity datapath is
  Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( -- you will need to add more ports here as design grows
          nReset     : in STD_LOGIC;
          clk     : in STD_LOGIC;
	        imm     : in std_logic_vector(7 downto 0);
	        Data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
          Data_out: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
          -- add ports as required
        );
end datapath;

architecture struct of datapath is
begin
-- write your code here

	--ALU_U: alu port map (?);
  --RF_U: REG_FILE port map (?);
  -- MUX_U: MUX4to1 port map(?);

end struct;


