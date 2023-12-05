library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer_tb is
--  Port ( );
end debouncer_tb;

architecture Behavioral of debouncer_tb is

constant CLK_period : time := 10 ns;
signal CLK : std_logic := '0';
signal input: std_logic := 'U';
signal output: std_logic := 'U';

component debouncer is
    generic(
        activation_ms : integer := 5
    );
  Port (    clk: in std_logic;
            button: in std_logic;
            pressed: out std_logic     
   );
end component;

begin


   uut: debouncer port map(
        clk=>clk,
        button=>input,
        pressed=>output
        );


   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin
    wait for 100 ns;	
   
   input <= '0';
   
   wait for 10ms;

   input <= '1';
   wait for 3ms;
   input <= '0';
   wait for 1ms;
   
   input <= '1';
   wait for 10ms;
   
   input <= '0';
   wait for 10ms;
   
   input <= '1';
   wait for 130ms;
    
    
    input <= '0';
    
   wait;
   end process;
 
end Behavioral;
