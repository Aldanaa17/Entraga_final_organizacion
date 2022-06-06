LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------
ENTITY BLOQUES_tb IS
END ENTITY BLOQUES_tb;
-----------------------------------------------
ARCHITECTURE testbech of BLOQUES_tb IS
	SIGNAL clk_tb      :STD_LOGIC:='1';
	SIGNAL rst_tb      :    STD_LOGIC:='1';
	SIGNAL INT_tb      :    STD_LOGIC:='0';
BEGIN
clk_tb  <=  not clk_tb after 10 ns; --50 MHz clock

rst_tb  <= '0' after 10 ns;

--opcode_tb <= "00000" after 30 ns, ---FETCH
--				 "00011" after 110 ns, ---MOV ACC,CTE
--			    "00001" after 190 ns,---MOV ACC,A
--			    "00010" after 210 ns,---MOV A,ACC
--			    "01000" after 230 ns,---AND ACC,A
--				 "00100" after 250 ns,---MOV ACC,[DPTR]
--				 "00101" after 330 ns,---MOV DPTR,ACC
--				 "00110" after 350 ns,---MOV [DPTR],ACC
--				 "01001" after 410 ns,---ADD ACC,A
--				 "01010" after 430 ns,---JMP DIR
--				 "01011" after 510 ns,---JZ DIR
--				 "01100" after 590 ns,---JN DIR
--				 "01101" after 670 ns,---JC DIR
--				 "10001" after 750 ns,---XOR
--				 "10011" after 770 ns,---NEG
--				 "10101" after 790 ns;---SLR

BLOQUES_tb:  ENTITY WORK.BLOQUES
	PORT MAP (clk      => clk_tb,
				 rst      => rst_tb,
				 INT      => INT_tb);
END ARCHITECTURE;
