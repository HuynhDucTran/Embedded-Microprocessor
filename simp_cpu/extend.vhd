library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_signed.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

entity extend is
    port (
        input1: in std_logic_vector(3 downto 0) := "0111";
        output1: out std_logic_vector(7 downto 0)
    );

end extend;


architecture extend_behave of extend is
    
    begin
        output1 <= "0000" & input1;


    end extend_behave;