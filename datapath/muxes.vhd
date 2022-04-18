library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package muxes is
	component mux_2to1 is
		generic ( n_bits : integer := 16 );
		port (
			x1 : in std_logic_vector(nbits-1 downto 0);
			x0 : in std_logic_vector(nbits-1 downto 0);
			s : in std_logic;
			y : out std_logic_vector(nbits-1 downto 0)
		);
	end component mux_2to1;

	component demux_1x2 is
		generic ( n_bits : integer := 16 );
		port (
			x1 : out std_logic_vector(nbits-1 downto 0);
			x0 : out std_logic_vector(nbits-1 downto 0);
			s : in std_logic;
			y : in std_logic_vector(nbits-1 downto 0)
		);
	end component demux_1x2;

	component mux_4to1 is
		generic ( n_bits : integer := 16 );
		port (
			x3 : in std_logic_vector(nbits-1 downto 0);
			x2 : in std_logic_vector(nbits-1 downto 0);
			x1 : in std_logic_vector(nbits-1 downto 0);
			x0 : in std_logic_vector(nbits-1 downto 0);
			s : in std_logic_vector(1 downto 0);
			y : out std_logic_vector(nbits-1 downto 0)
		);
	end component mux_4to1;

	component demux_1x4 is
		generic ( n_bits : integer := 16 );
		port (
			x3 : out std_logic_vector(nbits-1 downto 0);
			x2 : out std_logic_vector(nbits-1 downto 0);
			x1 : out std_logic_vector(nbits-1 downto 0);
			x0 : out std_logic_vector(nbits-1 downto 0);
			s : in std_logic_vector(1 downto 0);
			y : in std_logic_vector(nbits-1 downto 0)
		);
	end component demux_1x4;

	component mux_8to1 is
		generic ( n_bits : integer := 16 );
		port (
			x7 : in std_logic_vector(nbits-1 downto 0);
			x6 : in std_logic_vector(nbits-1 downto 0);
			x5 : in std_logic_vector(nbits-1 downto 0);
			x4 : in std_logic_vector(nbits-1 downto 0);
			x3 : in std_logic_vector(nbits-1 downto 0);
			x2 : in std_logic_vector(nbits-1 downto 0);
			x1 : in std_logic_vector(nbits-1 downto 0);
			x0 : in std_logic_vector(nbits-1 downto 0);
			s : in std_logic_vector(2 downto 0);
			y : out std_logic_vector(nbits-1 downto 0)
		);
	end component mux_8to1;

	component demux_1to8 is
		generic ( n_bits : integer := 16 );
		port (
			x7 : out std_logic_vector(nbits-1 downto 0);
			x6 : out std_logic_vector(nbits-1 downto 0);
			x5 : out std_logic_vector(nbits-1 downto 0);
			x4 : out std_logic_vector(nbits-1 downto 0);
			x3 : out std_logic_vector(nbits-1 downto 0);
			x2 : out std_logic_vector(nbits-1 downto 0);
			x1 : out std_logic_vector(nbits-1 downto 0);
			x0 : out std_logic_vector(nbits-1 downto 0);
			s : in std_logic_vector(2 downto 0);
			y : in std_logic_vector(nbits-1 downto 0)
		);
	end component demux_1to8;
end package muxes;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2to1 is
	generic ( n_bits : integer := 16);
	port (
		x1 : in std_logic_vector(nbits-1 downto 0);
		x0 : in std_logic_vector(nbits-1 downto 0);
		s : in std_logic;
		y : out std_logic_vector(nbits-1 downto 0)
		);
end mux_2to1;

architecture mux_2x1_arch of mux_2to1 is
begin
	process (x, s)
	begin
		case s is
			when "0" =>
				y <= x0;
			when "1" =>
				y <= x1;
		end case;
	end process;
end mux_2x1_arch;

entity demux_1x2 is
	generic ( n_bits : integer := 16 );
	port (
		x1 : out std_logic_vector(nbits-1 downto 0);
		x0 : out std_logic_vector(nbits-1 downto 0);
		s : in std_logic;
		y : in std_logic_vector(nbits-1 downto 0)
	);
end demux_1x2;

architecture demux_1x2_arch of demux_1x2 is
begin
	process (x, s)
	begin
		case s is
			when "0" =>
				x0 <= y;
			when "1" =>
				x1 <= y;
		end case;
	end process;
