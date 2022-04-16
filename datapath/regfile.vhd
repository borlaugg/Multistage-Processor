library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mux_8to1.all;
use work.reg.all;

entity regfile is
    port (
        clk, rst, en : in std_logic;
        rf_a1, rf_a2, rf_a3 : in std_logic_vector(2 downto 0);
        rf_d1, rf_d2 : out std_logic_vector(15 downto 0);
        rf_d3 : in std_logic_vector(15 downto 0)
    );
end regfile;

architecture rfile of regfile is

type bigsig is array (0 to 7) of std_logic_vector(15 downto 0);
signal rega, regb, regc : bigsig := (others => (others => '0'));
signal r0a, r0b, r0c, r1a, r1b, r1c, r2a, r2b, r2c, r3a, r3b, r3c, r4a, r4b, r4c, r5a, r5b, r5c, r6a, r6b, r6c : std_logic_vector(15 downto 0);
-- component reg is
--     port (
--         clk, rst, en : in std_logic;
--         din : in std_logic_vector(15 downto 0);
--         dout : out std_logic_vector(15 downto 0)
--     );
-- end component reg;

-- component rf_mux_8to1_r is
--     port (
--         x : out std_logic_vector(7 downto 0);
--         s : in std_logic_vector(2 downto 0);
--         y : in std_logic_vector(15 downto 0) 
--     );
-- end component rf_mux_8to1_r;

-- component rf_mux_8to1 is
--     port (
--         x : in std_logic_vector(7 downto 0);
--         s : in std_logic_vector(2 downto 0);
--         y : out std_logic_vector(15 downto 0) 
--     );
-- end component rf_mux_8to1;
begin
    MUX_A1 : rf_mux_8to1 port map (
        x : 
    ) 

    r0 : reg port map (
        clk => clk, rst => rst, en => en,
        din => 
    );
    r1 :
end rfile;