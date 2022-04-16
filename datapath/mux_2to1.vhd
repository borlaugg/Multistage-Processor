library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2to1 is
    generic ( n_bits := integer := 16)
    port (
        type data_arr is array(1 downto 0) of std_logic_vector(nbits-1 downto 0);
        x : in data_arr;
        s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(nbits-1 downto 0)
    );
end mux_2to1;

architecture behav of mux_2to1 is
begin
    process (x, s)
    begin
        y <= x(to_integer(s));
    end process;
end behav;