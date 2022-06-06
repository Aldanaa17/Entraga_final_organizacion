LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------
ENTITY MAR IS 
	PORT ( 	clk	:	IN STD_LOGIC;
	         rst	:	IN STD_LOGIC;
				ena_mar 	: 	IN STD_LOGIC;
				d_mar		:  IN	STD_LOGIC_VECTOR( 7 DOWNTO 0);
				q_mar		:	OUT STD_LOGIC_VECTOR( 7 DOWNTO 0));
			
END ENTITY;
----------------------------------
ARCHITECTURE rtl of MAR is 
BEGIN

		dff_mar: PROCESS(clk, rst, d_mar)
		BEGIN
			IF(rst ='1') THEN
				q_mar<= (OTHERS	=> '0');
			ELSIF (rising_edge(clk)) THEN
				IF (	ena_mar = '1') THEN
					 q_mar <= d_mar;
				END IF;
			END IF;
			
		END PROCESS;
		
END ARCHITECTURE;