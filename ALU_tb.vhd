LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------
ENTITY ALU_tb IS
END ENTITY ALU_tb;
-----------------------------------------------
ARCHITECTURE testbech of ALU_tb IS
	SIGNAL clk_tb   :    STD_LOGIC:='0';
	SIGNAL rst_tb   :    STD_LOGIC:='1';
	SIGNAL busA_tb  :    STD_LOGIC_VECTOR(7 DOWNTO 0):="01100100";
	SIGNAL busB_tb  :    STD_LOGIC_VECTOR(7 DOWNTO 0):="00110010";
	SIGNAL selop_tb :    STD_LOGIC_VECTOR(2 DOWNTO 0):="000";
	SIGNAL shamt_tb :    STD_LOGIC_VECTOR(1 DOWNTO 0):="00";
	SIGNAL enaf_tb  :    STD_LOGIC:='1';
	SIGNAL busC_tb  :    STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL C_tb     :    STD_LOGIC;
	SIGNAL M_tb     :    STD_LOGIC;
	SIGNAL Z_tb     :    STD_LOGIC;
	SIGNAL P_tb     :    STD_LOGIC;
BEGIN
clk_tb  <=  not clk_tb after 10 ns; --50 MHz clock

busA_tb <= "01100100" after 30 ns,
			  "01100100" after 90 ns,
			  "01100100" after 150 ns,
			  "01100100" after 210 ns,
			  "01100100" after 270 ns,
			  "01100100" after 330 ns,
			  "01100100" after 390 ns,
			  "01100100" after 450 ns,
			  "01100100" after 510 ns,
			  "01100100" after 570 ns;
			  
busB_tb <= "00110010" after 30 ns,
			  "00110010" after 90 ns,
			  "00110010" after 150 ns,
			  "00110010" after 210 ns,
			  "00110010" after 270 ns,
			  "00110010" after 330 ns,
			  "00110010" after 390 ns,
			  "00110010" after 450 ns,
			  "00110010" after 510 ns,
			  "00110010" after 570 ns;
			  
rst_tb  <= '1' after 10 ns,
           '0' after 20 ns;

enaf_tb <= '1' after 30 ns,
	        '0' after 70 ns,
			  '1' after 90 ns,
	        '0' after 130 ns,
			  '1' after 150 ns,
	        '0' after 190 ns,
			  '1' after 210 ns,
			  '0' after 250 ns,
			  '1' after 270 ns,
	        '0' after 310 ns,
			  '1' after 330 ns,
	        '0' after 370 ns,
			  '1' after 390 ns,
	        '0' after 430 ns,
			  '1' after 450 ns,
	        '0' after 490 ns,
			  '1' after 510 ns,
	        '0' after 550 ns,
			  '1' after 570 ns,
	        '0' after 610 ns,
			  '1' after 630 ns,
	        '0' after 670 ns;
				  
shamt_tb <= "00" after 30 ns,
				"00" after 90 ns,
				"00" after 150 ns,
				"00" after 210 ns,
				"00" after 270 ns,
				"00" after 330 ns,
				"00" after 390 ns,
				"01" after 450 ns,
				"10" after 510 ns,
				"00" after 570 ns;
							
selop_tb <=
          "001" after 30 ns,   --INV
          "101" after 90 ns,   --ADD
          "010" after 150 ns,  --AND
          "011" after 210 ns,  --OR
          "100" after 270 ns,  --XOR
          "110" after 330 ns,  --INC
          "111" after 390 ns,  --NEG
          "000" after 450 ns,  --SLR   
          "000" after 510 ns,  --SLL 
          "000" after 570 ns;  --nothing
		

ALU_tb:  ENTITY WORK.ALU
	PORT MAP (clk      => clk_tb,
				 rst      => rst_tb,
				 busA     => busA_tb,
				 busB     => busB_tb,
				 selop    => selop_tb,
				 shamt    => shamt_tb,
				 enaf     => enaf_tb,
				 busC     => busC_tb,
				 C       =>  C_tb,
				 M       =>  M_tb,
				 Z       =>  Z_tb,
				 P       =>  P_tb);
END ARCHITECTURE;
