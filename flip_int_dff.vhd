LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------
ENTITY flip_int_dff IS

	PORT(		clk		:	IN		STD_LOGIC;
				rst		:	IN		STD_LOGIC;
				sclr_int	:	IN		STD_LOGIC;
				ena_int	:	IN		STD_LOGIC;
				d_int		:	IN 	STD_LOGIC;
				q_int		:	OUT	std_logic);
				
END flip_int_dff;
---------------------------------------------------
ARCHITECTURE rtl of flip_int_dff is
BEGIN

	dff:	PROCESS(clk, rst, d_int)
	BEGIN
		IF(rst = '1')THEN 
			q_int <= '0';
		ELSIF(rising_edge(clk)) THEN
			IF (ena_int = '1')THEN
				IF (sclr_int = '1') THEN
					q_int <= '0';
				ELSE 
					q_int <= d_int;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;