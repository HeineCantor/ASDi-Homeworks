library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardUnit is
    port(
        clock: in std_logic;
        btnSet, btnCancel, btnReset, btnUp, btnDown: in std_logic;
        switch: in std_logic_vector(5 downto 0);
        
        ledMem: out std_logic_vector(15 downto 0);
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
               ENABLE : in  STD_LOGIC_VECTOR (7 downto 0);
               DOTS : in  STD_LOGIC_VECTOR (7 downto 0);
               ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
               CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component ButtonDebouncer is
        generic (                       
            CLK_period: integer := 10;
            btn_noise_time: integer := 10000000
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
            CLKIN_freq : integer := 100000000;
            CLKOUT_freq : integer := 500
                );
        Port ( 
           clock_in : in  STD_LOGIC;
           reset : in STD_LOGIC;
           clock_out : out  STD_LOGIC
        ); 
    end component;
    
    component EncoderDecimalBCD is
        port(
            input: in std_logic_vector(0 to 5);
            
            output: out std_logic_vector(7 downto 0)
        );
    end component;
    
    component EncoderOneHotBCD is
        port(
            input: in std_logic_vector(3 downto 0);
            
            output: out std_logic_vector(15 downto 0)
        );
    end component;
    
    component BoardControlUnit is
        port(
            clock, reset: in std_logic;
            setSignal: in std_logic;
            intertimeSignal: in std_logic;
            cancelSignal:   in std_logic;
            switchInput: in std_logic_vector(5 downto 0);
            
            enableClock: out std_logic;
            loadSignal: out std_logic;
            selSec, selMin, selHour: out std_logic_vector(5 downto 0);
            selDisplayOutput:  out std_logic_vector(1 downto 0);
            memoryWrite, memoryRead: out std_logic
        );
    end component;
    
    component mem is
        generic(
            address_length: natural := 3;
            data_length: natural := 4
        );
        port(
            clock: in std_logic;
            read: in std_logic;
            write: in std_logic;
            address: in std_logic_vector(address_length - 1 downto 0);
            data_input: in std_logic_vector (data_length - 1 downto 0);
            data_output: out std_logic_vector (data_length - 1 downto 0) := "0000"
        );
    end component;
    
    component UpDownCounter is
        generic( 
            dim: integer :=6
        );
        Port ( 
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enableUp, enableDown : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (dim-1 downto 0)
        ); 
    end component;
    
    component Mux3to1 is
        generic (
            width : integer range 1 to 32 := 24
        );
        port( 
           a, b, c: in std_logic_vector(width-1 downto 0); 
           sel: in std_logic_vector(1 downto 0);
           o: out std_logic_vector(width-1 downto 0)
        );
    end component;
    
    signal setSignal, upSignal, downSignal, cancelSignal, reset, loadSignal: std_logic := '0';
    signal setHour, setMinute, setSeconds: std_logic_vector (0 to 5) := (others => '0');
    signal hourValue, minValue, secValue: std_logic_vector (0 to 5) := (others => '0');
    signal decimalSeconds, decimalMinutes, decimalHours: std_logic_vector(7 downto 0) := (others => '0');
    
    signal intertimeVisualizationSignal: std_logic;
    
    signal enableClock: std_logic := '1';
    signal enableDisplaySignal: std_logic_vector(7 downto 0);
    
    signal singleHzClock: std_logic;
    signal valueToPrint: std_logic_vector(31 downto 0);
    
    signal memRead, memWrite: std_logic := '0';
    signal memAddressSignal: std_logic_vector(3 downto 0) := (others => '0');
    signal memBusIn, memBusOut: std_logic_vector(31 downto 0) := (others => '0');
    
    signal oneHotSelectedAddress: std_logic_vector(15 downto 0) := (others => '0');
    
    signal clockDisplay, setTimeDisplay, viewIntertimeDisplay: std_logic_vector(31 downto 0);
    signal displayMuxSelector: std_logic_vector(1 downto 0);
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
        btn => btnDown,
        cleared_btn => downSignal
    );
    
    cancelButtonDebouncer: ButtonDebouncer
    port map(
        rst => reset,
        clk => clock,
        btn => btnCancel,
        cleared_btn => cancelSignal
    );

    bcdEncoderSeconds: EncoderDecimalBCD
    port map(
        input => secValue,
        
        output => decimalSeconds
    );
    
    bcdEncoderMinutes: EncoderDecimalBCD
    port map(
        input => minValue,
        
        output => decimalMinutes
    );
    
    bcdEncoderHours: EncoderDecimalBCD
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

    clockDisplay <= "00000000" & decimalHours & decimalMinutes & decimalSeconds;
    setTimeDisplay <= "0000000000" & setHour & "00" & setMinute & "00" & setSeconds;
    viewIntertimeDisplay <= memBusOut;

    displayMux: Mux3to1
    generic map(
        width => 32
    )
    port map(
        a => clockDisplay,
        b => setTimeDisplay,
        c => viewIntertimeDisplay,
        sel => displayMuxSelector,
        o => valueToPrint
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
    
    intertimeVisualizationSignal <= upSignal or downSignal;
    
    controlUnit: BoardControlUnit
    port map(
        clock => clock, 
        reset => reset,
        setSignal => setSignal,
        intertimeSignal => intertimeVisualizationSignal,
        cancelSignal => cancelSignal,
        switchInput => switch,
        enableClock => enableClock,
        selSec => setSeconds,
        selMin => setMinute,
        selHour => setHour,
        loadSignal => loadSignal,
        selDisplayOutput => displayMuxSelector,
        memoryWrite => memWrite,
        memoryRead => memRead
    );
    
    memAddressCounter: UpDownCounter
    generic map(
        dim => 4
    )
    port map(
        clock => clock,
        reset => reset,
        enableUp => upSignal,
        enableDown => downSignal,
        counter => memAddressSignal
    );
    
    selectedAddress: EncoderOneHotBCD
    port map(
        input => memAddressSignal,
        
        output => oneHotSelectedAddress
    );
    
    memoriaIntertempi: mem
    generic map(
        address_length => 4,
        data_length => 32
    )
    port map(
        clock => clock,
        read => memRead,
        write => memWrite,
        address => memAddressSignal,
        data_input => memBusIn,
        data_output => memBusOut
    );
    
    memBusIn <= clockDisplay;
    reset <= btnReset;
    ledMem <= oneHotSelectedAddress;

end structural;
