library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2to1 is
    port (
        x : in std_logic_vector(1 downto 0);
        s : in std_logic;
        y : out std_logic
    );
end mux_2to1;

architecture behav of mux_2to1 is
begin
    process (x, s)
    begin
        case s is
            when "0" => y <= x(0);
            when "1" => y <= x(1);
        end case;
    end process;
end behav;