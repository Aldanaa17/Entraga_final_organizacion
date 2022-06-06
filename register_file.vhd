LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-----------------------------------------------------
ENTITY register_file IS
   GENERIC( DATA_WIDTH : integer:= 8;
	         ADDR_WIDTH : integer:= 3);
	PORT(    clk        : IN    STD_LOGIC;
				rst		  : IN    STD_LOGIC;
	         wr_ena     : IN    STD_LOGIC;
				w_addr     : IN    STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
	         r_addr     : IN    STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
	         w_data     : IN    STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				r_data     : OUT   STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				r_data_2   : OUT   STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)
	);
END ENTITY;
-------------------------------------------------------
ARCHITECTURE rtl of register_file IS
   TYPE mem_type is ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg: mem_type;
	
	CONSTANT INIT_PC 		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := "00000001";
	CONSTANT INIT_SP 		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := "11111111";
	CONSTANT INIT_DPTR 	: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := "00000001";
	CONSTANT INIT_A 		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := "00001010";
	CONSTANT INIT_AVI 	: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := "00000000";
	CONSTANT INIT_TEMP 	: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := "00000000";
	CONSTANT INIT_CTE		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := "11111111";
	CONSTANT INIT_ACC		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := "00011010";
	
BEGIN
   --WRITE PROCESS
	write_process: PROCESS(clk,rst)
	BEGIN
	IF(rst='1') THEN 
		array_reg(0)<= INIT_PC;--PC
		array_reg(1)<= INIT_SP;--default
		array_reg(2)<= INIT_DPTR;--
		array_reg(3)<= INIT_A;--A
		array_reg(4)<= INIT_AVI;--
		array_reg(5)<= INIT_TEMP;--
		array_reg(6)<= INIT_CTE;-- CONSTANTE -1
		array_reg(7)<= INIT_ACC;--ACC
	   ELSIF (rising_edge(clk)) THEN
		   IF (wr_ena = '1') THEN 
			    array_reg(to_integer(unsigned(w_addr)))<= w_data;
			END IF;
		END IF;
	END PROCESS;
	
	--READ
	r_data <= array_reg(to_integer(unsigned(r_addr)));
	r_data_2 <= array_reg(7);
	

END ARCHITECTURE;
