--------------------------------------------------------
--------- GENERAL (component): -------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
--------------------------------------------------------
ENTITY GENERAL IS
   GENERIC (MAX_WIDTH:	INTEGER	:=  8;
				ADDR_WIDTH : integer := 3);
	PORT(		clk			:  IN 	STD_LOGIC;
				rst			:  IN  	STD_LOGIC;
				bank_wr_en 	: 	IN 	STD_LOGIC;
				busb_addr	: 	IN  	STD_LOGIC_VECTOR(2	DOWNTO	0);
				busc_addr	: 	IN  	STD_LOGIC_VECTOR(2	DOWNTO	0);  				
				selop   		:  IN  	STD_LOGIC_VECTOR(2	DOWNTO	0);
				shamt	   	:  IN   	STD_LOGIC_VECTOR(1	DOWNTO	0);
				enaf	   	:  IN	   STD_LOGIC;
				mdr_alu_n	:	IN 	STD_LOGIC;
				mdr_en		:	IN		STD_LOGIC;
				ir_en			:	IN 	STD_LOGIC;
				mar_en		:	IN		STD_LOGIC;
				wr_rdn		:	IN		STD_LOGIC;
				TO_C_UNIT	:	OUT 	STD_LOGIC_VECTOR(4 DOWNTO 0);
				C,M,P,Z	:  OUT	STD_LOGIC); --Flags);
						
END ENTITY GENERAL;

ARCHITECTURE rtl OF GENERAL IS

SIGNAL BUS_DATA_IN 	: 	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL ADRRESS_BUS	:	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL BUS_DATA_OUT 	:  STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
BEGIN

	PDUA: 		ENTITY work.PDUA
	GENERIC MAP(MAX_WIDTH => MAX_WIDTH,
					ADDR_WIDTH => ADDR_WIDTH)
	PORT MAP(		clk			=>  clk,
				rst			=>  rst,
				bank_wr_en 	=>  bank_wr_en,
				busb_addr	=>  busb_addr,
				busc_addr	=>  busc_addr,				
				selop   		=>  selop,
				shamt	   	=>  shamt,
				enaf	   	=>  enaf,
				mdr_alu_n	=>  mdr_alu_n,
				mdr_en		=>  mdr_en,
				ir_en			=>  ir_en,
				mar_en		=>  mar_en,
				wr_rdn		=>	 wr_rdn,
				BUS_DATA_IN =>  BUS_DATA_IN,
				ADRRESS_BUS	=>	 ADRRESS_BUS,
				BUS_DATA_OUT => BUS_DATA_OUT,
				TO_C_UNIT   =>  TO_C_UNIT,
				C				=>  C,
				M				=>  M,
				P				=>  P,
				Z				=>  Z);
				
				
	my_SPRAM:  	ENTITY work. my_SPRAM
	GENERIC MAP(DATA_WIDTH => MAX_WIDTH,
					ADDR_WIDTH => MAX_WIDTH)
	PORT MAP(	clk		  => CLK,
					wr_rnd 	  => wr_rdn,
					addR		  => ADRRESS_BUS,
					W_data	  => BUS_DATA_OUT,
					r_data	  => BUS_DATA_IN);
					
END ARCHITECTURE;