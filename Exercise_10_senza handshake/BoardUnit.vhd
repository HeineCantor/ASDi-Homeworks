library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardUnit is
    port(
        clock: in std_logic;
        btnWrite, btnRead: in std_logic;
        btnReset: in std_logic;
        
        ledOE: out std_logic;
        cathodes, anodes: out std_logic_vector(7 downto 0)
    );
end BoardUnit;

architecture Structural of BoardUnit is
    component UART_SYSTEM is
        generic( M: natural := 8 );
        port(
            CLK: in STD_LOGIC;
            RESET: in STD_LOGIC;
            EN_WR, EN_RD: in STD_LOGIC;
        
            DATA_OUT: out STD_LOGIC_VECTOR(7 downto 0);
            PE: out STD_LOGIC;
            FE: out STD_LOGIC;
            OE: out STD_LOGIC
        );
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
    
    signal resetSignal, writeSignal, readSignal: std_logic;
    signal oeSignal: std_logic;
    
    signal currentDbOut: std_logic_vector(7 downto 0);
    signal valueSignal: std_logic_vector(31 downto 0) := (others => '0');
    
begin

    debouncerWrite: ButtonDebouncer
    port map(
        rst => resetSignal,
        clk => clock,
        btn => btnWrite,
        cleared_btn => writeSignal
    );
    
    debouncerRead: ButtonDebouncer
    port map(
        rst => resetSignal,
        clk => clock,
        btn => btnRead,
        cleared_btn => readSignal
    );
    
    displayManager: display_seven_segments
    port map(
        clk => clock,
        rst => resetSignal,
        value => valueSignal,
        enable => "00000011",
        dots => (others => '0'),
        anodes => anodes,
        cathodes => cathodes
    );
    
    system: UART_SYSTEM
    port map(
        clk => clock,
        reset => resetSignal,
        en_wr => writeSignal,
        en_rd => readSignal,
        
        data_out => currentDbOut,
        
        pe => open,
        fe => open,
        oe => oeSignal
    );

    valueSignal <= "000000000000000000000000" & currentDbOut;

    resetSignal <= btnReset;
    ledOE <= oeSignal;
end Structural;
