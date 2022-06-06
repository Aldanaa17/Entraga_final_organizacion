LIBRARY ieee;
	USE ieee.std_logic_1164.all;
------------------------------------------------------------------------
ENTITY FETCH IS
	PORT	(		clk					: 	IN 	 STD_LOGIC;
					rst					:	IN	    STD_LOGIC;
					strobe            :  IN     STD_LOGIC;
					selop					: 	OUT 	 STD_LOGIC_VECTOR(2 DOWNTO 0);
					enaf					:  OUT	 STD_LOGIC;
					shamt             :  OUT    STD_LOGIC_VECTOR(1 DOWNTO 0);
					busB_addr         :  OUT    STD_LOGIC_VECTOR(2 DOWNTO 0);
					busC_addr         :  OUT    STD_LOGIC_VECTOR(2 DOWNTO 0);
					bank_wr_en        :  OUT    STD_LOGIC;
					mar_en            :  OUT    STD_LOGIC;
					ir_en             :  OUT    STD_LOGIC;
					mdr_en            :  OUT    STD_LOGIC;
					mdr_alu_en        :  OUT    STD_LOGIC;
					wr_rdn            :  OUT    STD_LOGIC);				
END ENTITY FETCH;
-------------------------------------------------------------------------
ARCHITECTURE fsmd OF FETCH IS
	TYPE state IS (idle, STATE_1, STATE_2, STATE_3, STATE_4);
	SIGNAL 	pr_state	: 	state;
	SIGNAL 	nx_state	: 	state;
BEGIN
	--===========================================
	--              FSM
	--===========================================
	-- Sequential Section ----------------------
	seq_fsm: PROCESS(clk, rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state <=idle;
		ELSIF(rising_edge(clk)) THEN
			pr_state <= nx_state;
		END IF;
	END PROCESS;
	
	-- Combinational Section ----------------------
	comb_fsm: PROCESS (pr_state, strobe)
	BEGIN
		
		CASE pr_state IS
		WHEN idle  =>
				enaf              <= '0';
				selop				  	<= "000";
				shamt             <= "00";
				busB_addr         <= "000";
				busC_addr         <= "000";
				bank_wr_en        <= '0';
				mar_en            <= '0';
				ir_en             <= '0';
				mdr_en            <= '0';
				mdr_alu_en        <= '0';
				wr_rdn            <= '0';
				IF (strobe = '1') THEN
					nx_state	<= STATE_1;
				ELSE
					nx_state	<= idle;
				END IF;
			---------------------------
--			WHEN STATE_0 =>
--            enaf              <= '0'
--				selop				  	<= "000";
--				shamt             <= "00";
--				busB_addr         <= "001";
--				busC_addr         <= "000";
--				bank_wr_en        <= '0';
--				mar_en            <= '1';
--				mdr_en            <= '0';
--				mdr_alu_en        <= '0';
--				wr_rdn            <= '0';
--				nx_state				<= STATE_1;
			---------------------------
			WHEN STATE_1 =>
				enaf              <= '0';
				selop				  	<= "000";
				shamt             <= "00";
				busB_addr         <= "000";
				busC_addr         <= "000";
				bank_wr_en        <= '0';
				mar_en            <= '1';
				ir_en             <= '0';
				mdr_en            <= '0';
				mdr_alu_en        <= '0';
				wr_rdn            <= '0';
				nx_state				<= STATE_2;
			---------------------------
			WHEN STATE_2 =>
				enaf              <= '0';
				selop				  	<= "110";
				shamt             <= "00";
				busB_addr         <= "000";
				busC_addr         <= "000";
				bank_wr_en        <= '1';
				mar_en            <= '0';
				ir_en             <= '0';
				mdr_en            <= '0';
				mdr_alu_en        <= '0';
				wr_rdn            <= '0';
				nx_state				<= STATE_3;
			---------------------------
			WHEN STATE_3 =>
				enaf              <= '0';
				selop				  	<= "000";
				shamt             <= "00";
				busB_addr         <= "000";
				busC_addr         <= "000";
				bank_wr_en        <= '0';
				mar_en            <= '0';
				ir_en             <= '0';
				mdr_en            <= '1';
				mdr_alu_en        <= '0';
				wr_rdn            <= '0';
				nx_state				<= STATE_4;
			---------------------------
			WHEN STATE_4 =>
				enaf              <= '0';
				selop				  	<= "000";
				shamt             <= "00";
				busB_addr         <= "000";
				busC_addr         <= "000";
				bank_wr_en        <= '0';
				mar_en            <= '0';
				ir_en             <= '1';
				mdr_en            <= '0';
				mdr_alu_en        <= '1';
				wr_rdn            <= '0';
				nx_state				<= idle;		
--			---------------------------
--			WHEN STATE_5 =>
--				enaf              <= '0'
--				selop				  	<= "000";
--				shamt             <= "00";
--				busB_addr         <= "000";
--				busC_addr         <= "000";
--				bank_wr_en        <= '0';
--				mar_en            <= '0';
--				mdr_en            <= '1';
--				mdr_alu_en        <= '0';
--				wr_rdn            <= '0';
--				nx_state				<= STATE_6;			
--			---------------------------
--			WHEN STATE_6 =>
--				enaf              <= '0'
--				selop				  	<= "110";
--				shamt             <= "00";
--				busB_addr         <= "001";
--				busC_addr         <= "001";
--				bank_wr_en        <= '1';
--				mar_en            <= '0';
--				mdr_en            <= '0';
--				mdr_alu_en        <= '0';
--				wr_rdn            <= '1';
--				nx_state				<= STATE_7;			
--			---------------------------
--			WHEN STATE_7 =>
--				enaf              <= '0'
--				selop				  	<= "001";
--				shamt             <= "00";
--				busB_addr         <= "100";
--				busC_addr         <= "000";
--				bank_wr_en        <= '1';
--				mar_en            <= '0';
--				mdr_en            <= '0';
--				mdr_alu_en        <= '0';
--				wr_rdn            <= '1';
--				nx_state			<= idle;			
			---------------------------
		END CASE;
	END PROCESS;
END ARCHITECTURE fsmd; 