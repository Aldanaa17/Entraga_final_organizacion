--------------------------------------------------------
--------- PDUA (component): -------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
--------------------------------------------------------
ENTITY PDUA_V IS
    GENERIC(MAX_WIDTH:	INTEGER	:=  8;
				ADDR_WIDTH : integer := 3);
	PORT(		clk				:  IN 	STD_LOGIC;
				rst				:  IN  	STD_LOGIC;
				bank_wr_en 		: 	IN 	STD_LOGIC;
				busb_addr		: 	IN  	STD_LOGIC_VECTOR(2	DOWNTO	0);
				busc_addr		: 	IN  	STD_LOGIC_VECTOR(2	DOWNTO	0);  				
				selop   			:  IN  	STD_LOGIC_VECTOR(2	DOWNTO	0);
				shamt	   		:  IN   	STD_LOGIC_VECTOR(1	DOWNTO	0);
				enaf	   		:  IN	   STD_LOGIC;
				mdr_alu_n		:	IN 	STD_LOGIC;
				mdr_en			:	IN		STD_LOGIC;
				sclr_ir			:	IN		STD_LOGIC;
				ir_en				:	IN 	STD_LOGIC;
				mar_en			:	IN		STD_LOGIC;
				BUS_DATA_IN 	: 	IN 	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				ADRRESS_BUS		:	OUT   STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				BUS_DATA_OUT 	: 	OUT 	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				TO_C_UNIT		:	OUT 	STD_LOGIC_VECTOR(4 DOWNTO 0);
				C,M,P,Z			:  OUT	STD_LOGIC); --Flags);
						
END ENTITY PDUA_V;

ARCHITECTURE rtl OF PDUA_V IS

SIGNAL bus_alu	 :	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL bus_A	 :	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL bus_B	 :	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL bus_C	 :	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);

BEGIN

	ALU: 		ENTITY work.ALU
	GENERIC MAP(MAX_WIDTH => MAX_WIDTH)
	PORT MAP(   clk		=>  clk,
					rst		=>  rst,
					busA		=>  bus_A,
					busB		=>  bus_B,
					selop   	=>  selop,
					shamt	   =>	 shamt,
					enaf	   =>	 enaf,
					busC	   =>  bus_alu,
					C			=>  C,
					M			=>  M,
					P			=>  P,
					Z			=>  Z);	
	MDR: ENTITY work.MDR
	GENERIC MAP(MAX_WIDTH    => 	MAX_WIDTH)
	PORT MAP(   clk 			 =>	clk,
					rst			 =>	rst,
					mdr_ena 		 =>  	mdr_en,  
					mdr_alu_n	 =>   mdr_alu_n,
					bus_alu		 =>	bus_alu,
					DATA_EX_in 	 =>	BUS_DATA_IN,
					Cbus 			 =>   bus_C,
					BUS_DATA_OUT =>	BUS_DATA_OUT);

	MAR: ENTITY work.MAR
	PORT MAP(  	clk			=>	clk,
					rst			=> rst,
					ena_mar 		=> mar_en,
					d_mar			=>	bus_C,
					q_mar			=> ADRRESS_BUS);
					
	IR: ENTITY work.IR_sclr
	PORT MAP(  	clk			=>	clk,
					rst			=> rst,
					ena_ir 		=> ir_en,
					sclr_ir	   => sclr_ir,
					d_ir     	=> bus_C(7 DOWNTO 3),
					q_ir			=> TO_C_UNIT);
					
	REGISTER_FILE: 		ENTITY work.register_file
	GENERIC MAP(DATA_WIDTH => MAX_WIDTH,
					ADDR_WIDTH => ADDR_WIDTH)
	PORT MAP(   clk		=>  clk,
					rst      =>  rst,
					wr_ena   => bank_wr_en,
					w_addr   => busc_addr,
					r_addr   => busb_addr,
					w_data   => bus_C,
					r_data   => bus_B,
					r_data_2 => bus_A);	
	
END ARCHITECTURE;