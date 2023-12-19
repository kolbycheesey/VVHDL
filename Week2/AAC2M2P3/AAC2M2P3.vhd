library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

-- State A (00): if 0 then A else B  -> out = 0 --
-- State B (01): if 1 then B else C  -> out = 0 --
-- State C (10): if 0 then C else A  -> out = 1 --

architecture fsmarch of FSM is
signal State: std_logic_vector(1 downto 0);

begin StateMachine : process(CLK, RST)
begin
	if(RST = '1') then
		State <= "00";
		Out1 <= '0';
	end if;
	if (State = "10") then
		Out1 <= '1';
	else
		Out1 <= '0';
	end if;
	if(rising_edge(CLK)) then
		case State is
			when "00" =>
				if(In1 = '1') then
					State <= "01";
				else
					State <= "00";
				end if;
			when "01" =>
				if(In1 = '1') then
					State <= "01";
				else
					State <= "10";
				end if; 
			when "10" =>
				if(In1 = '1') then
					State <= "00";
				else
					State <= "10";
				end if;
			when others =>
				State <= "00";
		end case;
	end if;
end process;
end fsmarch;