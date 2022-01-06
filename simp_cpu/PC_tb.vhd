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
          signal PCclr : std_logic;
          signal PCinc : std_logic;
          signal PCLd : std_logic;

          signal PC_in : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0002";
          signal PC_out : std_logic_vector(DATA_WIDTH - 1 downto 0);
    begin -- begin of architecture
    dut:  pc
    port map (clk, PCclr, PCinc, PCld, PC_in, PC_out);

    clk <= not clk after 10 ns; -- T = 20 ns

    mypr7: process 
    begin -- begin of process
        PCclr <= '1';
        wait for 40 ns;
        PCclr <= '0';
        PCinc <= '1';
        wait for 40 ns; 
        PCinc <= '0';
        PCld <= '1';
        wait for 40 ns;


    end process;

    


            

    end pc_tb_behave;