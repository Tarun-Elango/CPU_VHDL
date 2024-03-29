library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity next_address is
port( rs, rt: in std_logic_vector(31 downto 0);
pc : in std_logic_vector(31 downto 0);
target_address :in std_logic_vector(25 downto 0);
branch_type: in std_logic_vector(1 downto 0);
pc_sel: in std_logic_vector(1 downto 0);
next_pc : out std_logic_vector(31 downto 0));
end next_address;

architecture unit of next_address is
signal internal_sig : std_logic_vector(31 downto 0);
-- stores the value returned by the branch_type functionality
begin

process(rs, rt, pc, target_address, branch_type, pc_sel, internal_sig)
begin

--pc select functionality
case pc_sel is 
when "00" =>
	next_pc <= internal_sig;

when "01" =>
	next_pc <= "000000" & target_address(25 downto 0);
	--6 zeroes padded to target address when jump	

when "10" =>
	next_pc <= rs;

when others  =>
next_pc<= (others=> '-');
end case;



--branch_type fucntionality

case branch_type is 
when "00"=>
	internal_sig<= pc + x"00000001";
	--pc +1

when "01"=>
	if (rs= rt) then
		--check for target_address sign bit and extend accordingly , while adding pc and 1
		if (target_address(15) ='0')then
			internal_sig<= pc+ x"00000001" + ("0000000000000000"&target_address(15 downto 0));
		elsif(target_address(15) ='1') then
			internal_sig<= pc + x"00000001" +("1111111111111111"&target_address(15 downto 0));
		else
		     internal_sig<=(others=> '-');
		end if;
	else
	internal_sig<=pc+ x"00000001";
	--pc +1
	end if;
when "10"=> 
	if(rs/=rt) then
		if (target_address(15)='0')then
			internal_sig<= pc+ x"00000001" + ("0000000000000000"&target_address(15 downto 0));
		elsif(target_address(15) ='1') then
			internal_sig<= pc + x"00000001" +("1111111111111111"&target_address(15 downto 0));
		else
		       internal_sig<=(others=> '-');
		end if;
	
	else
	internal_sig<=pc +x"00000001";
	end if;
when "11"=>
	if(rs<0) then
		if (target_address(15) ='0')then
			internal_sig<= pc+ x"00000001" + ("0000000000000000"&target_address(15 downto 0));
		elsif(target_address(15) ='1') then
			internal_sig<= pc + x"00000001" +("1111111111111111"&target_address(15 downto 0));
		else
		   internal_sig<=(others=> '-');
		end if;
		
	else
	internal_sig<=pc+x"00000001";
 	end if;
when others=>
--here 
		 internal_sig<=(others=> '-');
			--internal sig <= pc;
end case;



end process;
end unit;
