library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;


-- program counter with asynchronous PCclr
entity pc is
     port( 
          clk : in std_logic := '0';
          PCclr : in std_logic := '0';
          PCinc : in std_logic := '0';
          PCLd : in std_logic := '0';

          PC_in : in std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
          PC_out : buffer std_logic_vector(DATA_WIDTH - 1 downto 0)  := x"0000"
     ); 
end pc;


architecture pc_behave of pc is
     -- signal temp1 : std_logic_vector(DATA_WIDTH - 1 downto 0);
     begin -- begin of architecture

          mypr6: process(clk, PCclr)
               begin -- begin of process
                    if (PCclr = '1') then 
                         PC_out <= x"0000";
                    elsif (clk'event and clk = '1') then
                         if (PCld = '1') then
                              PC_out <= PC_in;
                         elsif (PCinc = '1') then
                              PC_out <= PC_out + x"0001";
                         else PC_out <= PC_out;
                         end if;
                    end if;



               end process;


end pc_behave;