library std
use std.standard.all;

library work
use work.muxes.all;

library ieee;
use ieee.std_logic_1164.all

entity Datapath is
    port(
        clk, rst: in std_logic;
        di_en, t1_en, cz_en, alu_en: in std_logic_vector(1 downto 0);
        ao_en, do_en, inc_en: in std_logic; -- removed "z"
        ir_en, pc_en: in std_logic_vector(2 downto 0);
        mux: in std_logic_vector(3 downto 0);
        rf: in std_logic_vector(4 downto 0);
		rf_wren: out std_logic; -------- just added, might need to change
        co: out std_logic;
        zo: out std_logic;
        ir_data: out std_logic_vector(15 downto 0)
        );
end entity Datapath;

architecture datapath_arch of Datapath is
signal one : std_logic := '1';
signal zero : std_logic := '0';
signal zero_3bit : std_logic_vector(2 downto 0) := "000";
signal dummy_16bit : std_logic_vector(15 downto 0) := (others => '0');
signal pc_o, pc_i : std_logic; --program counter
signal inc_o : std_logic; --incrementer
signal rf_a3_i, rf_a2_i, rf_a1_i : std_logic_vector(2 downto 0):= "000"; --register file
signal rf_d1_o, rf_d2_o, rf_d3_o : std_logic_vector(15 downto 0); --register file
signal bus_a_o, bus_a_i,: std_logic_vector(15 downto 0); --bus a
signal bus_b_o, bus_b_i,: std_logic_vector(15 downto 0); --bus b
signal alu_a, alu_b, alu_o, t1_o : std_logic_vector(15 downto 0); --alu
signal memi_o, ir_o : std_logic_vector(15 downto 0); --instrction register
signal alu_s1, alu_s0, c_o, z_o, carry_f, zero_f : std_logic; --alu select lines and carry output and flags
signal rblock_o, iblock_o, jblock_o: std_logic; --rij block
signal ao_o: std_logic_vector(15 downto 0); --address out
signal memd_o, di_o: std_logic_vector(15 downto 0); --data in
signal do_o: std_logic_vector(15 downto 0)-- data out
signal  

component mem is
	generic (
		mem_data_width : integer := 16; -- number of bits per word
		mem_width : integer := 8 -- number of address bits; N = 2^A
	); 
	
	port (
		address		: in std_logic_vector(mem_width-1 downto 0); 
		data_in		: in std_logic_vector(mem_data_width-1 downto 0);
		write_in	: in std_logic; 
		clk			: in std_logic; 
		data_out	: out std_logic_vector(mem_data_width-1 downto 0)
	);
end component mem;

component incrementer is
    port (
        clk, rst, en : in std_logic;
        din          : in std_logic_vector(15 downto 0);
        dout         : out std_logic_vector(15 downto 0)
    );
end component incrementer;

component ALU is 
    generic (
        operand_width : integer:=16;
        sel_line : integer:=2
    );
    port (
        alu_x : in std_logic_vector(operand_width-1 downto 0);
        alu_y : in std_logic_vector(operand_width-1 downto 0);
        sel   : in std_logic_vector(sel_line-1 downto 0);
        alu_c : in std_logic;
        alu_o : out std_logic_vector(operand_width-1 downto 0);
        c     : out std_logic;
        z     : out std_logic
    );
end component ALU;

component ir is
    port(
        clk, rst, en  	: in std_logic;
        din               : in std_logic_vector(15 downto 0);
        dout              : out std_logic_vector(15 downto 0)
        );
end component ir;

component regfile is 
    port(
        rf_a1 : in std_logic_vector(2 downto 0);
		rf_a2 : in std_logic_vector(2 downto 0);
		rf_a3 : in std_logic_vector(2 downto 0);
		rf_d1 : out std_logic_vector(15 downto 0);
		rf_d2 : out std_logic_vector(15 downto 0);
		rf_d3               : in std_logic_vector(15 downto 0);
		wr_en               : in std_logic;
		clk, rst            : in std_logic
		
    );
end component regfile;

component switch is
	generic( n_bits : integer := 16 );
	port (
		x : in std_logic_vector(nbits-1 downto 0);
		s : in std_logic;
		y : out std_logic
	);
end component switch;

component R_block is
	port (
	i : in std_logic_vector(3 downto 0);
	o : out std_logic
);
end component R_block;

component I_block is
	port (
		i : in std_logic_vector(3 downto 0);
		o : out std_logic
	);
end component I_block;

