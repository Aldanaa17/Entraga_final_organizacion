LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------
ENTITY IR_sclr IS 
	PORT(		clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				ena_ir			:	IN		STD_LOGIC;
				sclr_ir			:	IN		STD_LOGIC;
				d_ir				:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				q_ir				:	OUT 	STD_LOGIC_VECTOR(4 DOWNTO 0));
END ENTITY;
----------------------------------
ARCHITECTURE rtl of IR_sclr is 
BEGIN 

	dff_ir: PROCESS(clk, rst, d_ir)
	BEGIN
		IF(rst = '1') THEN 
			q_ir <= (OTHERS => '0');
		ELSIF(rising_edge(clk))	THEN 
			IF	(ena_ir = '1')	THEN
				IF (sclr_ir = '1') THEN
					q_ir <= (OTHERS  => '0');
				ELSE 
					q_ir <= d_ir;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
END ARCHITECTURE;