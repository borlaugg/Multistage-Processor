library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

entity ALU is
	generic(
		operand_width : integer:=16;
		sel_line : integer:=2
	);
	port (
		A	: in std_logic_vector(operand_width-1 downto 0);
		B	: in std_logic_vector(operand_width-1 downto 0);
		sel	: in std_logic_vector(sel_line-1 downto 0);
		co 	: in std_logic;
		op	: out std_logic_vector(operand_width-1 downto 0);
		c 	: out std_logic;                             
		z 	: out std_logic
	);
end ALU;

architecture alu_arch of ALU is
signal temp_op : std_logic_vector(operand_width-1 downto 0):= (others=>'0');

	function sub(
		A : in std_logic_vector(operand_width-1 downto 0); 
		B : in std_logic_vector(operand_width-1 downto 0)
	)
		return std_logic_vector is
			-- declaring and initializing variables using aggregates 
			variable diff	: std_logic_vector(operand_width-1 downto 0):= (others=>'0');
				
			variable carry 	: std_logic:= '1'; 
			variable nb		: std_logic:= '1';

		begin
			differ: for i in 0 to 15 loop
				nb:= NOT B(i);
				diff(i) := (A(i) XOR  nb ) XOR carry;
				carry :=  (A(i) AND nb) OR ((A(i) XOR nb) AND carry) ;
			end loop;

		return diff;
	end sub;

	function add(
		A : in std_logic_vector(operand_width-1 downto 0); 
		B : in std_logic_vector(operand_width-1 downto 0)
	)
		return std_logic_vector is
		   	variable sum 	: std_logic_vector (operand_width-1 downto 0):= (others=>'0');
			variable carry 	: std_logic:= '0';
		begin
			adding: for i in 0 to 15 loop
				sum(i) := (A(i) XOR  B(i) ) XOR carry;
				carry :=  (A(i) AND B(i)) OR ((A(i) XOR B(i)) AND carry) ;
			end loop;

		return sum;
	end add;

	function addl(
		A : in std_logic_vector(operand_width-1 downto 0); 
		B : in std_logic_vector(operand_width-1 downto 0)
	)
		return std_logic_vector is
			variable sum 	: std_logic_vector (operand_width-1 downto 0):= (others=>'0');
			variable B1 	: std_logic_vector(operand_width-1 downto 0):= (others=>'0'); 
			variable carry 	: std_logic:= '0';
		begin
			B1:= B(14 downto 0)&'0';
			adding: for i in 0 to 15 loop
				sum(i) := (A(i) XOR  B1(i) ) XOR carry;
				carry :=  (A(i) AND B1(i)) OR ((A(i) XOR B1(i)) AND carry) ;
			end loop;

		return sum;
	end addl;
	 
	function AnandB(
		A : in std_logic_vector(operand_width-1 downto 0); 
		B : in std_logic_vector(operand_width-1 downto 0)
	)
		return std_logic_vector is
			variable AnB : std_logic_vector(operand_width-1 downto 0):= (others=>'0');
		begin
		   	bitnr: for i in 0 to operand_width-1 loop
				AnB(i) := A(i) nand B(i);
			end loop;
		
	  return AnB;
   end AnandB;
		 
begin

	alu : process (A, B, sel, co)
	begin
	if sel = "00" then
			temp_op <= add(A,B);
			op<=temp_op;
			if(A(15) = B(15)) then
				c <= A(15);	
			else
				c <= not(temp_op(15));
			end if;
		
		elsif sel = "01" then
			temp_op<= addl(A,B) ;
			op<=temp_op;
			if(A(15) = B(14)) then
				c <= A(15);	
			else
				c <= not(temp_op(15));
			end if;
		elsif sel = "10" then
			temp_op<= AnandB(A,B);
			op<=temp_op;
			c<=co;
		else 
			temp_op<=sub(A,B); 
			op<=temp_op;
			c<=co;
		end if;	
		
		if (temp_op = "0000000000000000") then 
			z <= '1';
		else 
			z <= '0';
		end if;

	end process ; --alu
end alu_arch ; -- alu_arch