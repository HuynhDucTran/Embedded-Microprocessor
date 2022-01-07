library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;

entity test_tb is
         
end test_tb;


architecture behavior_test_tb of test_tb is
           signal clk :  std_logic := '0';
           
           signal PCinc : std_logic := '0';
           signal PCLd : std_logic := '0';
           signal PCclr :  std_logic := '0';
           signal PC_in : std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
           signal PC_out : std_logic_vector(DATA_WIDTH - 1 downto 0)  := x"0000";
           signal sample11: std_logic := '0';
    begin --
            dut: test port map(clk, PCclr, PCinc, PCld, PC_in, sample11);
            dut2: pc port map(clk, PCclr, PCinc, PCld, PC_in, PC_out);
            clk <= not clk after 10 ns;
            mypr9: process
            begin
               PCclr <= '1';
               wait for 20 ns;
               PCclr <= '0';
               wait for 200 ns;
               
           
            end process;
            

    end behavior_test_tb;