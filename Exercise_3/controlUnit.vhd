
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
        
        ledOutput : out std_logic;
        ledTest : out std_logic;
        
        stateLed : out std_logic_vector (0 to 4);
        LED16_B : out std_logic;
        LED17_R : out std_logic
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
        y: out std_logic;
        debugState: out std_logic_vector(0 to 4)
    );
    end component;

signal pressedInput: std_logic := '0';
signal pressedMode: std_logic := '0';
signal stepRiconoscitore : std_logic := '0';

begin
    

    debouncerInput: debouncer
     port map(
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
        y=>ledOutput,
        debugState => stateLed
    );    
    
    testLed : process(CLK100MHZ, switchInput, pressedInput, btnInput)
    begin
        ledTest <= switchInput;
        LED16_B <= pressedInput;
        LED17_R <= btnInput;
    end process;
    
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
