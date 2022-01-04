library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;

entity extend_tb is

end extend_tb;


architecture extend_tb_behave of extend_tb is
    signal input1: std_logic_vector(3 downto 0) := "0000";
    signal output1: std_logic_vector(7 downto 0);

    
    begin --
            dut: extend port map(input1, output1);
                mypr3: process
                begin
                    input1 <= "0001";
                    wait for 10 ns;
                    input1 <= "0010";
                    wait for 10 ns;
                    input1 <= "0111";
                    wait for 10 ns;


                end process;
            

    end extend_tb_behave;