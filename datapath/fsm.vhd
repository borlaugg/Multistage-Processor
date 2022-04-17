library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.decode.all

package FSM is
	component machine is
		port(
			inp				: in std_logic_vector(3 downto 0);
			reset,clock		: in std_logic;
			di, t1, cz, alu	: out std_logic_vector(1 downto 0);
			z, ao, do, inc	: out std_logic;
			ir, pc			: out std_logic_vector(2 downto 0);
			mux				: out std_logic_vector(3 downto 0);
			rf				: out std_logic_vector(4 downto 0)
		);
end component machine;

end package FSM;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.decode.all

entity machine is
	port(
		inp				: in std_logic_vector(3 downto 0);
        reset,clock		: in std_logic;
        di, t1, cz, alu	: out std_logic_vector(1 downto 0);
		z, ao, do, inc	: out std_logic;
		ir, pc			: out std_logic_vector(2 downto 0);
		mux				: out std_logic_vector(3 downto 0);
		rf				: out std_logic_vector(4 downto 0)
	);
end machine;

architecture machine_arch of machine is

type state is (rst,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20); 
signal y_present,y_next: state:=rst;
signal decoded: std_logic_vector(11 downto 0);

begin
	d1: decoder port map( i => inp, o => decoded );

	clock_proc : process (clock,reset)
	begin
		if(clock='1' and clock'event) then
			if(reset='1') then
				y_present<= rst;     -- Fill the code here
			else
				y_present<=y_next;                -- Fill the code here
			end if;
		end if;
	end process;

	state_transition_proc : process (decoded,y_present)
	begin
		case y_present is
			when rst=>
				y_next<=s1;
				do<= '0';
				di<='00';
				ao<='0';
				ir<='000';
				t1<='00';
				rf<='00000';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='0000';
				alu<='00';
			when s1=>
				if(unsigned(decoded)=1) then   --k
					y_next<=s8;
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
				elsif(unsigned(decoded)=2) then   
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s6;
				elsif(unsigned(decoded)=4) then   
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s6;
				elsif(unsigned(decoded)=8) then    
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s4;
				elsif(unsigned(decoded)=16) then   
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s4;
				elsif(unsigned(decoded)=32) then    
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s11;
				elsif(unsigned(decoded)=64) then   
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s5;
				elsif(unsigned(decoded)=128) then   
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s5;
				elsif(unsigned(decoded)=256) then   
					do<= '00';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s16;
				elsif(unsigned(decoded)=512) then   
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s1;
				elsif(unsigned(decoded)=1024) then   
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s1;
				elsif(unsigned(decoded)=2048) then   
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00000';
					inc<='0';
					pc<='001';
					di<='00';
					mux<='0000';
					alu<='00';
					y_next<=s8;
				end if;
			when s2=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='010';
				t1<='00';
				rf<='00011';
				inc<='0';
				pc<='011';
				di<='00';
				mux<='0000';
				alu<='11';
				y_next<=s3;
			when s3=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='010';
				t1<='01';
				rf<='00100';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='0000';
				alu<='00';
				y_next<=s1;
			when s7=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='011';
				t1<='00';
				rf<='00010';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='0000';
				alu<='10';
				y_next<=s3;
			when s8=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='001';
				t1<='00';
				rf<='00000';
				inc<='0';
				pc<='011';
				di<='00';
				mux<='0000';
				alu<='10';
				y_next<=s3;
			when s4=>
				if(unsigned(decode)=16) then
					do<= '0';
					di<='00';
					ao<='0';
					ir<='011';
					t1<='00';
					rf<='00010';
					inc<='0';
					pc<='011';
					di<='00';
					mux<='0000';
					alu<='10';
					y_next<=s9;
				elsif(unsigned(decode)=8) then
					do<= '0';
					di<='00';
					ao<='0';
					ir<='011';
					t1<='00';
					rf<='00010';
					inc<='0';
					pc<='011';
					di<='00';
					mux<='0000';
					alu<='10';
					y_next<=s10;
				end if;
			when s9=>
				do<= '0';
				di<='01';
				ao<='1';
				ir<='010';
				t1<='01';
				rf<='01000';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='0000';
				alu<='00';
				y_next<=s1;
			when s10=>
				do<= '1';
				di<='00';
				ao<='0';
				ir<='010';
				t1<='01';
				rf<='00010';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='0000';
				alu<='00';
				y_next<=s1;
			when s11=>
				if(z='1') then
					do<= '00';
					di<='00';
					ao<='0';
					ir<='010';
					t1<='00';
					rf<='00011';
					inc<='0';
					pc<='000';
					di<='00';
					mux<='0000';
					alu<='11';
					y_next<=s12;
				else 
					do<= '00';
					di<='00';
					ao<='0';
					ir<='010';
					t1<='00';
					rf<='00011';
					inc<='0';
					pc<='000';
					di<='00';
					mux<='0000';
					alu<='11';
					y_next<=s19;
				end if;
			when s12=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='010';
				t1<='00';
				rf<='00011';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='0000';
				alu<='11';
				y_next<=s1;
			when s19=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='000';
				t1<='00';
				rf<='00000';
				inc<='0';
				pc<='011';
				di<='00';
				mux<='0000';
				alu<='00';
				y_next<=s1;
			when s13=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='000';
				t1<='01';
				rf<='00000';
				inc<='0';
				pc<='010';
				di<='00';
				mux<='0000';
				alu<='00';
				y_next<=s1;
			when s5=>
				if(unsigned(decode)=128) then
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00100';
					inc<='0';
					pc<='100';
					di<='00';
					mux<='0000';
					alu<='11';
					y_next<=s15;
				elsif(unsigned(decode)=64) then
					do<= '0';
					di<='00';
					ao<='0';
					ir<='000';
					t1<='00';
					rf<='00100';
					inc<='0';
					pc<='100';
					di<='00';
					mux<='0000';
					alu<='11';
					y_next<=s14;
				end if;
			when s14=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='001';
				t1<='00';
				rf<='00000';
				inc<='0';
				pc<='100';
				di<='00';
				mux<='0000';
				alu<='11';
				y_next<=s13;
			when s15=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='010';
				t1<='00';
				rf<='00001';
				inc<='0';
				pc<='010';
				di<='00';
				mux<='0000';
				alu<='00';
				y_next<=s1;
			when s6=>
				if (unsigned(cz)=4) then
					do<= '0';
					di<='00';
					ao<='0';
					ir<='010';
					t1<='00';
					rf<='00011';
					inc<='0';
					pc<='000';
					di<='00';
					mux<='0000';
					alu<='11';
					y_next<=s17;
				elsif (unsigned(cz)=2) then
					do<= '0';
					di<='00';
					ao<='0';
					ir<='010';
					t1<='00';
					rf<='00011';
					inc<='0';
					pc<='000';
					di<='00';
					mux<='0000';
					alu<='11';
					y_next<=s18;
				else
					do<= '0';
					di<='00';
					ao<='0';
					ir<='010';
					t1<='00';
					rf<='00011';
					inc<='0';
					pc<='000';
					di<='00';
					mux<='0000';
					alu<='11';
					y_next<=s20;
				end if;
			when s17=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='010';
				t1<='01';
				rf<='10010';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='0011';
				alu<='00';
				y_next<=s1;
			when s18=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='010';
				t1<='01';
				rf<='10010';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='0101';
				alu<='00';
				y_next<=s1;
			when s20=>
				do<= '0';
				di<='00';
				ao<='0';
				ir<='010';
				t1<='01';
				rf<='10010';
				inc<='0';
				pc<='000';
				di<='00';
				mux<='1001';
				alu<='00';
				y_next<=s1;
			end case;
	end process;
end machine_arch;