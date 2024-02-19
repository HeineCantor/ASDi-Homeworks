library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardUnit is
    port(
        clock: in std_logic;
        btnConfirm, btnStart, btnReset: in std_logic;
        
        ledResult: out std_logic_vector(3 downto 0); 
        ledFinished, ledStarted: out std_logic
    );
end BoardUnit;

architecture structural of BoardUnit is

    component system is
            Port ( 
            START: in STD_LOGIC;
            enableRead: in STD_LOGIC;
            CLK: in STD_LOGIC;
            RST: in STD_LOGIC;
            STOP: out STD_LOGIC;
            OUTPUT: out STD_LOGIC_VECTOR(3 downto 0) :="0000"
        );
    end component;
    
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

    signal enableRead, start: std_logic;

begin

    debouncerRead: ButtonDebouncer
    port map(
        clk => clock,
        rst => btnReset,
        btn => btnConfirm,
        cleared_btn => enableRead
    );
    
    debouncerStart: ButtonDebouncer
    port map(
        clk => clock,
        rst => btnReset,
        btn => btnStart,
        cleared_btn => start
    );

    sistema: system
    port map(
        start => start,
        enableRead => enableRead,
        clk => clock,
        rst => btnReset,
        STOP => ledFinished,
        output => ledResult
    );

end structural;
