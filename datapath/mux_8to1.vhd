library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_8to1 is
    port (
        x : in std_logic_vector(7 downto 0);
        s : in std_logic_vector(2 downto 0);
        y : out std_logic
    );
end mux_8to1;

architecture behav of mux_8to1 is
begin
    process (x, s)
    begin
        case s is
            when "000" => y <= x(0);
            when "001" => y <= x(1);
            when "010" => y <= x(2);
            when "011" => y <= x(3);
            when "100" => y <= x(4);
            when "101" => y <= x(5);
            when "110" => y <= x(6);
            when "111" => y <= x(7);
            when others => null;
        end case;
    end process;
end behav;


entity rf_mux_8to1 is
    port (
        x : in std_logic_vector(7 downto 0);
        s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(15 downto 0) 
    );
end rf_mux_8to1;

architecture behav of rf_mux_8to1 is
begin
   process (x, s)
   begin
        case s is
            when "000" => y <= x(0);
            when "001" => y <= x(1);
            when "010" => y <= x(2);
            when "011" => y <= x(3);
            when "100" => y <= x(4);
            when "101" => y <= x(5);
            when "110" => y <= x(6);
            when "111" => y <= x(7);
            when others => null;
        end case;
   end process;
end behav;

entity rf_mux_8to1_r is
    port (
        x : out std_logic_vector(7 downto 0);
        s : in std_logic_vector(2 downto 0);
        y : in std_logic_vector(15 downto 0) 
    );
end rf_mux_8to1_r;

architecture behav of rf_mux_8to1_r is
begin
    process (x, s)
    begin
        case s is
            when "000" => x(0) <= y;
            when "001" => x(1) <= y;
            when "010" => x(2) <= y;
            when "011" => x(3) <= y;
            when "100" => x(4) <= y;
            when "101" => x(5) <= y;
            when "110" => x(6) <= y;
            when "111" => x(7) <= y;
            when others => null;
        end case;
    end process;
end behav;