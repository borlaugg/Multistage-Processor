library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bus is
    port (
        clk, rst : in std_logic;
        din      : in std_logic_vector(15 downto 0);
        dout     : out std_logic_vector(15 downto 0)
    );
end bus;

architecture bus_arch of bus is
begin
    process (clk, rst)
    begin
        if (rst = '1') then
            dout <= (others => '0');
        elsif (rising_edge(clk)) then
            dout <= din;
        end if;
end bus_arch;