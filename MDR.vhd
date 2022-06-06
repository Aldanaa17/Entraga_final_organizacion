lIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------
ENTITY MDR IS
    GENERIC( MAX_WIDTH 	: integer:= 8);
    PORT( clk 				: IN STD_LOGIC;
	       rst 				: IN STD_LOGIC;
			 mdr_ena 		: IN STD_LOGIC;
			 mdr_alu_n		: IN STD_LOGIC;
			 bus_alu			: IN STD_LOGIC_VECTOR(MAX_WIDTH-1 downto 0);
			 DATA_EX_in 	: IN STD_LOGIC_VECTOR(MAX_WIDTH-1 downto 0);
			 Cbus 			: OUT STD_LOGIC_VECTOR(MAX_WIDTH-1 downto 0);
			 BUS_DATA_OUT 	: OUT STD_LOGIC_VECTOR(MAX_WIDTH-1 downto 0)
		  );
END ENTITY;
----------------------------------------------
ARCHITECTURE rtl of MDR IS
SIGNAL mdr_q : STD_LOGIC_VECTOR(MAX_WIDTH-1 downto 0);
SIGNAL busC_s : STD_LOGIC_VECTOR(MAX_WIDTH-1 downto 0);
BEGIN		 
	 
	 dff1: PROCESS(clk,rst,DATA_EX_in)
	 BEGIN
	    IF (rst='1') THEN
		   mdr_q <= (OTHERS	=> '0');
		 ELSIF (rising_edge(clk)) THEN
		    IF (mdr_ena='1') THEN
			   mdr_q <= DATA_EX_in;
			 END IF;
		 END IF;
	 END PROCESS;
	 
	 dff2: PROCESS(clk,rst,bus_alu)
	 BEGIN
	    IF (rst='1') THEN
			BUS_DATA_OUT <= (OTHERS	=> '0');
		 ELSIF (rising_edge(clk)) THEN
		    IF (mdr_ena='1') THEN
             BUS_DATA_OUT <= bus_alu;
			 END IF;
		 END IF;
	 END PROCESS;
	 
	 MUX: PROCESS(bus_alu,mdr_q,mdr_alu_n,busC_s)
	 BEGIN
	    IF mdr_alu_n = '1' THEN
		    busC_s <= mdr_q;
		 ELSE
		    busC_s <= bus_alu;
		 END IF;
	 END PROCESS;

Cbus <= busC_s;
	 
END ARCHITECTURE;