LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------
ENTITY second_MUX IS
	PORT(		load  	 		:	IN		STD_LOGIC;
				offset		 	:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				result		 	:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				q					:	OUT	STD_LOGIC_VECTOR(2 DOWNTO 0));
				
END second_MUX;
---------------------------------------------------
ARCHITECTURE concurrente of second_MUX is
BEGIN 
	WITH load SELECT 
	q		   <= result 		WHEN '0',
					offset 		WHEN OTHERS; 
END concurrente;