library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_signed.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;

entity register_file_tb is

end  register_file_tb;


architecture  register_file_tb_behave of  register_file_tb is
    signal clk:  std_logic;       
    signal RFwe:  std_logic;
    signal RFwa:  std_logic_vector(3 downto 0);
    signal OPr1a:  std_logic_vector(3 downto 0);
    signal OPr2a:  std_logic_vector(3 downto 0);
    signal OPr1e, OPr2e:  std_logic;
    signal RFin :  std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal OPr1 :  std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal OPr2 :  std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal gpio_register_array :  register_file_array (15 downto 0) := (others => (others => '0'));
    begin --begin of architecture
    RF_U: register_file port map (clk, RFwe, RFwa, OPr1a, OPr2a, OPr1e, OPr2e, RFin, OPr1, OPr2, gpio_register_array);
    
    
    


            

    end  register_file_tb_behave;