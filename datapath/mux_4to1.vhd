library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4to1 is
    port (
        x : in std_logic_vector(3 downto 0);
        s : in std_logic_vector(1 downto 0);
        y : out std_logic
    );
end mux_4to1;

architecture behav of mux_4to1 is
begin
    process (x, s)
    begin
        case s is
            when "00" => y <= x(0);
            when "01" => y <= x(1);
            when "10" => y <= x(2);
            when "11" => y <= x(3);
        end case;
    end process;
end behav;