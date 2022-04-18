library std
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all

entity Datapath is
    port(
        clk, rst: in std_logic;
        di, t1, cz, alu: in std_logic_vector(1 downto 0);
        z, ao, do, inc: in std_logic;
        ir, pc: in std_logic_vector(2 downto 0);
        mux: in std_logic_vector(3 downto 0);
        rf: in std_logic_vector(4 downto 0)
        co: out std_logic;
        zo: out std_logic;
        ir_data: out std_logic_vector(15 downto 0);
        );
end entity Datapath;

architecture dp of Datapath is
signal pc_o, pc_i: std_logic;
signal inc_o: std_logic;
signal rf_a3_inp, rf_a2_inp, rf_a1_inp: std_logic_vector(2 downto 0);
signal t1_o, alu_o, rf_d1_o, rf_d2_o, rf_d3_o: std_logic_vector(15 downto 0);




component memory is
    generic(
        mem_add_width := 16;
        data_width    := 16;
    );
    port(
        clock  := in std_logic;
        di     := in std_logic_vector(15 downto 0);
        do     := out std std_logic_vector(15 downto 0);
        ao     := in std_logic_vector(15 downto 0);
    );
end component memory;

component ALU is 
    generic(
        operand_width : integer:=16;
        sel_line : integer:=2;
        );
    port(
        alu_x : in std_logic_vector(operand_width-1 downto 0);
        alu_y : in std_logic_vector(operand_width-1 downto 0);
        sel   : in std_logic_vectpr(sel_line-1 downto 0);
        alu_c : in std_logic;
        alu_o : out std_logic_vector(operand_width-1 downto 0);
        c     : out std_logic;
        z     : out std_logic;
    );
end component ALU;

component ir is
    port(
        clock, reset, en  : in std_logic;
        din               : in std_logic_vector(15 downto 0);
        dout              : out std_logic_vector(15 downto 0);
        );
end component ir;

component RegFile is 
    port(
        rf_a1    : in  std_logic_vector(2 downto 0);
        rf_a2	 : in  std_logic_vector(2 downto 0);
        rf_a3    : in  std_logic_vector(2 downto 0);
        rf_d1    : out std_logic_vector(15 downto 0);
        rf_d2    : out std_logic_vector(15 downto 0);
        rf_d3    : in  std_logic_vector(15 downto 0)
    );
end component Regfile;

component MUX_2_to_1 is
    generic ( n_bits := integer := 16);
    port(
        type data_arr is array(1 downto 0) of std_logic_vector(nbits-1 downto 0);
        x : in data_arr;
        s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(nbits-1 downto 0);    
    );
end component MUX_2_to_1;

component MUX_4_to_1 is
    generic ( n_bits := integer := 16);
    port (
        type data_arr is array(3 downto 0) of std_logic_vector(nbits-1 downto 0);
        x : in data_arr;
        s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(nbits-1 downto 0);
    );
end MUX_4_to_1;

component MUX_8_to_1 is
    generic ( n_bits := integer := 16);
    port (
        type data_arr is array(7 downto 0) of std_logic_vector(nbits-1 downto 0);
        x : in data_arr;
        s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(nbits-1 downto 0);
    );
end MUX_8_to_1;

component switch is
    generic(n_bits := integer := 16);
    port(
        x : in std_logic_vector(nbits-1 downto 0);
        s : in std_logic;
        y : out std_logic;
    );
    end component switch;

    component R_block is
		port (
		i : in std_logic_vector(3 downto 0);
		o : out std_logic;
	);
	end component R_block;

	component I_block is
		port (
			i : in std_logic_vector(3 downto 0);
			o : out std_logic;
		);
	end component I_block;

	component J_block is
		port (
			i : in std_logic_vector(3 downto 0);
			o : out std_logic;
		);
	end component J_block;

    component reg is
        generic ( nbits : integer := 16 );
        port (
            clk, rst, en : in std_logic;
            din          : in std_logic_vector(nbits-1 downto 0);
            dout         : out std_logic_vector(nbits-1 downto 0)
        );
    end component reg;

    component bus is
	generic ( data_length : integer := 16 )
	port (
		clk, rst : in std_logic;
		din      : in std_logic_vector(data_length-1 downto 0);
		dout     : out std_logic_vector(15 downto 0)
	);
    end component bus;


begin
--start connection from bus
pc: reg port map(clk, rst, pc(1), pc_i, pc_o);
sw_pci: switch port map(bus_a_o, pc(2), pc_i);




