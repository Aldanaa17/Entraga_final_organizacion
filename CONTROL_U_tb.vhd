--LIBRARY IEEE;
--USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------
--ENTITY CONTROL_U_tb IS
--END ENTITY CONTROL_U_tb;
-------------------------------------------------
--ARCHITECTURE testbech of CONTROL_U_tb IS
--	SIGNAL clk_tb      :    STD_LOGIC:='0';
--	SIGNAL rst_tb      :    STD_LOGIC:='1';
--	SIGNAL d_UPC_tb    :    STD_LOGIC_VECTOR(2 DOWNTO 0);
--	SIGNAL opcode_tb   :    STD_LOGIC_VECTOR(4 DOWNTO 0);
--	SIGNAL INT_tb      :    STD_LOGIC:='0';
--	SIGNAL sclr_int_tb :    STD_LOGIC:='0';
--	SIGNAL C_tb        :    STD_LOGIC:='1';
--	SIGNAL M_tb        :    STD_LOGIC:='1';
--	SIGNAL Z_tb        :    STD_LOGIC:='1';
--	SIGNAL P_tb        :    STD_LOGIC:='1';
--   SIGNAL UINS_tb     :    STD_LOGIC_VECTOR(20 DOWNTO 0);
--BEGIN
--clk_tb  <=  not clk_tb after 10 ns; --50 MHz clock
--
--rst_tb  <= '0' after 10 ns;
--
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
--
--CONTROL_U_tb:  ENTITY WORK.CONTROL_U
--	PORT MAP (clk      => clk_tb,
--				 rst      => rst_tb,
--				 d_UPC    => d_UPC_tb,
--				 opcode   => opcode_tb,
--				 INT      => INT_tb,
--				 sclr_int => sclr_int_tb,
--				 C       =>  C_tb,
--				 M       =>  M_tb,
--				 Z       =>  Z_tb,
--				 P       =>  P_tb);
--END ARCHITECTURE;
