--This confidential and proprietary software may be used
--only as authorized by a licensing agreement from
--Laboratory for Smart Integrated Systems (SIS), VNU University of Engineering and Technology (VNU-UET).
-- (C) COPYRIGHT 2014 
-- ALL RIGHTS RESERVED
-- The entire notice above must be reproduced on all authorized copies.
--
-- Filename : Mux4to1.vhd
-- Author : Hung Nguyen
-- Date : 
-- Version : 0.1
-- Description : A processing Element.
--                
-- Modification History:
-- Date By Version Change Description
-- ========================================================
-- 05/08.2014  0.1 Original
-- ========================================================
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all ;
--use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.Sys_Definition.all;

ENTITY mux4to1 IS
   
   PORT (A, B, C, D: IN  	std_logic_vector (DATA_WIDTH - 1 downto 0);
        SEL : IN 	 std_logic_vector (1 downto 0);
        Z: OUT 	std_logic_vector (DATA_WIDTH - 1 downto 0)
               );
END mux4to1;
ARCHITECTURE mux4to1_behave OF mux4to1 IS
BEGIN
    -- write your code here
    with SEL select 
        Z <= A when "00",
             B when "01",
             C when "10",
             D when others;


END mux4to1_behave;

