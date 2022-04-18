library ieee;
use ieee.std_logic_1164.all;

entity ir is
	port (
		clk			: in std_logic;
		irwrite		: in std_logic;
		inp			: in std_logic_vector(15 downto 0);
		opcode		: out std_logic_vector(3 downto 0); --15-12
		imm6		: out std_logic_vector(5 downto 0); --5-0
		ra			: out std_logic_vector(2 downto 0); --b-9
		rb			: out std_logic_vector(2 downto 0); --8-6
		rc			: out std_logic_vector(2 downto 0); --5-3
		cz			: out std_logic_vector(1 downto 0); --1-0 -- 0 is z and 1 is c
		imm9		: out std_logic_vector(8 downto 0); --8-0
		imm8		: out std_logic_vector(7 downto 0)  --7-0
	);
end entity;

architecture ir_arch of ir is
component reg is
	generic ( nbits : integer := 16 );
	port (
		clk, rst, en : in std_logic;
		din          : in std_logic_vector(nbits-1 downto 0);
		dout         : out std_logic_vector(nbits-1 downto 0)
	);
end component reg;
signal ir_regout: std_logic_vector(15 downto 0);
begin
	r_1: reg generic (16); port map (clk, rst, en, inp, ir_regout);
	opcode <= ir_regout(15 downto 12);
	imm6 <= ir_regout(5 downto 0);
	ra <= ir_regout(11 downto 9);
	rb <= ir_regout(8 downto 6);
	rc <= ir_regout(5 downto 3);
	cz <= ir_regout(1 downto 0);
	imm9 <= ir_regout(8 downto 0);
	imm8 <= ir_regout(7 downto 0);
end ir_arch;