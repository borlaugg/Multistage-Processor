library ieee;
use ieee.std_logic_1164.all;

package decode is
	component decoder is
		port(
			i : in std_logic_vector(5 downto 0); 
			o : out std_logic_vector(16 downto 0)
		);
	end component decoder; 
end package decode;

library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(
		i : in std_logic_vector(3 downto 0); 
		o : out std_logic_vector(11 downto 0)
	);
end entity decoder; 

architecture beh of decoder is
begin
	o(0) <= (not(i(3))) and (not (i(2))) and (not (i(1))) and (not (i(0)));
	o(1) <= (not(i(3))) and (not (i(2))) and (not (i(1))) and (i(0));
	o(2) <= (not(i(3))) and (not (i(2))) and (i(1)) and (not (i(0)));
	o(11) <= (i(3)) and (i(2)) and (i(1)) and (i(0));
	o(4) <= (not(i(3))) and (i(2)) and (i(1))) and (i(0));
	o(3) <= (not(i(3))) and (i(2)) and (not (i(1))) and (i(0));
	o(5) <= (i(3)) and (not (i(2))) and (not (i(1))) and (not (i(0)));
	o(6) <= (i(3)) and (not (i(2))) and (not (i(1))) and (i(0));
	o(7) <= (i(3)) and (not (i(2))) and (i(1)) and (not (i(0)));
	o(8) <= (i(3)) and (not (i(2))) and (i(1)) and (i(0));
	o(9) <= (i(3)) and (i(2)) and (not (i(1))) and (not (i(0)));
	o(10) <= (i(3)) and (i(2)) and (not (i(1))) and (i(0));
end beh;