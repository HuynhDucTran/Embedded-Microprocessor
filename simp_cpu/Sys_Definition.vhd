--This confidential and proprietary software may be used
--only as authorized by a licensing agreement from
--Laboratory for Smart Integrated Systems (SIS), VNU University of Engineering and Technology (VNU-UET).
-- (C) COPYRIGHT 2015
-- ALL RIGHTS RESERVED
-- The entire notice above must be reproduced on all authorized copies.
--
-- Filename : RCA_define.v
-- Author : Hung Nguyen
-- Date : 
-- Version : 0.1
-- Description Package declares all constants, types, 
-- and components for project.               
-- Modification History:
-- Date By Version Change Description
-- ========================================================
-- 05/08.2014  0.1 Original
-- ========================================================
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all ;
use std.textio.all;

package Sys_Definition is

-- Constant for datapath
  Constant   DATA_WIDTH  :     integer   := 16;     -- Word Width
  Constant   ADDR_WIDTH  :     integer   := 16 ;     -- Address width
--constant PORT_NUM : integer := 5;

-- Type Definition
   -- type ADDR_ARRAY_TYPE is array (VC_NUM-1 DOWNTO 0) of std_logic_vector (ADDR_WIDTH-1 downto 0);
   type register_file_array is array (integer range <>) of std_logic_vector(DATA_WIDTH - 1 downto 0);

-- **************************************************************
--COMPONENTs
-- CPU
COMPONENT cpu is
  
  port ( nReset   : in STD_LOGIC; -- low active reset signal
   --  start : in STD_LOGIC;    -- high active Start: enable cpu
     clk   : in STD_LOGIC;    -- Clock
   -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
     IR_in : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
       IR_inD : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
   -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
   -- imm   : out std_logic_vector(3 downto 0); -- check???
     -- status signals from ALU
     ALUz  : inout std_logic; -- alu flags
       -- add ports as required here
     -- control signals
     RFs    : inout std_logic_vector(1 downto 0); -- register file selected.
     Mre, Mwe : inout std_logic; -- memory read enable, memory write enable, both RF and Memory=> M 
     ALUs : inout std_logic_vector(1 downto 0); --
     
       -- add ports as required here
     Ms : inout std_logic_vector(1 downto 0);
     IRLd : inout std_logic;

     RFwa : inout std_logic_vector(3 downto 0);-- RFwe is Mwe
     RFwe : inout std_logic;
     OPR1a : inout std_logic_vector(3 downto 0);
     OPR1e : inout std_logic;
     OPR2a : inout std_logic_vector(3 downto 0);
     OPR2e : inout std_logic;
     IRclr : inout std_logic := '0';
   -- pc control
   PCClr : inout std_logic;
   PCinc : inout std_logic;
   PCLd : inout std_logic;
 -- mux4to1
   PCout : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
   addr_out : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
   alu_addr : inout std_logic_vector(DATA_WIDTH - 1 downto 0); --
   IR_out1 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
   IR_for_D_pc : inout std_logic_vector(DATA_WIDTH - 1 downto 0); -- for 

   register_temp : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
    --datapath
    RFin : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
    OPr1 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
    OPr2 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
    IR_out_for_RF_1: inout  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000B"; -- port B
    --Data_out: inout  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000C"; -- port C IR_inD
    ALUr : inout std_logic_vector(DATA_WIDTH - 1 downto 0);-- port A
    gpio_register_array : inout register_file_array (15 downto 0) := (others => (others => '0'))
       );
