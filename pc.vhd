library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity pc_unit is
port( 	D : in std_logic_vector(31 downto 0);
	reset: in std_logic;
	clk : in std_logic;
	Q:out std_logic_vector(31 downto 0));
end pc_unit;

architecture pc of pc_unit is
begin
process(D, reset, clk)
begin
if (reset = '1') then
	Q <= "00000000000000000000000000000000";
elsif(rising_edge(clk)) then
	Q <= D;
end if;


end process;
end pc;
