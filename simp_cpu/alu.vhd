library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_signed.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

entity alu is

        --generic (
       -- DATA_WIDTH        :     integer   := 16;     -- Word Width
       -- ADDR_WIDTH        :     integer   := 16      -- Address width
       -- );

        port(
                ALUs : in std_logic_vector(1 downto 0);
                ALUz : out std_logic;
                ALUr : out std_logic_vector(DATA_WIDTH - 1 downto 0);

                OPr1 : in std_logic_vector(DATA_WIDTH - 1 downto 0);
                OPr2 : in std_logic_vector(DATA_WIDTH - 1 downto 0)

        );


end alu;

architecture alu_behave of alu is
        signal result: std_logic_vector(DATA_WIDTH -1 downto 0);

        begin
                decode_operator: process(ALUs, OPr1, OPr2)
                        begin
                                case ALUs is
                                when "00" =>
                                        result <= OPr1 + OPr2; -- add two operand
                                when "01" =>
                                        result <= OPr1 - OPr2; -- subtract two operand
                                when "10" =>
                                        result <= OPr1 or OPr2; -- or
                                when "11" =>
                                        result <= OPr1 and OPr2; -- and 
                                
                                when others =>
                                        null;
                                
                                end case;
                                

                        end process;
        ALUr <= result;
        ALUz <= '1' when result = x"0000" else '0'; -- alu flag zero.


end alu_behave;