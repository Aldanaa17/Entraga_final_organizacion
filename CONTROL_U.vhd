---------------------------------------------------------
--------- CONTROL UNIT (component): ---------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
--------------------------------------------------------
ENTITY CONTROL_U IS
	PORT(		clk			:  IN 	STD_LOGIC;
				rst			:  IN  	STD_LOGIC;
				Z  	 		:	IN		STD_LOGIC;
				M		 		:	IN		STD_LOGIC;
				C		 		:	IN		STD_LOGIC;
				P		 		:	IN    STD_LOGIC;
				INT	 		:	IN		STD_LOGIC;
				opcode      :  IN    STD_LOGIC_VECTOR(4 DOWNTO 0);
				UINS        :  OUT   STD_LOGIC_VECTOR(20 DOWNTO 0)); 
						
END ENTITY CONTROL_U;

ARCHITECTURE rtl OF CONTROL_U IS
	
SIGNAL S_LOAD	 	:	STD_LOGIC;
SIGNAL S_RESULT	:	STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL S_UPC		:	STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL S_QUPC		:	STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL S_addr     :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL S_offset   :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL S_JCOND    :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL S_en_UPC   :  STD_LOGIC;
SIGNAL S_clr_UPC  :  STD_LOGIC; 
SIGNAL UInstruction: STD_LOGIC_VECTOR(28 DOWNTO 0);
BEGIN

S_addr   	<=  opcode & S_QUPC;
S_en_UPC 	<=  UInstruction(7);
S_clr_UPC	<=  UInstruction(6);
S_JCOND  	<=  (UInstruction(5 DOWNTO 3));
S_offset 	<=  (UInstruction(2 DOWNTO 0));

	Jcond: ENTITY work.Jcond
	PORT MAP(	Z  	 			=>		Z,
					M		 			=>		M,
					C		 			=>		C,
					P		 			=>    P,
					INT	 			=>		INT,
					J_COND 			=>		S_JCOND,
					q_J_COND			=> 	S_LOAD);

	second_MUX: ENTITY work.second_MUX
	PORT MAP(  	load  	 		=> 	S_LOAD,
					offset		 	=>		S_offset,
					result		 	=>		S_RESULT,
					q					=>		S_UPC);
			
	UPC: ENTITY work.UPC
	PORT MAP(  	clk				=>	clk,
					rst				=> rst,
					ena_UPC			=> S_en_UPC,
					sclr_UPC			=> S_clr_UPC,
					d_UPC				=> S_UPC,
					q_UPC				=> S_QUPC);
					
	add_sub_control:	ENTITY work.add_sub_control
	PORT MAP(   dataa  	 		=>	S_QUPC,
					datab		 		=>	"001",
					addn_sub			=>	'0',
					result			=>	S_RESULT);	
					
	ROM:   ENTITY work.uProgramMemory
	PORT MAP(	uaddr	         => S_addr,
					UI		 			=> UInstruction);
					
	UINS <= UInstruction(28 DOWNTO 8);
	
END ARCHITECTURE;