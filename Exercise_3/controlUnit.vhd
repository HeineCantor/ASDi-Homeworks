
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity controlUnit is
    port(
        CLK100MHZ : in std_logic;
    
        switchInput : in std_logic;
        switchMode : in std_logic;
        
        btnInput : in std_logic;
        btnMode : in std_logic;
        btnReset : in std_logic;
        
        ledOutput : out std_logic
    );
end controlUnit;

architecture Behavioral of controlUnit is

    component debouncer is
        generic(
        activation_ms : integer :=5
    );
  Port (    clk: in std_logic;
            button: in std_logic;
            pressed: out std_logic     
   );
    end component;

    component Riconoscitore_101 is
    Port ( 
        x: in std_logic;
        A: in std_logic;
        RST: in std_logic;
        M: in std_logic;
        y: out std_logic
    );
    end component;

signal pressedInput: std_logic := '0';
signal pressedMode: std_logic := '0';
signal stepRiconoscitore : std_logic := '0';

begin
    

    debouncerInput: debouncer port map(
           clk => CLK100MHZ,
           button => btnInput,
           pressed=>pressedInput      
        );

    debouncerMode: debouncer port map(
           clk => CLK100MHZ,
           button => btnMode,
           pressed=>pressedMode      
        );
        
    riconoscitore: Riconoscitore_101 port map(
        x=>switchInput,
        A=>pressedInput,
        RST=>btnReset,
        M=>switchMode,
        y=>ledOutput
    );    
    
--    stepUpdate : process(CLK100MHZ, pressedInput, pressedMode, stepRiconoscitore) 
--        variable oldPressedInput : std_logic := 'U';
--        begin
--        if(oldPressedInput = '1' and pressedInput = '0') then
--            stepRiconoscitore <= '1';
--        else
--            stepRiconoscitore <= '0';
--        end if;
        
--        oldPressedInput := pressedInput;
--    end process;
        
end Behavioral;
