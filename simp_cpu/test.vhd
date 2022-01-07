library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity test is
    port (
        clk : in std_logic := '0';
          PCclr : in std_logic := '0';
          PCinc : out std_logic := '0';
          PCLd : in std_logic := '0';

          PC_in : in std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
          
          sample: out std_logic := '0'
    );



end test;


architecture behavior of test is
  
    begin
       mypr11: process(clk) 
        begin 
            if (rising_edge(clk)) then
                PCinc <= '1';
                end if;

        end process;
        


    end behavior;