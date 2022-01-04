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
   

-- **************************************************************
--COMPONENTs
-- CPU
COMPONENT cpu
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( nReset   : in STD_LOGIC; -- low active reset signal
    	    start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC;    -- Clock
	       Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	       IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	       ALU_out : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
     	   
     	   -- control signals for accessing to memory
     	   Mre, Mwe : out std_logic
     	    -- add ports as required here
        );
END COMPONENT;
-- Controller
component controller 
  Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port (nReset   : in STD_LOGIC; -- low active reset signal
    	    start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC;    -- Clock
         Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	       IR_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	       ALU_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
         imm   : out std_logic_vector(3 downto 0);
         -- status signals from ALU
     	   ALUz  : in std_logic; 
     	    -- add ports as required here
     	   -- control signals
     	   RFs    : out std_logic_vector(1 downto 0);
     	   Mre, Mwe : out std_logic
     	   
     	    -- add ports as required here
          
        );
end component;
-----------------------------
-- Datapath
component datapath
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( nReset     : in STD_LOGIC;
          clk     : in STD_LOGIC;
	        imm     : in std_logic_vector(7 downto 0);
	        Data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
          Data_out: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
          -- add ports as required
        );
end component;
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
   Generic ( 
		    DATA_WIDTH : integer := 8);
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

      generic (
      DATA_WIDTH        :     integer   := 16;     -- Word Width
      ADDR_WIDTH        :     integer   := 16      -- Address width
      );

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

-----------------
end Sys_Definition;

PACKAGE BODY Sys_Definition IS
	-- package body declarations

END PACKAGE BODY Sys_Definition;