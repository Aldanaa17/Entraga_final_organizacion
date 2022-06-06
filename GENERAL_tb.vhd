LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------
ENTITY GENERAL_tb IS
END ENTITY GENERAL_tb;
-----------------------------------------------
ARCHITECTURE testbech of GENERAL_tb IS
	SIGNAL	clk_tb			:   	STD_LOGIC :='0';
	SIGNAL	rst_tb			:    	STD_LOGIC :='1';
	SIGNAL	strobe_tb		:   	STD_LOGIC :='0';
	SIGNAL	bank_wr_en_tb 	: 	 	STD_LOGIC :='1';
	SIGNAL 	busb_addr_tb	: 	 	STD_LOGIC_VECTOR(2	DOWNTO	0) := "000";
	SIGNAL	busc_addr_tb	: 	  	STD_LOGIC_VECTOR(2	DOWNTO	0) := "000";  				
	SIGNAL	selop_tb   		:    	STD_LOGIC_VECTOR(2	DOWNTO	0) := "000";
	SIGNAL	shamt_tb	   	:    	STD_LOGIC_VECTOR(1	DOWNTO	0) := "00";
	SIGNAL	enaf_tb	   	:     STD_LOGIC :='0';
	SIGNAL	mdr_alu_n_tb	:	 	STD_LOGIC :='0';
	SIGNAL	mdr_en_tb		:		STD_LOGIC :='0';
	SIGNAL	ir_en_tb			:		STD_LOGIC :='0';
	SIGNAL	mar_en_tb		:		STD_LOGIC :='0';
	SIGNAL	wr_rdn_tb		:		STD_LOGIC :='0';
	SIGNAL	TO_C_UNIT_tb	:	 	STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL   C_tb				:   	STD_LOGIC ;
	SIGNAL   M_tb				:   	STD_LOGIC;
	SIGNAL   P_tb				:   	STD_LOGIC;
	SIGNAL   Z_tb				:   	STD_LOGIC;
BEGIN

clk_tb  			<=  not clk_tb after 10ns; --50 MHz clock

rst_tb  			<=	'0' after 10ns;

strobe_tb         <= '1' after 30ns,
							'0' after 50ns; 
		  

GENERAL_tb:  ENTITY WORK.GENERAL
	PORT MAP ( 	clk			=>	clk_tb,
					rst			=>	rst_tb,
					bank_wr_en	=>	bank_wr_en_tb,
					busb_addr	=>	busb_addr_tb,
					busc_addr	=> busc_addr_tb, 				
					selop			=>	selop_tb,
					shamt			=>	shamt_tb,
					enaf			=> enaf_tb,
					mdr_alu_n	=>	mdr_alu_n_tb,
					mdr_en		=>	mdr_en_tb,
					ir_en			=> ir_en_tb,
					mar_en		=>	mar_en_tb,
					wr_rdn		=>	wr_rdn_tb,
					TO_C_UNIT	=>	TO_C_UNIT_tb,
					C				=>	C_tb,
					M				=>	M_tb,
					P				=>	P_tb,
					Z				=>	Z_tb);
					
BIST:   ENTITY WORK.MOV_DPT_ACC
		PORT MAP(	clk			=>	clk_tb,
					rst			=>	rst_tb,
					strobe      => strobe_tb,
					bank_wr_en	=>	bank_wr_en_tb,
					busB_addr   => busb_addr_tb,
					busC_addr   => busc_addr_tb, 				
					selop			=>	selop_tb,
					shamt			=>	shamt_tb,
					enaf			=> enaf_tb,
					mdr_alu_en	=>	mdr_alu_n_tb,
					mdr_en		=>	mdr_en_tb,
					ir_en			=> ir_en_tb,
					mar_en		=>	mar_en_tb,
					wr_rdn		=>	wr_rdn_tb);
	
END ARCHITECTURE;