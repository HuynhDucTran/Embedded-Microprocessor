library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity register_file is

         --generic (
       -- DATA_WIDTH        :     integer   := 16;     -- Word Width
       -- ADDR_WIDTH        :     integer   := 16      -- Address width
       -- );

        port(
                clk: in std_logic := '0';       
                RFwe: in std_logic := '0';
                RFwa: in std_logic_vector(3 downto 0) := x"0";
                OPr1a: in std_logic_vector(3 downto 0) := x"0";
                OPr2a: in std_logic_vector(3 downto 0) := x"0";
                OPr1e: in std_logic := '0';
                OPr2e: in std_logic := '0';

                RFin : in std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";

                OPr1 : out std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
                OPr2 : out std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0000";
                gpio_register_array : buffer register_file_array (15 downto 0) := (x"0001", x"0002", x"0003", x"0004", x"0004",x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004", x"0004")

        );


end register_file;
-- read and write 
architecture register_file_behave of register_file is
        
        begin
                mypr5: process(clk)
                        begin 
                                if (rising_edge(clk)) then
                                        if (RFwe = '1') then
                                                gpio_register_array(conv_integer(RFwa)) <= RFin;
                                                
                                        end if;

                                       

                                        
                                        
                                end if;
                                if (OPr1e = '1') then
                                        Opr1 <= gpio_register_array(conv_integer(OPr1a));
                                end if;
                                if (OPr2e = '1') then
                                        Opr2 <= gpio_register_array(conv_integer(OPr2a));
                                end if;


                        end process;
                


end register_file_behave;