component J_block is
	port (
		i : in std_logic_vector(3 downto 0);
		o : out std_logic
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
	generic ( data_length : integer := 16 );
	port (
		clk, rst : in std_logic;
		din      : in std_logic_vector(data_length-1 downto 0);
		dout     : out std_logic_vector(15 downto 0)
	);
end component bus;

-- component ir is
-- 	port (
-- 		clk			: in std_logic;
-- 		irwrite		: in std_logic;
-- 		inp			: in std_logic_vector(15 downto 0);
-- 		opcode		: out std_logic_vector(3 downto 0); --15-12
-- 		imm6		: out std_logic_vector(5 downto 0); --5-0
-- 		ra			: out std_logic_vector(2 downto 0); --b-9
-- 		rb			: out std_logic_vector(2 downto 0); --8-6
-- 		rc			: out std_logic_vector(2 downto 0); --5-3
-- 		cz			: out std_logic_vector(1 downto 0); --1-0 -- 0 is z and 1 is c
-- 		imm9		: out std_logic_vector(8 downto 0); --8-0
-- 		imm8		: out std_logic_vector(7 downto 0)  --7-0
-- 	);
-- end component ir;

begin
	-- PC and related signals/connections
	program_counter : 
		reg port map (clk, rst, pc_en(1), pc_i, pc_o);
	sw_pci : 
		switch port map (pc_o, pc_en(2), bus_a_i);
	bus_inc_mux : 
		mux_2to1 port map (inc_o, bus_a_o, pc_en(0), pc_i);
	incr : 
		incrementer port map (clk, rst, inc_en, pc_i, inc_o);
	
	-- ir
	instruction_reg :
		reg port map (clk, rst, ir_en, memi_o, ir_o);
	instruction_memory :
		memory port map ();
	
	-- ALU and t1
	arithmetic_logical_unit : 
        ALU port map (alu_a, alu_b, sel(1)=>alu_s1, sel(0)=>alu_s0, c_o, alu_o, carry_f, zero_f);
	bus_a_alu :
		switch port map (bus_a_o, alu_en(0), alu_a);
	bus_b_alu :
		switch port map (bus_b_o, alu_en(1), alu_b);
	temp_reg_t1 :
		reg port map (clk, rst, one, alu_o, t1_o);
	t1_bus_a :
		switch port map (t1_o, t1_en(0), bus_a_i);
	t1_bus_b :
		switch port map (t1_o, t1_en(1), bus_b_i);

	--CZ
	carry_zero_reg :
		reg generic (2); port map (clk, rst, cz_en, din(1)=>carry_f, din(0)=>zero_f, dout(1)=>c_o, dout(0)=>z_o);
	
	--RF
	 rblock :
	 	R_block port map (ir_o(15 downto 11), rblock_o);
	 iblock :
		I_block port map (ir_o(15 downto 11), iblock_o);
	 jblock :
		J_block port map (ir_o(15 downto 11), jblock_o);
	 rf_a1_selection_mux1 :
	 	mux_2to1 generic (3); port map (zero_3bit,ir_o(11 downto 9), jblock_o, rf_a1_i);
	 rf_a2_selection_mux2 :
		mux_2to1 generic (3); port map (ir_o(8 downto 6),zero_3bit, jblock_o, rf_a2_i);
	 rf_a3_selection_mux2 :
		mux_4to1 generic (3); port map (zero_3bit,ir_o(11 downto 9), ir_o(8 downto 6),ir_o(5 downto 3), s(0)=>jblock_o,s(1)=>iblock_o, rf_a3_i);

	 register_file :
		regfile port map (rf_a1_i, rf_a2_i, rf_a3_i, rf_d1_o, rf_d2_o, rf_d3_o,rf_en(3),clk,rst);
	rf_switch_1:
		switch port map (rf_d1, rf_en(0), bus_a_i);
	rf_switch_2:
		switch port map (rf_d2, rf_en(1), bus_b_i);
	rf_switch_3:
		switch port map (bus_a_i, rf_en(2), rf_d3_i);
	rf_switch_4:
		switch port map (bus_b_i, not(rf_en(2)), rf_d3_i);
	--AO
	address_out:
		reg port map (clk, rst, ao_en, bus_a_o, ao_o);
	
	--DI
	di_switch_1:
		switch port map (di_o, di_en(0), bus_a_i);
	di_switch_2:
		switch port map (di_o, di_en(1), bus_b_i);
	data_in:
		reg port map (clk, rst, (not do_en), memd_o, di_o);
		
	--DO
	data_out:
		reg port map (clk, rst, do_en, bus_b_o, do_o);
	
	--data memory
	data_memory:
		mem	port map (ao_o, do_o, do_en, clk, memd_o);
	
	--instruction memory
	instruction_memory:
		mem port map (pc_o, dummy_16bit, zero, clk, memi_o);


end datapath_arch;