library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_signed.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;


entity mux16to1_tb is

end mux16to1_tb;


architecture mux16to1_tb_behave of mux16to1_tb is
    -- declare signal
    signal w :  register_file_array(DATA_WIDTH - 1 downto 0);
    signal s : std_logic_vector(3 downto 0);
    signal output2 : std_logic_vector(DATA_WIDTH - 1 downto 0);
        
         

    begin --
            w(0) <= x"0000";
            w(1) <= x"0001";
            w(2) <= x"0002";
            w(3) <= x"0003";
            w(4) <= x"0004";
            w(5) <= x"0005";
            w(6) <= x"0006";
            w(7) <= x"0007";
            w(8) <= x"0008";
            w(9) <= x"0009";
            w(10) <= x"000A";
            w(11) <= x"000B";
            w(12) <= x"000C";
            w(13) <= x"000D";
            w(14) <= x"000E";
            w(15) <= x"000F";

            dut: mux16to1 
                generic map (DATA_WIDTH => 16)
                port map(w, s, output2);
               
               
                mypr5: process
                begin
                    s <= x"0"; wait for 10 ns;
                    s <= x"1"; wait for 10 ns;
                    s <= x"2"; wait for 10 ns;
                    s <= x"3"; wait for 10 ns;
                    s <= x"4"; wait for 10 ns;
                    s <= x"5"; wait for 10 ns;
                    s <= x"6"; wait for 10 ns;
                    s <= x"7"; wait for 10 ns;
                    s <= x"8"; wait for 10 ns;
                    s <= x"9"; wait for 10 ns;
                    s <= x"A"; wait for 10 ns;
                    s <= x"B"; wait for 10 ns;
                    s <= x"C"; wait for 10 ns;
                    s <= x"D"; wait for 10 ns;
                    s <= x"E"; wait for 10 ns;
                    s <= x"F"; wait for 10 ns;

                end process;
            

    end mux16to1_tb_behave;