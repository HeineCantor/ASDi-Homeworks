library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity controlUnit_tb is
end controlUnit_tb;

architecture Behavioral of controlUnit_tb is

component controlUnit is
    port(
        CLK100MHZ : in std_logic;
    
        switchInput : in std_logic;
        switchMode : in std_logic;
        
        btnInput : in std_logic;
        btnMode : in std_logic;
        btnReset : in std_logic;
        
        ledOutput : out std_logic
    );
end component;


    signal testInput: std_logic;
    signal testMode: std_logic;
    signal testBtnInput: std_logic;
    signal testBtnMode: std_logic;
    signal testBtnReset: std_logic;
    signal testLedOutput: std_logic;

    signal clk_tb : std_logic;
    constant clk_period : time := 10 ns; 
    
    
begin

    -- Clock generation
   clk_process : process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;






uut: controlUnit
port map(
        CLK100MHZ=>clk_tb,
        switchInput=>testInput,
        switchMode=>testMode,
        btnInput=>testBtnInput,
        btnMode=>testBtnMode,
        btnReset=>testBtnReset,
        ledOutput=>testLedOutput
);


   stimuli : process
    begin
      
        testBtnReset <= '1';
        wait for 10ns;
        testBtnReset <= '0';
        
        
        testMode <= '1';
        
        
        testInput <='1';
        testBtnInput <='1';
        wait for 20 ms;
        
        
        testBtnInput <='0';
        wait for 2ms;
        
        
        testInput <='0';
         wait for 20 ms;
        testBtnInput <='1';
        wait for 6 ms;
        
        
        testBtnInput <='0';
        wait for 1ms;
        
        
        testInput <='1';
        testBtnInput <='1';
        wait for 100 ms;
        testBtnInput <='0';



        wait for 100ns;  --global reset
       
        wait;
    end process;

end Behavioral;
