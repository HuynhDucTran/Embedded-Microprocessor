library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_signed.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;

entity pc_tb is
     
end pc_tb;


architecture pc_tb_behave of pc_tb is
        -- declare signal
          signal clk : std_logic := '0';
          signal PCclr : std_logic := '0';
          signal PCinc : std_logic := '0';
          signal PCLd : std_logic := '0';

          signal PC_in : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
          signal PC_out : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
    begin -- begin of architecture
    dut:  pc
    port map (clk, PCclr, PCinc, PCld, PC_in, PC_out);

    clk <= not clk after 10 ns; -- T = 20 ns
     PCinc <= not PCinc after 20 ns;
    
    


            

    end pc_tb_behave;