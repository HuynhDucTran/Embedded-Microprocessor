library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

entity register_file is

        generic (
        DATA_WIDTH        :     integer   := 16;     -- Word Width
        ADDR_WIDTH        :     integer   := 16      -- Address width
        );

        port(
                clk: in std_logic;       
                RFwe: in std_logic;
                OPr1a: in std_logic_vector(3 downto 0);
                OPr2a: in std_logic_vector(3 downto 0);
                OPr1e, OPr2e: in std_logic;
                RFin : in std_logic_vector(DATA_WIDTH - 1 downto 0);

                OPr1 : out std_logic_vector(DATA_WIDTH - 1 downto 0);
                OPr2 : out std_logic_vector(DATA_WIDTH - 1 downto 0)

        );


end register_file;

architecture register_file_behave of register_file is

        begin



end register_file_behave;