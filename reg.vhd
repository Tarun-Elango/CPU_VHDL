library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity regunit is 
port( din : std_logic_vector(31 downto 0);
reset : in std_logic;
clk: in std_logic;
write : in std_logic;
read_a: in std_logic_vector(4 downto 0);
read_b: in std_logic_vector(4 downto 0);
write_address : in std_logic_vector(4 downto 0);
out_a: out std_logic_vector(31 downto 0);
out_b: out std_logic_vector(31 downto 0));
end regunit;

architecture unit of regunit is 

type reg_array is array (31 downto 0) of std_logic_vector(31 downto 0);
signal sig: reg_array;
begin
out_a<=sig(conv_integer(read_a));
out_b<=sig(conv_integer(read_b));

process (din, write_address, write, reset,clk,sig)
begin


if(reset='1') then
-- reset entire register file asynchronously
for i in sig' range loop
	sig(i)<= (others=>'0');
end loop;





elsif (rising_edge(clk)and write='1') then 
	
		--write values of din into address specified by write_address
       
	sig(conv_integer(write_address))<= din;	


else
--
end if;

end process;
end unit;
