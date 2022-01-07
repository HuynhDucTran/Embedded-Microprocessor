-- Nguyen Kiem Hung
-- controller

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_signed.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;


entity controller is             	
  
   port (-- you will need to add more ports here as design grows
         nReset   : in STD_LOGIC := '1'; -- low active reset signal
    	  --  start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC := '0';    -- Clock
        -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
	       IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0009"; -- input to decode
	      -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        -- imm   : out std_logic_vector(3 downto 0); -- check???
         -- status signals from ALU
     	   ALUz  : in std_logic := '0'; -- alu flags
     	    -- add ports as required here
     	   -- control signals
     	   RFs    : out std_logic_vector(1 downto 0) := "00"; -- register file selected.
     	   Mre: out std_logic := '0'; -- memory read enable, memory write enable, both RF and Memory=> M 
     	   Mwe : out std_logic := '0'; -- memory read enable, memory write enable, both RF and Memory=> M 

          ALUs : out std_logic_vector(1 downto 0) := "00"; --
     	   
     	    -- add ports as required here
         Ms : out std_logic_vector(1 downto 0) := "00";
         IRLd : out std_logic := '0';

         RFwa : out std_logic_vector(3 downto 0) := x"0";-- RFwe is Mwe
         RFwe : out std_logic := '0';
         OPR1a : out std_logic_vector(3 downto 0) := x"0";
         OPR1e : out std_logic := '0';
         OPR2a : out std_logic_vector(3 downto 0) := x"0";
         OPR2e : out std_logic := '0';

        -- pc control
        PCClr : out std_logic := '0';
        PCinc : out std_logic := '0';
        PCLd : out std_logic := '0';

        -- opcode : in std_logic_vector(15 downto 12); -- bits: 15 14 13 12 ==> opcode
         check_over_instruction : out std_logic := '0';
        
        fetch_flag: buffer std_logic := '0'
          
        );                              
 
end controller;

architecture fsm of controller is
-- types and signals are declared here  

 signal opcode : std_logic_vector(15 downto 12) := IR_in(15 downto 12); -- bits: 15 14 13 12 ==> opcode
 signal temp_Ms: std_logic_vector(1 downto 0);
 signal temp_Mre: std_logic;
-- constants declared for ease of reading code
  signal counter: integer := 0;
  

  
				 -- asynchronous rst for controlller
