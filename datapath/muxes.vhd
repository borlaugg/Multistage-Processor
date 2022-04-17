library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package muxes is
	component mux_2to1 is
		generic ( n_bits := integer := 16);
		port (
			type data_arr is array(1 downto 0) of std_logic_vector(nbits-1 downto 0);
			x : in data_arr;
			s : in std_logic;
			y : out std_logic_vector(nbits-1 downto 0)
		);
	end component mux_2to1;

	component demux_1x2 is
		generic ( n_bits : integer := 16 );
		port (
			type data_arr is array(1 downto 0) of std_logic_vector(nbits-1 downto 0);
			x : out data_arr;
			s : in std_logic;
			y : in std_logic_vector(nbits-1 downto 0)
		);
	end component demux_1x2;

	component mux_4to1 is
		generic ( n_bits : integer := 16 );
		port (
			type data_arr is array(3 downto 0) of std_logic_vector(nbits-1 downto 0);
			x : in data_arr;
			s : in std_logic_vector(1 downto 0);
			y : out std_logic_vector(nbits-1 downto 0)
		);
	end component mux_4to1;

	component demux_1x4 is
		generic ( n_bits : integer := 16 );
		port (
			type data_arr is array(3 downto 0) of std_logic_vector(nbits-1 downto 0);
			x : out data_arr;
			s : in std_logic_vector(1 downto 0);
			y : in std_logic_vector(nbits-1 downto 0)
		);
	end component demux_1x4;

	component mux_8to1 is
		generic ( n_bits := integer := 16);
		port (
			type data_arr is array(7 downto 0) of std_logic_vector(nbits-1 downto 0);
			x : in data_arr;
			s : in std_logic_vector(2 downto 0);
			y : out std_logic_vector(nbits-1 downto 0)
		);
	end component mux_8to1;

	component demux_1to8 is
		generic ( n_bits := integer := 16);
		port (
			type data_arr is array(7 downto 0) of std_logic_vector(nbits-1 downto 0);
			x : out data_arr;
			s : in std_logic_vector(2 downto 0);
			y : in std_logic_vector(nbits-1 downto 0)
		);
	end component demux_1to8;
end package muxes;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2to1 is
	generic ( n_bits := integer := 16);
	port (
		type data_arr is array(1 downto 0) of std_logic_vector(nbits-1 downto 0);
		x : in data_arr;
		s : in std_logic;
		y : out std_logic_vector(nbits-1 downto 0)
	);
end mux_2to1;

architecture mux_2x1_arch of mux_2to1 is
begin
	process (x, s)
	begin
		y <= x(to_integer(s));
	end process;
end mux_2x1_arch;

entity demux_1x2 is
	generic ( n_bits : integer := 16 );
	port (
		type data_arr is array(1 downto 0) of std_logic_vector(nbits-1 downto 0);
		x : out data_arr;
		s : in std_logic;
		y : in std_logic_vector(nbits-1 downto 0)
	);
end demux_1x2;

architecture demux_1x2_arch of demux_1x2 is
begin
	process (x, s)
	begin
		x(to_integer(s)) <= y;
	end process;
end demux_1x2_arch;

entity mux_4to1 is
	generic ( n_bits : integer := 16 );
	port (
		type data_arr is array(3 downto 0) of std_logic_vector(nbits-1 downto 0);
		x : in data_arr;
		s : in std_logic_vector(1 downto 0);
		y : out std_logic_vector(nbits-1 downto 0)
	);
end mux_4to1;

architecture mux_4x1_arch of mux_4to1 is
begin
	process (x, s)
	begin
		y <= x(to_integer(s));
	end process;
end mux_4x1_arch;

entity demux_1x4 is
	generic ( n_bits : integer := 16 );
	port (
		type data_arr is array(3 downto 0) of std_logic_vector(nbits-1 downto 0);
		x : out data_arr;
		s : in std_logic_vector(1 downto 0);
		y : in std_logic_vector(nbits-1 downto 0)
	);
end demux_1x4;

architecture demux_1x4_arch of demux_1x4 is
begin
	process (x, s)
	begin
		x(to_integer(s)) <= y;
	end process;
end demux_1x4_arch;

entity mux_8to1 is
	generic ( n_bits := integer := 16);
	port (
		type data_arr is array(7 downto 0) of std_logic_vector(nbits-1 downto 0);
		x : in data_arr;
		s : in std_logic_vector(2 downto 0);
		y : out std_logic_vector(nbits-1 downto 0)
	);
end mux_8to1;

architecture mux_8x1_arch of mux_8to1 is
begin
	process (x, s)
	begin
		y <= x(to_integer(s))
	end process;
end mux_8x1_arch;

-- Ulta 8x1 mux, writes the value at y to x(select)
entity demux_1to8 is
	generic ( n_bits := integer := 16);
	port (
		type data_arr is array(7 downto 0) of std_logic_vector(nbits-1 downto 0);
		x : out data_arr;
		s : in std_logic_vector(2 downto 0);
		y : in std_logic_vector(nbits-1 downto 0)
	);
end demux_1to8;

architecture demux_8x1_arch of demux_1to8 is
begin
	process (x, s)
	begin
		x(to_integer(s)) <= y;
	end process;
end demux_8x1_arch;