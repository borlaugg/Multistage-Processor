library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
	generic (
		mem_data_width : integer := 16; -- number of bits per word
		mem_width : integer := 8 -- number of address bits; N = 2^A
	); 
	
	port (
		address		: in std_logic_vector(mem_width-1 downto 0); 
		data_in		: in std_logic_vector(mem_data_width-1 downto 0);
		write_in	: in std_logic; 
		clk			: in std_logic; 
		data_out	: out std_logic_vector(mem_data_width-1 downto 0)
	);
end mem;
		
architecture mem_arch of mem is
type mem_array is array (0 to 2**mem_width-1) of std_logic_vector (mem_data_width-1 downto 0);
signal mem_data: mem_array:=(others =>(others=>'0')); 
begin
	process(clock)
	begin
		if(rising_edge(clock)) then
			if(write_in='1') then 
				mem_data(to_integer(unsigned(address))) <= data_in;
			end if;
		end if;
	end process;
	data_out <= mem_data(to_integer(unsigned(address)));
end mem_arch;