begin -- begin of architecture
	-- state transition
  opcode <= IR_in(15 downto 12);
  
  FSM_trans:process (nReset, clk)
   variable abc: integer   := 0;
  begin -- begin of process
    if (nReset = '0') then-- reset signal active low 
      RFs <= "00";
      RFwa <= x"0";
      RFwe <= '0';
      OPR1a <= x"0";
      OPR1e <= '0';
      OPR2a <= x"0";
      OPR2e <= '0';
      ALUs <= "00";
      --ALUz <= '0'; ??? check again
      --IR_in <= x"0000"; ??????
      Ms <= "00";
      IRLd <= '0';
      PCLd <= '0';
      PCinc <= '0';
      PCClr <= '0';
      Mre <= '0';
      Mwe <= '0';
      --state <= decode;
      counter <= 0;
    elsif (clk'event and clk = '1') then
      case counter is

        when 2 =>
        case opcode is
          when "0000" => -- move1: RF(Rn) = M(direct) --1: load data from memory to register file
            Ms <= "01"; 
            Mre <= '1';
            RFs <= "01";
            RFwa <= IR_in(11 downto 8);
            RFwe <= '1';
  
           
           -- state <= fetch;
           counter <= 0;
  
            
  
            
  
          when "0001" => -- move2: M(direct) = RF(Rn) --2: store data from register file to memory: direct
            OPR1a <= IR_in(11 downto 8);
            OPR1e <= '1';
            Ms <= "11"; 
            Mwe <= '1';
  
            PCinc <= '0';
            IRLd <= '0';
            --state <= fetch;
            counter <= 0;
            
  
  
  
          when "0010" => -- move3: M(Rm) = RF(Rn) --3: store data from register file to memory: indirect
            OPR1a <= IR_in(11 downto 8); -- OPR1a = Rn
            OPR1e <= '1'; -- enable to read
            OPR2a <= IR_in(7 downto 4); -- OPR2a = Rm
            OPR2e <= '1'; -- enable to read
            Ms <= "00";
            Mwe <= '1';
  
          when "0011" => -- move4: RF(Rn) = immediate --4: data takes from register
            RFs <= "01";
            RFwa <= IR_in(11 downto 8);
            RFwe <= '1';
  
          when "0100" => -- add: RF(Rn) = RF(Rn) + RF(Rm) --5: add two value in register
            OPR1a <= IR_in(11 downto 8); -- OPR1a = Rn
            OPR1e <= '1'; -- enable to read
            OPR2a <= IR_in(7 downto 4); -- OPR2a = Rm
            OPR2e <= '1'; -- enable to read
            ALUs <= "00";
            RFs <= "00";
            RFwa <= IR_in(11 downto 8);
            RFwe <= '1';
  
          when "0101" => -- subtract: RF(Rn) = RF(Rn) - RF(Rm) --6: struct two value in register
            OPR1a <= IR_in(11 downto 8); -- OPR1a = Rn
            OPR1e <= '1'; -- enable to read
            OPR2a <= IR_in(7 downto 4); -- OPR2a = Rm
            OPR2e <= '1'; -- enable to read
            ALUs <= "01";
            RFs <= "00";
            RFwa <= IR_in(11 downto 8);
            RFwe <= '1';
  
          when "0110" => -- jump zero: PC = addr only if RF(Rn) = 0 --7: aluz: zero flag only 0 if resulat of alu is 0
            OPR1a <= IR_in(11 downto 8); -- OPR1a = Rn
            OPR1e <= '1'; -- enable to read
            if (ALUz = '1') then 
              PCLd <= '1';
            else 
              PCLd <= '0';
            end if;
  
          when "0111" => -- OR: RF(Rn) = RF(Rn) or RF(Rm) --8: or two value in register
            OPR1a <= IR_in(11 downto 8); -- OPR1a = Rn
            OPR1e <= '1'; -- enable to read
            OPR2a <= IR_in(7 downto 4); -- OPR2a = Rm
            OPR2e <= '1'; -- enable to read
            ALUs <= "10";
            RFs <= "00";
            RFwa <= IR_in(11 downto 8);
            RFwe <= '1';
  
          when "1000" => -- AND: RF(Rn) = RF(Rn) and RF(Rm) --9: and two value in register
            OPR1a <= IR_in(11 downto 8); -- OPR1a = Rn
            OPR1e <= '1'; -- enable to read
            OPR2a <= IR_in(7 downto 4); -- OPR2a = Rm
            OPR2e <= '1'; -- enable to read
            ALUs <= "10";
            RFs <= "00";
            RFwa <= IR_in(11 downto 8);
            RFwe <= '1';
  
          when "1001" => -- jump unconditional: PC = addr --10
            PCLd <= '1';
  
          when others => 
            check_over_instruction  <= '1';
        end case;

          when 0 => 
            
             
  
              --state <= decode;
              counter <= counter + 1;
           

            when 1 => 
           
              Ms <= "10";
              Mre <= '1';
              IRLd <= '1';
              PCinc <= '1';
              PCClr <= '0';
  
              RFs <= "00";
              RFwa <= x"0";
              RFwe <= '0';
  
              OPR1a <= x"0";
              OPR1e <= '0';
              OPR2a <= x"0";
              OPR2e <= '0';
              ALUs <= "00";
              PCLd <= '0';
              Mwe <= '0';
  
              --state <= decode;
              counter <= counter + 1;
           

          when others => 
            null;

      end case;
    end if;

  end process;
  
  
  -- write codes to generate control signals 			
end fsm;









