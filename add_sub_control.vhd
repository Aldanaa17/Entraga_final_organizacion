-----------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------
ENTITY add_sub_control IS
	PORT(		dataa  	 				:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				datab		 				:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				addn_sub				 	:	IN		STD_LOGIC;
				result					:	OUT	STD_LOGIC_VECTOR(2 DOWNTO 0);	
		      cout	      			:	OUT   STD_LOGIC);	
END add_sub_control;
-----------------------------------------------------
-----------------------------------------------------
ARCHITECTURE rtl OF add_sub_control IS
	SIGNAL   bxor            :  STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL   add_nsub_vector :  STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    -- Create a vector with the value of addn_sub input
	vector_generation: FOR i IN 2 DOWNTO 0 GENERATE
		add_nsub_vector(i) <= addn_sub;
	END GENERATE;
	bxor <= datab XOR add_nsub_vector;
	
	-- Adder instantiation
	adder: ENTITY work.nbit_adder_control
	PORT MAP (   a    => dataa,
					 b    => bxor,
					 cin  => addn_sub,
					 s    => result,
					 cout => cout);
END ARCHITECTURE;