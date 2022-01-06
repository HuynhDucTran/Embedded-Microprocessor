library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;

entity mux4to1_tb is

end mux4to1_tb;


architecture mux4to1_tb_behave of mux4to1_tb is
        signal A, B, C, D: 	std_logic_vector (DATA_WIDTH - 1 downto 0);
        signal SEL :  	 std_logic_vector (1 downto 0);
        signal Z:  	std_logic_vector (DATA_WIDTH - 1 downto 0);
         -- assign value 
         

    begin --
         
            dut: mux4to1 
                
                port map(A, B, C, D, SEL, Z);
                A <= x"0001";
                B <= x"0002";
                C <= x"0003";
                D <= x"0004";
               
                mypr4: process
                begin
                    sel <= "00";
                    wait for 10 ns;
                    sel <= "01";
                    wait for 10 ns;
                    sel <= "10";
                    wait for 10 ns;
                    sel <= "11";
                    
                    wait for 10 ns;
                end process;
            

    end mux4to1_tb_behave;