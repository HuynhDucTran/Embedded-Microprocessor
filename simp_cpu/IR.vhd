library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;


-- program counter with asynchronous PCclr
entity IR is
     port( 
          IRclr : in std_logic := '0';
          IRld : in std_logic := '0';
          clk : in std_logic := '0';
          IR_in : in std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
          IR_out : buffer std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000"
     ); 
end IR;


architecture IR_behave of IR is

     begin -- begin of architecture
          mypr8: process(clk, IRclr)
          begin -- begin of process
               if (IRclr = '1') then 
                    IR_out <= x"0000";
               elsif (clk'event and clk = '1') then
                    if (IRld = '1') then
                         IR_out <= IR_in;
                    else IR_out <= IR_out;
                    end if;
               end if;


     end process;
          


end IR_behave;