LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------
ENTITY Jcond IS
	PORT(		Z  	 		:	IN		STD_LOGIC;
				M		 		:	IN		STD_LOGIC;
				C		 		:	IN		STD_LOGIC;
				P		 		:	IN    STD_LOGIC;
				INT	 		:	IN		STD_LOGIC;
				J_COND 		: 	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				q_J_COND		:	OUT	std_logic);
				
END Jcond;
---------------------------------------------------
ARCHITECTURE concurrente of Jcond is
BEGIN 
	WITH 	J_COND SELECT 
	q_J_COND <= '0' 		WHEN "000",
					'1' 		WHEN "001",
					 Z			WHEN "010",
					 M  		WHEN "011",
					 C			WHEN "100",
					 P			WHEN "101",
					 INT		WHEN "110",
					'0' 		WHEN OTHERS; 
END concurrente;