end COMPONENT;
-- Controller
COMPONENT controller is             	
  
   port (-- you will need to add more ports here as design grows
         nReset   : in STD_LOGIC; -- low active reset signal
    	  --  start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC;    -- Clock
        -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
	       IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
	      -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        -- imm   : out std_logic_vector(3 downto 0); -- check???
         -- status signals from ALU
     	   ALUz  : in std_logic; -- alu flags
     	    -- add ports as required here
     	   -- control signals
     	   RFs    : out std_logic_vector(1 downto 0); -- register file selected.
     	   Mre, Mwe : out std_logic; -- memory read enable, memory write enable, both RF and Memory=> M 
          ALUs : out std_logic_vector(1 downto 0); --
     	   
     	    -- add ports as required here
         Ms : out std_logic_vector(1 downto 0);
         IRLd : out std_logic;

         RFwa : out std_logic_vector(3 downto 0);-- RFwe is Mwe
         RFwe : out std_logic;
         OPR1a : out std_logic_vector(3 downto 0);
         OPR1e : out std_logic;
         OPR2a : out std_logic_vector(3 downto 0);
         OPR2e : out std_logic;

        -- pc control
        PCClr : out std_logic;
        PCinc : out std_logic;
        PCLd : out std_logic;

        -- opcode : in std_logic_vector(15 downto 12); -- bits: 15 14 13 12 ==> opcode
         check_over_instruction : out std_logic
        
        
          
        );                              
 
end COMPONENT;
-----------------------------
-- Datapath
COMPONENT datapath is
  --generic (
       -- DATA_WIDTH        :     integer   := 16;     -- Word Width
       -- ADDR_WIDTH        :     integer   := 16      -- Address width
       -- );
   port ( -- you will need to add more ports here as design grows
          nReset     : in STD_LOGIC;
          clk     : in STD_LOGIC;
	        --imm     : in std_logic_vector(7 downto 0);
	        -- Data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
          -- Data_out: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
          -- add ports as required

          -- port for register file
          RFwe: in std_logic := '1';
          RFwa: in std_logic_vector(3 downto 0) := x"2"; -- write to register 2
          OPr1a: in std_logic_vector(3 downto 0) := x"2";
          OPr2a: in std_logic_vector(3 downto 0);
          OPr1e: in std_logic := '1';
          OPr2e: in std_logic;

          RFin : inout std_logic_vector(DATA_WIDTH - 1 downto 0);

          OPr1 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
          OPr2 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);

          -- port for alu
          ALUs : in std_logic_vector(1 downto 0);
          ALUz : out std_logic;
          ALUr : inout std_logic_vector(DATA_WIDTH - 1 downto 0);-- port A

          -- port for mux4to1

          IR_out_for_RF_1: IN  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000B"; -- port B
          Data_out: IN  	std_logic_vector (DATA_WIDTH - 1 downto 0) := x"000C"; -- port C
          register_temp : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
          RFs : IN 	 std_logic_vector (1 downto 0) := "10";-- select C port
         gpio_register_array : inout register_file_array (15 downto 0) := (others => (others => '0'))

        );
end COMPONENT;
-------------------------------------
component dpmem 
   generic (
     DATA_WIDTH        :     integer   := 16;     -- Word Width
     ADDR_WIDTH        :     integer   := 16      -- Address width
     );
 
   port (
     -- Writing
     Clk              : in  std_logic;          -- clock
     nReset             : in  std_logic; -- Reset input
     addr              : in  std_logic_vector(ADDR_WIDTH -1 downto 0);   --  Address
     -- Writing Port
     Wen               : in  std_logic;          -- Write Enable
     Datain            : in  std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');   -- Input Data
     -- Reading Port
  
     Ren               : in  std_logic;          -- Read Enable
     Dataout           : out std_logic_vector(DATA_WIDTH -1 downto 0)   -- Output data
     
     );
  
  end component;

  ----------------------------------------------------------------
  -- component for test 
  component test is
    port (
        out1: in std_logic_vector(3 downto 0);
        integer_test: out integer
    );-- Memory

end component;

  ----------------------------------------------------------------


------------------------------------------------------
Component mux4to1 
   
   PORT (A, B, C, D: IN  	std_logic_vector (DATA_WIDTH-1 downto 0);
        SEL : IN 	 std_logic_vector (1 downto 0);
        Z: OUT 	std_logic_vector (DATA_WIDTH-1 downto 0)
               );
END Component;
-----------------
-- You need to add the other components here.......
----------------------------------------------------------------
    -- alu component
    Component alu is

    

      port(
              ALUs : in std_logic_vector(1 downto 0);
              ALUz : out std_logic;
              ALUr : out std_logic_vector(DATA_WIDTH - 1 downto 0);

              OPr1 : in std_logic_vector(DATA_WIDTH - 1 downto 0);
              OPr2 : in std_logic_vector(DATA_WIDTH - 1 downto 0)

      );


      end Component;

