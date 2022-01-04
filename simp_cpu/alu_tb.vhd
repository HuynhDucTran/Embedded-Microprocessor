library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_signed.all;
USE IEEE.numeric_std.all; 
use work.sys_definition.all;

entity alu_tb is

end alu_tb;


architecture alu_tb_behave of alu_tb is
        signal ALUs :  std_logic_vector(1 downto 0);
        signal ALUz :  std_logic;
        signal ALUr :  std_logic_vector(DATA_WIDTH - 1 downto 0);

        signal OPr1 :  std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0006";
        signal OPr2 :  std_logic_vector(DATA_WIDTH - 1 downto 0) := x"0004";
    begin --
    dut:  alu
    generic map
    (
      DATA_WIDTH     => 16,
      ADDR_WIDTH => 16
      )
     
    port map (ALUs, ALUz, ALUr, OPr1, OPr2);

    mypr2: process
    begin
        ALUs <= "00"; -- add
        wait for 10 ns;

        ALUs <= "01"; -- subtract
        wait for 10 ns;

        ALUs <= "10"; -- or
        wait for 10 ns;

        ALUs <= "11"; -- and
        wait for 10 ns;


    end process;

    


            

    end alu_tb_behave;