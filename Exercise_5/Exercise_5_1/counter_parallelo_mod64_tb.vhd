
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_mod_64_parallelo_tb is
end counter_mod_64_parallelo_tb;

architecture tb of counter_mod_64_parallelo_tb is

component counter_mod_64_parallelo is
  Port (
    C: in std_logic;
    R: in std_logic;
    MAX_CONT: in std_logic;
    SET: in std_logic;
    LOAD: in std_logic_vector(0 to 5);
    cont: out std_logic_vector(0 to 5)
  );
end component;

signal clk_tb : std_logic;
signal output : std_logic_vector (0 to 5);
signal rst : std_logic;
signal max: std_logic;
signal set: std_logic;
signal load: std_logic_vector(0 to 5);

constant clk_period : time := 20 ns;


begin
    clk_process: process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;
    
    
    uut : counter_mod_64_parallelo
    port map (C => clk_tb,
              R => rst,
              MAX_CONT => max,
              SET=> set,
              LOAD => load,
              cont => output);
   
   
   stimuli : process
   begin
   
        set<='0';
        load<="111111";
        rst <= '1';
        
        wait for 100 ns;
        
        rst<='0';
        wait for 100 ns;
        
        rst <='1';
        wait for 50 ns;
        
        rst<='0';
        wait for 50 ns;
        
        load<="101110";
        wait for 30 ns;
        
        set<='1';
        wait for 25 ns;
      
        set<='0';
        wait for 25 ns;
       
        
        wait;
   end process;
   
end tb;