------------------------------------------------------


---------------------------------
      -- extend components
      Component extend is
        port (
            input1: in std_logic_vector(3 downto 0) := "0111";
            output1: out std_logic_vector(7 downto 0)
        );
    
    end Component;


--------------------------------


--------------------------------
-- mux16to1 component
Component mux16to1 is
        
  generic (DATA_WIDTH : integer := 16);

  port( 
          w : in register_file_array(DATA_WIDTH - 1 downto 0);
          s : in std_logic_vector(3 downto 0);
          output2 : out std_logic_vector(DATA_WIDTH - 1 downto 0)
  );
end Component;
--------------------------------


--------------------------------
  -- register file component
  Component register_file is

   port(
           clk: in std_logic;       
           RFwe: in std_logic;
           RFwa: in std_logic_vector(3 downto 0);
           OPr1a: in std_logic_vector(3 downto 0);
           OPr2a: in std_logic_vector(3 downto 0);
           OPr1e, OPr2e: in std_logic;
           RFin : in std_logic_vector(DATA_WIDTH - 1 downto 0);

           OPr1 : out std_logic_vector(DATA_WIDTH - 1 downto 0);
           OPr2 : out std_logic_vector(DATA_WIDTH - 1 downto 0);
           gpio_register_array : inout register_file_array (15 downto 0) := (others => (others => '0'))

   );


end Component;
--------------------------------

--------------------------------
-- PC component
Component pc is
  port( 
       clk : in std_logic;
       PCclr : in std_logic;
       PCinc : in std_logic;
       PCLd : in std_logic;

       PC_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
       PC_out : inout std_logic_vector(DATA_WIDTH - 1 downto 0)
  );
end Component;


--------------------------------


--------------------------------
-- IR component
Component IR is
  port( 
       IRclr : in std_logic;
       IRld : in std_logic;
       clk : in std_logic;
       IR_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
       IR_out : inout std_logic_vector(DATA_WIDTH - 1 downto 0)
  ); 
end Component;
--------------------------------

--------------------------------
--control unit component
Component control_unit is
  port( 
       nReset   : in STD_LOGIC; -- low active reset signal
     --  start : in STD_LOGIC;    -- high active Start: enable cpu
      clk   : in STD_LOGIC;    -- Clock
     -- Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); -- refer to memory.
      IR_in : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
         IR_inD : inout STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := x"0000"; -- input to decode
     -- ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
     -- imm   : out std_logic_vector(3 downto 0); -- check???
      -- status signals from ALU
       ALUz  : in std_logic; -- alu flags
        -- add ports as required here
       -- control signals
       RFs    : out std_logic_vector(1 downto 0); -- register file selected.
       Mre, Mwe : out std_logic; -- memory read enable, memory write enable, both RF and Memory=> M 
       ALUs : out std_logic_vector(1 downto 0); --
       
        -- add ports as required here
      Ms : inout std_logic_vector(1 downto 0);
      IRLd : inout std_logic;

      RFwa : out std_logic_vector(3 downto 0);-- RFwe is Mwe
      RFwe : out std_logic;
      OPR1a : out std_logic_vector(3 downto 0);
      OPR1e : out std_logic;
      OPR2a : out std_logic_vector(3 downto 0);
      OPR2e : out std_logic;
      IRclr : inout std_logic := '0';
     -- pc control
     PCClr : inout std_logic;
     PCinc : inout std_logic;
     PCLd : inout std_logic;
  -- mux4to1
     PCout : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
     addr_out : out std_logic_vector(DATA_WIDTH - 1 downto 0);
     alu_addr : in std_logic_vector(DATA_WIDTH - 1 downto 0); --
     IR_out1 : inout std_logic_vector(DATA_WIDTH - 1 downto 0);
     IR_for_D_pc : inout std_logic_vector(DATA_WIDTH - 1 downto 0); -- for 

     register_temp : inout std_logic_vector(DATA_WIDTH - 1 downto 0)

    

  ); 
end Component;
--------------------------------


-----------------
end Sys_Definition;

PACKAGE BODY Sys_Definition IS
	-- package body declarations

END PACKAGE BODY Sys_Definition;