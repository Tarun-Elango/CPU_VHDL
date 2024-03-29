library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity se_unit is
port( input_p: in std_logic_vector(15 downto 0);
func_extend: in std_logic_vector(1 downto 0);
output_p: out std_logic_vector(31 downto 0));
end se_unit;
architecture SE of se_unit is
begin
process(input_p, func_extend)
begin
case func_extend is
when "00" =>
	output_p<= input_p(15 downto 0) & "0000000000000000";
when "01" =>
	if (input_p(15) = '0') then 
		output_p<= "0000000000000000" & input_p(15 downto 0);
	elsif(input_p(15)='1' ) then
		output_p<= "1111111111111111" & input_p(15 downto 0);
	else	
		output_p<= (others=> '-');
	end if;	
when "10" =>
	if (input_p(15) = '0') then 
		output_p<= "0000000000000000" & input_p(15 downto 0);
	elsif(input_p(15)='1' ) then
		output_p<= "1111111111111111" & input_p(15 downto 0);
	else
		output_p<= (others=> '-');
	end if;
when "11" =>
output_p<= "0000000000000000" & input_p(15 downto 0);
when others =>
output_p<= (others=> '-');
end case;
end process;
end SE;
