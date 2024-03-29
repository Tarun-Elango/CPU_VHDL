library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ic_unit is 
port( input_port: in std_logic_vector(4 downto 0);
output_port: out std_logic_vector(31 downto 0));
end ic_unit;
architecture IC of ic_unit is 
begin
process(input_port)
begin
case input_port is
	when "00000" => output_port <= "00100000000000110000000000000000"; 
	when "00001" => output_port <= "00100000000000010000000000000000"; 
	when "00010" => output_port <= "00100000000000100000000000000011"; 
	when "00011" => output_port <= "00000000001000100000100000100000"; 
	when "00100" => output_port <= "00100000010000101111111111111111";  
	when "00101" => output_port <= "00010000010000110000000000000001";  
	when "00110" => output_port <= "00001000000000000000000000000011";  
	when "00111" => output_port <= "10101100000000010000000000000000";  
	when "01000" => output_port <= "10001100000001000000000000000000";  
	when "01001" => output_port <= "00110000100001000000000000001010";  
	when "01010" => output_port <= "00000000100000110010000000100100";  
	when others  => output_port <= "00000000000000000000000000000000"; -- dont care
end case;
end process;
end IC;
