
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_mod_2_parallelo_tb is
end counter_mod_2_parallelo_tb;

architecture tb of counter_mod_2_parallelo_tb is

component counter_mod_2_parallelo is
  Port (
    C: in std_logic;
    R: in std_logic;
    MAX_CONT: in std_logic;
    SET: in std_logic;
    LOAD: in std_logic_vector(0 to 1);
    cont: out std_logic_vector(0 to 1)
  );
end component;

signal clk_tb : std_logic;
signal output : std_logic_vector (0 to 1);
signal rst : std_logic;
signal max: std_logic;
signal set: std_logic;
signal load: std_logic_vector(0 to 1);

constant clk_period : time := 20 ns;


begin
    clk_process: process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;
    
    
    uut : counter_mod_2_parallelo
    port map (C => clk_tb,
              R => rst,
              MAX_CONT => max,
              SET=> set,
              LOAD => load,
              cont => output);
   
   
   stimuli : process
   begin
   
--        set<='0';
--        load<="10";
--        rst <= '1';
        
--        wait for 1 ms;
        
--        rst<='0';
--        wait for 1 ms;
        
--        rst <='1';
--        wait for 0.2 ms;
        
--        --*********************** così non funziona, l'output rimane 00************************
--        rst<='0';
--        wait for 0.01 ms;
        
--        load<="10";  --10
--        wait for 0.2 ms;
--        -- ****************************************************************************************
        
        
        -- ************ho risolto, era colpa della sensitivity list del Flip Flop T******************
        
        
--        --*********************** così invece funziona ************************************
----        rst<='0';
----        wait for 0.001 ms; -- ho cambiato questo**********************************************
        
----        load<="01";
----        wait for 0.2 ms;
--        -- ****************************************************************************************
        
--        set<='1';
--        wait for 0.01 ms;
      
--        set<='0';
--        wait for 0.01 ms;
        
   
  


        set<='0';
        load<="10";
        rst <= '1';
        wait for 124 ns;  --100
        
        rst<='0';
        wait for 155.3 ns;  --100
        
        rst <='1';
        wait for 50.27 ns;    --50
        
        rst<='0';
        wait for 24 ns;    --10
        
        load<="01";       --"01"
        wait for 22 ns;   --30
  
        set<='1';
        wait for 21 ns;  --20
      
        set<='0';
        wait for 30 ns;
        
        wait;
   end process;
   
end tb;
   
