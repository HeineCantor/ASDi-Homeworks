
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

    component ButtonDebouncer is
        generic (                       
            CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
            btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                                -- il valore di default è 10 millisecondi
        );
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC;
               CLEARED_BTN : out STD_LOGIC);
    end component;

    component Riconoscitore_101 is
        Port ( 
            x: in std_logic;
            A: in std_logic;
            clock, reset: in std_logic;
            M: in std_logic := '1';
            y: out std_logic;
            
            debugState: out std_logic_vector(0 to 4)
        );
    end component;

signal pressedInput: std_logic := '0';
signal pressedMode: std_logic := '0';
signal stepRiconoscitore : std_logic := '0';

begin
    

    debouncerInput: ButtonDebouncer
    port map(btnReset, CLK100MHZ, btnInput, pressedInput);

    debouncerMode: ButtonDebouncer
    port map(btnReset, CLK100MHZ, btnMode, pressedMode);
        
    riconoscitore: Riconoscitore_101 port map(
        x=>switchInput,
        A=>pressedInput,
        clock => CLK100MHZ,
        reset=>btnReset,
        M=>switchMode,
        y=>LED16_B,
        debugState => stateLed
    );    
        
end Behavioral;
