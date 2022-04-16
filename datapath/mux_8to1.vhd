library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_8to1 is
    generic ( n_bits := integer := 16)
    port (
        type data_arr is array(7 downto 0) of std_logic_vector(nbits-1 downto 0);
        x : in data_arr;
        s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(nbits-1 downto 0)
    );
end mux_8to1;

architecture behav of mux_8to1 is
begin
    process (x, s)
    begin
        y <= x(to_integer(s))
    end process;
end behav;

-- Ulta 8x1 mux, writes the value at y to x(select)
entity mux_8to1_r is
    generic ( n_bits := integer := 16)
    port (
        type data_arr is array(7 downto 0) of std_logic_vector(nbits-1 downto 0);
        x : out data_arr;
        s : in std_logic_vector(2 downto 0);
        y : in std_logic_vector(nbits-1 downto 0)
    );
end mux_8to1_r;

architecture behav of rf_mux_8to1_r is
begin
    process (x, s)
    begin
        x(to_integer(s)) <= y;
    end process;
end behav;