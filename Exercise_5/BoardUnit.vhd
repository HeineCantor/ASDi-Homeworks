library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardUnit is
    port(
        clock: in std_logic;
        btnSet, btnCancel, btnReset, btnUp, btnDown: in std_logic;
        switch: in std_logic_vector(15 downto 0);
        
        anodes, cathodes: out std_logic_vector(7 downto 0)
    );
end BoardUnit;

architecture structural of BoardUnit is
    component display_seven_segments is
        Generic( 
                    CLKIN_freq : integer := 100000000; 
                    CLKOUT_freq : integer := 500
                    );
        Port ( CLK : in  STD_LOGIC;
               RST : in  STD_LOGIC;
               VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
               ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
               DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
               ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
               CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
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
    
    component cronometro is
        Port (
            C: in std_logic;
            R: in std_logic;
            SET: in std_logic;
            EN: in std_logic;
            LOAD_HOUR: in std_logic_vector(0 to 5);
            LOAD_MIN: in std_logic_vector(0 to 5);
            LOAD_SEC: in std_logic_vector(0 to 5);
            HOUR: out std_logic_vector(0 to 5);
            MIN: out std_logic_vector(0 to 5);
            SEC: out std_logic_vector(0 to 5)
            );
    end component;
    
    component clock_filter is
        generic(
            CLKIN_freq : integer := 100000000; --clock board 100MHz
            CLKOUT_freq : integer := 500       --frequenza desiderata 500Hz
                );
        Port ( 
           clock_in : in  STD_LOGIC;
           reset : in STD_LOGIC;
           clock_out : out  STD_LOGIC -- attenzione: non � un vero clock ma un impulso che sar� usato come enable
        ); 
    end component;
    
    component EncoderBCD is
        port(
            input: in std_logic_vector(0 to 5);
            
            output: out std_logic_vector(7 downto 0)
        );
    end component;
    
    component BoardControlUnit is
        port(
            clock, reset: in std_logic;
            setSignal: in std_logic;
            cancelSignal:   in std_logic;
            switchInput: in std_logic_vector(15 downto 0);
            secInput, minInput, hourInput: in std_logic_vector(7 downto 0);
            
            enableClock: out std_logic;
            loadSignal: out std_logic;
            selSec, selMin, selHour: out std_logic_vector(5 downto 0);
            displayEnable: out std_logic_vector(7 downto 0);
            valueToPrint:  out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal setSignal, upSignal, downSignal, cancelSignal, reset, loadSignal: std_logic := '0';
    signal setHour, setMinute, setSeconds: std_logic_vector (0 to 5) := (others => '0');
    signal hourValue, minValue, secValue: std_logic_vector (0 to 5) := (others => '0');
    signal decimalSeconds, decimalMinutes, decimalHours: std_logic_vector(7 downto 0) := (others => '0');
    
    signal enableClock: std_logic := '1';
    signal enableDisplaySignal: std_logic_vector(7 downto 0);
    
    signal singleHzClock: std_logic;
    signal valueToPrint: std_logic_vector(31 downto 0);
begin

    setButtonDebouncer: ButtonDebouncer
    port map(
        rst => reset,
        clk => clock,
        btn => btnSet,
        cleared_btn => setSignal
    );
    
    upButtonDebouncer: ButtonDebouncer
    port map(
        rst => reset,
        clk => clock,
        btn => btnUp,
        cleared_btn => upSignal
    );
    
    downButtonDebouncer: ButtonDebouncer
    port map(
        rst => reset,
        clk => clock,
        btn => btnUp,
        cleared_btn => downSignal
    );

    bcdEncoderSeconds: EncoderBCD
    port map(
        input => secValue,
        
        output => decimalSeconds
    );
    
    bcdEncoderMinutes: EncoderBCD
    port map(
        input => minValue,
        
        output => decimalMinutes
    );
    
    bcdEncoderHours: EncoderBCD
    port map(
        input => hourValue,
        
        output => decimalHours
    );

    singleHzDivider: clock_filter
    generic map(
        CLKIN_freq => 100000000,
        CLKOUT_freq => 1
    )
    port map(
        clock_in => clock,
        reset => btnReset,
        clock_out => singleHzClock
    );

    display: display_seven_segments
    port map(
        clk => clock,
        rst => btnReset,
        value => valueToPrint,
        enable => "00111111",
        dots => "00000100",
        anodes => anodes,
        cathodes => cathodes
    );
    
    orologio: cronometro
    port map(
        c => singleHzClock,
        r => btnReset,
        set => loadSignal,
        en => enableClock,
        load_hour => setHour,
        load_min => setMinute, 
        load_sec => setSeconds, 
        hour => hourValue,
        min => minValue,
        sec => secValue
    );
    
    controlUnit: BoardControlUnit
    port map(
        clock => clock, 
        reset => reset,
        setSignal => setSignal,
        cancelSignal => '0',
        switchInput => switch,
        secInput => decimalSeconds,
        minInput => decimalMinutes,
        hourInput => decimalHours,
        enableClock => enableClock,
        selSec => setSeconds,
        selMin => setMinute,
        selHour => setHour,
        loadSignal => loadSignal,
        displayEnable => enableDisplaySignal,
        valueToPrint => valueToPrint
    );
    
    reset <= btnReset;

end structural;
