library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package rij is
	component R_block is
		port (
		i : in std_logic_vector(3 downto 0);
		o : out std_logic
	);
	end component R_block;

	component I_block is
		port (
			i : in std_logic_vector(3 downto 0);
			o : out std_logic
		);
	end component I_block;

	component J_block is
		port (
			i : in std_logic_vector(3 downto 0);
			o : out std_logic
		);
	end component J_block;
end package rij;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity R_block is
	port (
		i : in std_logic_vector(3 downto 0);
		o : out std_logic
	);
end R_block;

architecture R_arch of R_block is
begin
	o <= (not i(3)) and (not i(2)) and (i(1) xor i(0));
end R_arch;

entity I_block is
	port (
		i : in std_logic_vector(3 downto 0);
		o : out std_logic
	);
end I_block;

architecture I_arch of I_block is
begin
	o <= (i(3) and (not i(2)) and (not i(1))) or ((not i(3)) and i(2) and (not i(3))) or ((not i(3)) and i(2) and i(1) and i(0));
end I_arch;

entity J_block is
	port (
		i : in std_logic_vector(3 downto 0);
		o : out std_logic
	);
end J_block;

architecture J_arch of J_block is
begin
	o <= (i(3) and i(0)) or (i(3) and i(2) and (not i(1))) or ((not i(3)) and (not i(2)) and (not i(1)) and (not i(0));
end J_arch;