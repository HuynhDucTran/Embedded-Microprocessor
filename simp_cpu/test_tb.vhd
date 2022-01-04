library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;

entity test_tb is

end test_tb;


architecture behavior_test_tb of test_tb is
    signal out1: std_logic_vector(3 downto 0) := "0000";
    signal integer_test: integer;
    signal clk: std_logic := '0';
    begin --
            dut: test port map(out1, integer_test);
                mypr1: process
                begin
                    out1 <= "0111";
                    clk <= '1';
                    wait for 10 ns;
                    out1 <= "1000";
                    clk <= '0';
                    wait for 10 ns;


                end process;
            

    end behavior_test_tb;