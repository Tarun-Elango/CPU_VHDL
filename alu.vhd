library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity alu is 
port(x, y : in std_logic_vector(31 downto 0);
add_sub: in std_logic;
logic_func: in std_logic_vector(1 downto 0);
func: in std_logic_vector(1 downto 0);

output: out std_logic_vector(31 downto 0);
overflow: out std_logic;
zero : out std_logic);
end alu;

architecture unit of alu is
signal addsub: std_logic_vector(31 downto 0);
signal logic_out: std_logic_vector(31 downto 0);

begin
process(x, y, addsub, logic_out,func, add_sub,logic_func ) is
begin

case logic_func is

when "00" => 
logic_out<= x and y;

when "01"=>
logic_out<= x or y;

when "10"=>
logic_out<= x xor y;

when "11"=>
logic_out<= x nor y;

when others => null;
end case; 

--adder_subtract

case add_sub is 
when '0' => 
addsub<=x+y;
--check overflow
if(( (x(31) xnor y(31)) and  ( y(31) xor addsub(31)))= '1' ) then
overflow <='1';

else
overflow<='0'; 
end if;

when '1' =>
addsub<= x-y;
--overflow
if( ( (x(31) xnor y(31)) and (y(31) xor addsub(31)))  =  '1')  then
overflow<='1';
else
overflow<='0';
end if;

when others=> null;
end case;

if (addsub = "00000000000000000000000000000000") then 
	zero <= '1' ;
else 
	zero <= '0'; 
end if;

--mux 
case func is 

when "00" => 
output <= y (31 downto 0);

when "01" =>
--set 000 and value of addsub(2) i.e the msb
if(x<y) then
output<= "00000000000000000000000000000001" ; --MSB set to '1' depending on if x<y
else
output<="00000000000000000000000000000000";
end if;

when "10" => 
output<= addsub;


when "11" =>
output<= logic_out;

when others => null;
end case;
end process;
end architecture;
