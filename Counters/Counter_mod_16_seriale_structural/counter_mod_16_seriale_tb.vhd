
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_mod_16_seriale_tb is
end counter_mod_16_seriale_tb;

architecture tb of counter_mod_16_seriale_tb is

component counter_mod_16_seriale is
  Port (
    C: in std_logic;
    R: in std_logic;
    cont: out std_logic_vector(0 to 3)
  );
end component;

signal clk_tb : std_logic;
signal output : std_logic_vector (0 to 3);
signal rst : std_logic;

constant clk_period : time := 20 ns;


begin
    clk_process: process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;
    
    
    uut : counter_mod_16_seriale
    port map (C => clk_tb,
              R => rst,
              cont => output);
   
   
   stimuli : process
   begin
        rst <= '1';
        wait for 100ns;
        
        rst<='0';
        
        wait for 200 ns;
        
        wait;
   end process;
   
end tb;
   