end demux_1x2_arch;

entity mux_4to1 is
	generic ( n_bits : integer := 16 );
	port (
		x3 : in std_logic_vector(nbits-1 downto 0);
		x2 : in std_logic_vector(nbits-1 downto 0);
		x1 : in std_logic_vector(nbits-1 downto 0);
		x0 : in std_logic_vector(nbits-1 downto 0);
		s : in std_logic_vector(1 downto 0);
		y : out std_logic_vector(nbits-1 downto 0)
	);
end mux_4to1;

architecture mux_4x1_arch of mux_4to1 is
begin
	process (x, s)
	begin
		case s is
			when "00" =>
				y <= x0;
			when "01" =>
				y <= x1;
			when "10" =>
				y <= x2;
			when "11" =>
				y <= x3;
		end case;
	end process;
end mux_4x1_arch;

entity demux_1x4 is
	generic ( n_bits : integer := 16 );
	port (
		x3 : out std_logic_vector(nbits-1 downto 0);
		x2 : out std_logic_vector(nbits-1 downto 0);
		x1 : out std_logic_vector(nbits-1 downto 0);
		x0 : out std_logic_vector(nbits-1 downto 0);
		s : in std_logic_vector(1 downto 0);
		y : in std_logic_vector(nbits-1 downto 0)
	);
end demux_1x4;

architecture demux_1x4_arch of demux_1x4 is
begin
	process (x, s)
	begin
		case s is
			when "00" =>
				x0 <= y;
			when "01" =>
				x1 <= y;
			when "10" =>
				x2 <= y;
			when "11" =>
				x3 <= y;
		end case;
	end process;
end demux_1x4_arch;

entity mux_8to1 is
	generic ( n_bits : integer := 16);
	port (
		x7 : in std_logic_vector(nbits-1 downto 0);
		x6 : in std_logic_vector(nbits-1 downto 0);
		x5 : in std_logic_vector(nbits-1 downto 0);
		x4 : in std_logic_vector(nbits-1 downto 0);
		x3 : in std_logic_vector(nbits-1 downto 0);
		x2 : in std_logic_vector(nbits-1 downto 0);
		x1 : in std_logic_vector(nbits-1 downto 0);
		x0 : in std_logic_vector(nbits-1 downto 0);
		s : in std_logic_vector(2 downto 0);
		y : out std_logic_vector(nbits-1 downto 0)
	);
end mux_8to1;

architecture mux_8x1_arch of mux_8to1 is
begin
	process (x, s)
	begin
		case s is
			when "000" =>
				y <= x0;
			when "001" =>
				y <= x1;
			when "010" =>
				y <= x2;
			when "011" =>
				y <= x3;
			when "100" =>
				y <= x4;
			when "101" =>
				y <= x5;
			when "110" =>
				y <= x6;
			when "111" =>
				y <= x7;
		end case;
	end process;
end mux_8x1_arch;

-- Ulta 8x1 mux, writes the value at y to x(select)
entity demux_1to8 is
	generic ( n_bits : integer := 16);
	port (
		x7 : out std_logic_vector(nbits-1 downto 0);
		x6 : out std_logic_vector(nbits-1 downto 0);
		x5 : out std_logic_vector(nbits-1 downto 0);
		x4 : out std_logic_vector(nbits-1 downto 0);
		x3 : out std_logic_vector(nbits-1 downto 0);
		x2 : out std_logic_vector(nbits-1 downto 0);
		x1 : out std_logic_vector(nbits-1 downto 0);
		x0 : out std_logic_vector(nbits-1 downto 0);
		s : in std_logic_vector(2 downto 0);
		y : in std_logic_vector(nbits-1 downto 0)
	);
end demux_1to8;

architecture demux_8x1_arch of demux_1to8 is
begin
	process (x, s)
	begin
		case s is
			when "000" =>
				x0 <= y;
			when "001" =>
				x1 <= y;
			when "010" =>
				x2 <= y;
			when "011" =>
				x3 <= y;
			when "100" =>
				x4 <= y;
			when "101" =>
				x5 <= y;
			when "110" =>
				x6 <= y;
			when "111" =>
				x7 <= y;
		end case;
	end process;
end demux_8x1_arch;