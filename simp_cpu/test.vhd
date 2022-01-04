library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all; 

entity test is
    port (
        out1: in std_logic_vector(3 downto 0) := "0000";
        integer_test: out integer
    );



end test;


architecture behavior of test is
    
    begin
         integer_test <= to_integer(unsigned(out1));


    end behavior;