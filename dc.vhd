library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity dc_unit is 
port(add: in std_logic_vector(4 downto 0);
reset : in std_logic;
clk : in std_logic;
data_write: std_logic;
d_in: in std_logic_vector(31 downto 0);
d_out: out std_logic_vector(31 downto 0));
end dc_unit;
architecture DC of dc_unit is
type d_array is array(31 downto 0) of std_logic_vector(31 downto 0);
signal sig : d_array;
begin
d_out<= sig(conv_integer(add));
process(add, reset, clk, data_write, d_in)
begin
if(reset = '1') then
	for i in sig' range loop
		sig(i)<= (others=>'0');
	end loop;
elsif(rising_edge(clk)) then
	if(data_write = '1') then
		sig(conv_integer(add))<= d_in;
	end if;
end if;
end process;
end DC;




