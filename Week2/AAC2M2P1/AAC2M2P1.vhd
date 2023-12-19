LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 				-- clock
   SR:  in std_logic;  				-- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  	-- Parallel input
   PE:   in std_logic;  			-- Parallel Enable (Load)
   CEP: in std_logic;  				-- Count enable parallel input
   CET:  in std_logic; 				-- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  			-- Terminal Count
);            		
end AAC2M2P1;

architecture internal of AAC2M2P1 is

signal cnt: unsigned(3 downto 0);
signal cenable: std_logic;
begin
	cenable <= CEP and CET and PE;
	process (CP, SR, PE)
	begin
	if(CP'event and rising_edge(CP)) then
		if(SR = '0') then
			cnt <= "0000";
	
		elsif (PE = '0') then
			cnt <= unsigned(P);
		elsif(cenable = '1') then
			cnt <= cnt +1;
		end if;
	end if; 
	end process;
	
	Q <= std_logic_vector(cnt);
	TC <= (Q(0) and Q(1) and Q(2) and Q(3) and CET);
end internal;