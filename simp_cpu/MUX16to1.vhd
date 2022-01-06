library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_signed.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;

entity mux16to1 is
        
        generic (DATA_WIDTH : integer := 16);

        port( 
                w : in register_file_array(0 to DATA_WIDTH - 1);
                s : in std_logic_vector(3 downto 0);
                output2 : out std_logic_vector(DATA_WIDTH - 1 downto 0)
        );
end mux16to1;


architecture mux16to1_behave of mux16to1 is
        signal m : register_file_array(0 to 3);
       
        begin -- begin of architecture mux16to1_behave
                Mux1: mux4to1 port map (w(0), w(1), w(2), w(3), s(1 downto 0), m(0));
                Mux2: mux4to1 port map (w(4), w(5), w(6), w(7), s(1 downto 0), m(1));
                Mux3: mux4to1 port map (w(8), w(9), w(10), w(11), s(1 downto 0), m(2));
                Mux4: mux4to1 port map (w(12), w(13), w(14), w(15), s(1 downto 0), m(3));
                Mux5: mux4to1 port map (m(0), m(1), m(2), m(3), s(3 downto 2), output2);



end mux16to1_behave;