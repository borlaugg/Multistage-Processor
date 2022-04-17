library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
	generic ( nbits : integer := 16 );
	port (
		clk, rst, en : in std_logic;
		din          : in std_logic_vector(nbits-1 downto 0);
		dout         : out std_logic_vector(nbits-1 downto 0)
	);
end reg;

architecture reg_arch of reg is
begin
	process (clk, rst, en)
	begin
		if rst = '1' then
			dout <= (others => '0');
		elsif ((rising_edge(clk)) and (en = '1')) then
			dout <= din;
		end if;
	end process;
end reg_arch;
