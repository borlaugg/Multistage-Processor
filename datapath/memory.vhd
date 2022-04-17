library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    generic (
        mem_width  : integer := 7;
        data_width : integer := 16
    )
    port (
        clk, rst : in std_logic;
        wr_en    : in std_logic
    );
end memory;

architecture mem_arch of memory is
begin

end mem_arch;