
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_tb is
end full_adder_tb;

architecture full_adder of full_adder_tb is

    component full_adder
        port( 
        a: in std_logic;
        b: in std_logic;
        carry_in: in std_logic;
    
        sum:out std_logic;
        carry_out:out std_logic
    );
    
    end component; 
    
    signal x_1	     : STD_LOGIC := 'U';
	signal x_2 	     : STD_LOGIC := 'U'; 
	signal c_i         : STD_LOGIC := 'U'; 
	signal y           : STD_LOGIC := 'U'; 
	signal c_o      : STD_LOGIC := 'U'; 

begin
    utt: entity work.full_adder(dataflow) port map(
        a=> x_1,
        b=> x_2,
        carry_in => c_i,
        sum => y,
        carry_out => c_o
    );
    
    
stim_proc: process
  begin
  
    wait for 100 ns;
    
    	x_1 <= '0';
		x_2 <= '0';
		c_i <= '0';
		
		wait for 10ns;
		
		x_1 <= '1';
		
		wait for 10ns;
		
		x_1 <= '0';
		x_2 <= '1';
		
		wait for 10ns;
		
		x_1 <= '1';
		
		wait for 10ns;
		
		x_1 <= '0';
		x_2 <= '0';
		c_i <= '1';
		
		wait for 10ns;
		
        x_1 <= '1';
		
		wait for 10ns;
		
		x_1 <= '0';
		x_2 <= '1';
		
		wait for 10ns;
		
		x_1 <= '1';
		
		wait for 10ns;
		
		wait;
		end process;

end full_adder;

