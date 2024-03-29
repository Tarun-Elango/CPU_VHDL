library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity cpu_unit is 
port(resetMain : in std_logic;
clk : in std_logic; 
rs_out, rt_out: out std_logic_vector(3 downto 0);
pc_out: out std_logic_vector(3 downto 0);
overflowMain, zeroMain : out std_logic);
end cpu_unit;

architecture cpu of cpu_unit is
--signals for control unit / internal connections
signal reg_dstS, alu_srcS , add_subS, reg_in_srcS, data_writeS,reg_writeS: std_logic;
signal pc_selS, branch_typeS, alufuncS, alulogicfuncS : std_logic_vector(1 downto 0);
Signal next_pcS,nanextS, instS, regoutaS, regoutbS, alusrc, aluOS, dcacheOS, seOS, regiS: std_logic_vector(31 downto 0);
signal control_values: std_logic_vector(13 downto 0);
signal reddstS: std_logic_vector(4 downto 0);
signal opcode, funcfive: std_logic_vector(5 downto 0);

--components declare
component pc_unit is
port(D: in std_logic_vector(31 downto 0);
reset: in std_logic;
clk:in std_logic;
Q:out std_logic_vector(31 downto 0));
end component;

component next_address is 
port(rs, rt: in std_logic_vector(31 downto 0);
pc : in std_logic_vector(31 downto 0);
target_address: in std_logic_vector (25 downto 0);
branch_type : in std_logic_vector(1 downto 0);
pc_sel : in std_logic_vector(1 downto 0);
next_pc : out std_logic_vector( 31 downto 0));
end component;


component ic_unit is
port(input_port: in std_logic_vector(4 downto 0);
output_port: out std_logic_vector(31 downto 0));
end component;

component regunit is 
port( din : in std_logic_vector(31 downto 0);
reset : in std_logic;
clk : in std_logic;
write: in std_logic;
read_a: in std_logic_vector(4 downto 0);
read_b : in std_logic_vector(4 downto 0);
write_address: in std_logic_vector(4 downto 0);
out_a: out std_logic_vector(31 downto 0);
out_b : out std_logic_vector( 31 downto 0));
end component;

component alu is 
port(x,y : in std_logic_vector(31 downto 0);
add_sub: in std_logic;
logic_func : in std_logic_vector(1 downto 0);
func: in std_logic_vector(1 downto 0);

output: out std_logic_vector(31 downto 0);
overflow: out std_logic;
zero : out std_logic);
end component;

component dc_unit is
port(add: in std_logic_vector( 4 downto 0);
reset : in std_logic;
clk : in std_logic;
data_write: std_logic; 
d_in: in std_logic_vector(31 downto 0);
d_out :out std_logic_vector(31 downto 0));
end component;
 
component se_unit is
port(input_p: in std_logic_vector(15 downto 0);
func_extend: in std_logic_vector(1 downto 0);
output_p: out std_logic_vector(31 downto 0));
end component;

for PCC: pc_unit use entity WORK.pc_unit(pc);
for NA: next_address use entity WORK.next_address(unit);
for ICACHE: ic_unit use entity WORK.ic_unit(IC);
for REG: regunit use entity WORK.regunit(unit);
for ALU_C : alu use entity WORK.alu(unit);
for dc_C : dc_unit use entity WORK.dc_unit(DC);
for SIG: se_unit use entity WORK.se_unit(SE);



begin
rs_out<=regoutaS(3 downto 0);
rt_out<=regoutbS(3 downto 0);
pc_out<= next_pcS(3 downto 0);

-- here would be the control unit and the contorl signal intialization
process(resetMain, clk, instS, opcode, funcfive,control_values)
begin
funcfive<= instS(5 downto 0);
opcode <= instS(31 downto 26);

if(opcode = "000000") then
    if(funcfive = "100000") then
        control_values<= "11100000100000";
    elsif (funcfive = "100010" ) then
        control_values<= "11101000100000";
    elsif (funcfive = "101010") then
        control_values<= "11100000010000";
    elsif (funcfive = "100100") then
        control_values<= "11101000110000";
    elsif (funcfive = "100101") then
        control_values<= "11100001110000";
    elsif (funcfive = "100110") then
        control_values<= "11100010110000";
    elsif (funcfive = "100111") then
        control_values<= "11100011110000";
    elsif (funcfive = "001000") then
        control_values<= "00000000000010";
    else
        control_values<= "--------------";    
   
    end if;
elsif(opcode="001111") then
    control_values<= "10110000000000";
elsif (opcode = "001000") then
    control_values<= "10110000100000";
elsif (opcode = "001010") then
    control_values<= "10110000010000";
elsif (opcode = "001100") then
    control_values<= "10110000110000";
elsif (opcode= "001101") then
    control_values<= "10110001110000";
elsif (opcode = "001110") then
    control_values<= "10110010110000";
elsif (opcode = "100011") then
    control_values<= "10010010100000";
elsif (opcode = "101011") then
    control_values<= "00010100100000";
elsif (opcode = "000010") then
    control_values<= "00000000000001";
elsif (opcode = "000001") then
    control_values<= "00000000001100";
elsif (opcode = "000100") then
    control_values<= "00000000000100";
elsif (opcode ="000101") then
    control_values<= "00000000001000";
else
            control_values<= "--------------";   
   
end if;

--assign values  to control signals
pc_selS<= control_values(1 downto 0);
branch_typeS<=control_values(3 downto 2);
alufuncS<= control_values(5 downto 4);
alulogicfuncS<= control_values(7 downto 6);
data_writeS<= control_values(8);
add_subS<= control_values(9);
alu_srcS<= control_values(10);
reg_dstS<= control_values(12);
reg_writeS<= control_values(13);
reg_in_srcS<= control_values(11);

-- here would be the control unit and the contorl signal intialization
end process;


-- all the mux conditions
--reg_dst mux 
reddstS<= instS(20 downto 16) when reg_dstS ='0' else  instS(15 downto 11) when reg_dstS ='1';
--alu_Src mux
alusrc<= regoutbS when alu_srcS ='0' else seOS when alu_srcS ='1';
--reg_in_src
regiS<= dcacheOS when reg_in_srcS ='0' else   aluOS when reg_in_srcS ='1';



--port map to connect all the components and signal
PCC: pc_unit port map (D=> nanextS, Q=>next_pcS, reset=> resetMain, clk=> clk);
NA: next_address port map (next_pc=> nanextS, rs =>regoutaS , rt=>regoutbS, pc=> next_pcS, target_address=>instS(25 downto 0), branch_type=>branch_typeS, pc_sel=>pc_selS);
ICACHE: ic_unit port map(input_port=> next_pcS(4 downto 0), output_port=>instS);
REG: regunit port map(din=>regiS, read_a=>instS(25 downto 21), read_b=>instS(20 downto 16), reset=> resetMain, clk=>clk, write_address=>reddstS,out_a=>regoutaS , out_b=>regoutbS, write=>reg_writeS );
ALU_C: alu port map(x=> regoutaS, y=>alusrc, add_sub=> add_subS, logic_func=>alulogicfuncS, func=>alufuncS,output=>aluOS, overflow=> overflowMain, zero=> zeroMain);
dc_C: dc_unit port map(add=> aluOS(4 downto 0), reset=> resetMain, clk=> clk, data_write=>data_writeS , d_in=>regoutbS, d_out=>dcacheOS);
SIG: se_unit port map(input_p=>instS(15 downto 0), output_p=>seOS , func_extend=> alufuncS);



end cpu;
