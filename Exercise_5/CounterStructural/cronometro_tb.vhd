
library ieee;
use ieee.std_logic_1164.all;

entity tb_cronometro is
end tb_cronometro;

architecture tb of tb_cronometro is

    component cronometro
    Port (
        C: in std_logic;
        R: in std_logic;
        SET: in std_logic;
        LOAD_HOUR: in std_logic_vector(0 to 5);
        LOAD_MIN: in std_logic_vector(0 to 5);
        LOAD_SEC: in std_logic_vector(0 to 5);
        HOUR: out std_logic_vector(0 to 5);
        MIN: out std_logic_vector(0 to 5);
        SEC: out std_logic_vector(0 to 5)
        );
    end component;
    
    
signal clk_tb : std_logic;
signal hour : std_logic_vector (0 to 5);
signal min : std_logic_vector (0 to 5);
signal sec : std_logic_vector (0 to 5);

constant clk_period : time := 20 ns;

signal rst    : std_logic;
signal SET  : std_logic;
signal load_hour  : std_logic_vector (0 to 5);
signal load_min  : std_logic_vector (0 to 5);
signal load_sec  : std_logic_vector (0 to 5);



begin
    clk_process: process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;
    
    dut : cronometro
    port map (C    => clk_tb,
              R    => rst,
              SET  => SET,
              LOAD_HOUR => load_hour,
              LOAD_MIN => load_min,
              LOAD_SEC => load_sec,
              HOUR => hour,
              MIN => min,
              SEC => sec );

    stimuli : process
    begin
    
        set <= '0';
        rst <= '1';
        wait for 10000 ns;
        
        rst<='0';
        wait for 1000000 ns;
        
--        rst <='1';
--        wait for  10000 ns;
          
--        rst<='0';
--        wait for 10000 ns;
        
--        load_hour <="101101";
--        load_min <="010111";
--        load_sec <="001001";
--        wait for 12000 ns;
        
--        set<='1';
--        wait for 10000 ns;
        
--        set<='0';
--        wait for 10000 ns;

        
        wait;
    end process;

end tb;
