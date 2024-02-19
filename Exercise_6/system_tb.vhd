library ieee;
use ieee.std_logic_1164.all;

entity tb_system is
end tb_system;

architecture tb of tb_system is

    component system
        port (START  : in std_logic;
              CLK    : in std_logic;
              RST    : in std_logic;
              STOP   : out std_logic;
              OUTPUT : out std_logic_vector (3 downto 0));
    end component;

    signal START  : std_logic;
    signal RST    : std_logic;
    signal STOP   : std_logic;
    signal OUTPUT : std_logic_vector (3 downto 0) :="0000";
    
    signal clk_tb : std_logic;
    constant clk_period : time := 20 ns;

begin

       -- Clock generation
   clk_process : process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;
    
    
    dut : system
    port map (START  => START,
              CLK    => clk_tb,
              RST    => RST,
              STOP   => STOP,
              OUTPUT => OUTPUT);

    stimuli : process
    begin
        
        START <= '0';
        RST <= '0';
        wait for 30 ns;
        
        
        START <= '1';
        wait for 700 ns;
        
        RST <= '1';
        wait for 50 ns;
        
        RST <= '0';

        
        
       
        
        
--        if STOP = '1' THEN
--            START<='0';
--        END IF;
--        wait for 100 ns;
        
--        RST <='1';
--        wait for 100 ns;
        
--        RST <='0';
--        wait for 100 ns;
        
--        START <='1';
--        wait for 300 ns;
        

        
        wait;
    end process;

end tb;