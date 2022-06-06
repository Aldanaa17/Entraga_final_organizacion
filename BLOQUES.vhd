--------------------------------------------------------
--------- GENERAL (component): -------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
--------------------------------------------------------
ENTITY BLOQUES IS
   GENERIC (MAX_WIDTH:	INTEGER	:=  8;
				ADDR_WIDTH : integer := 3);
	PORT(		clk			:  IN 	STD_LOGIC;
				rst			:  IN  	STD_LOGIC;
				INT		   :	IN		STD_LOGIC);
   
END ENTITY BLOQUES;

ARCHITECTURE rtl OF BLOQUES IS

SIGNAL BUS_DATA_IN 	: 	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL ADRRESS_BUS	:	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL BUS_DATA_OUT 	:  STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL S_C				:	STD_LOGIC;
SIGNAL S_M				:	STD_LOGIC;
SIGNAL S_P				:	STD_LOGIC;
SIGNAL S_Z				:	STD_LOGIC;
SIGNAL S_INT		   :	STD_LOGIC;
SIGNAL S_TO_C_UNIT	:	STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL S_UINS 			:	STD_LOGIC_VECTOR(20 DOWNTO 0);
BEGIN

	PDUA_V: 		ENTITY work.PDUA_V
	GENERIC MAP(MAX_WIDTH => MAX_WIDTH,
					ADDR_WIDTH => ADDR_WIDTH)
	PORT MAP(clk			=>  clk,
				rst			=>  rst,
				enaf	   	=>  S_UINS(20),
				selop   		=>  S_UINS(19 DOWNTO 17),
				shamt	   	=>  S_UINS(16 DOWNTO 15),
				busb_addr	=>  S_UINS(14 DOWNTO 12),
				busc_addr	=>  S_UINS(11 DOWNTO 9),
				bank_wr_en 	=>  S_UINS(8),
				mar_en		=>  S_UINS(7),
				mdr_en		=>  S_UINS(6),
				mdr_alu_n	=>  S_UINS(5),
				ir_en			=>  S_UINS(1),
				sclr_ir		=>  S_UINS(0),
				BUS_DATA_IN =>  BUS_DATA_IN,
				ADRRESS_BUS	=>	 ADRRESS_BUS,
				BUS_DATA_OUT => BUS_DATA_OUT,
				TO_C_UNIT   =>  S_TO_C_UNIT,
				C				=>  S_C,
				M				=>  S_M,
				P				=>  S_P,
				Z				=>  S_Z);
				
				
	CONTROL_U : ENTITY work. CONTROL_U 
	PORT MAP(clk			=>  clk,
				rst			=>  rst,
				C				=>  S_C,
				M				=>  S_M,
				P				=>  S_P,
				Z				=>  S_Z,
				INT	 		=>  S_INT,
				opcode      =>  S_TO_C_UNIT,
				UINS        =>  S_UINS);
		
	flip_int_dff: 		ENTITY work.flip_int_dff
	PORT MAP(	clk				=>  	clk,
					rst				=> 	rst,
					sclr_int			=>		S_UINS(4),
					ena_int			=>		INT,
					d_int				=>		'1',
					q_int				=>		S_INT);
					
	
	my_SPRAM:  	ENTITY work. my_SPRAM
	GENERIC MAP(DATA_WIDTH => MAX_WIDTH,
					ADDR_WIDTH => MAX_WIDTH)
	PORT MAP(	clk		  => CLK,
					wr_rnd 	  => S_UINS(2),
					addR		  => ADRRESS_BUS,
					W_data	  => BUS_DATA_OUT,
					r_data	  => BUS_DATA_IN);
					
END ARCHITECTURE;