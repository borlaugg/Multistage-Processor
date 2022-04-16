library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity incrementer is
    port (
        clk, rst, en : in std_logic;
        din          : in std_logic_vector(15 downto 0);
        dout         : out std_logic_vector(15 downto 0)
    );
end incrementer;

architecture incr_arch of incrementer is
begin
    process (clk, rst, en)
    begin
        if rst = '1' then
            dout <= (others => '0');
        elsif ((rising_edge(clk)) and (en = '1')) then
            dout <= (din + "0000000000000001");
        end if;
    end process;

end incr_arch;