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
        
            DATA_IN: out STD_LOGIC_VECTOR(7 downto 0);
            DATA_OUT: out STD_LOGIC_VECTOR(7 downto 0);
            PE: out STD_LOGIC;
            FE: out STD_LOGIC;
            OE: out STD_LOGIC;
            
            WR: out STD_LOGIC;
            TY: out STD_LOGIC;
            EN_COUNT: out STD_LOGIC
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
    
    signal resetSignal, writeSignal, readSignal: std_logic;
    signal oeSignal: std_logic;
    
    signal gndSignal: std_logic_vector(7 downto 0) := (others => '0');
    
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
    
    system: UART_SYSTEM
    port map(
        clk => clock,
        reset => resetSignal,
        en_wr => writeSignal,
        en_rd => readSignal,
        
        data_in => open,
        data_out => open,
        
        pe => open,
        fe => open,
        oe => oeSignal,
        
        wr => open,
        ty => open,
        en_count => open
    );

    anodes <= gndSignal;
    cathodes <= gndSignal;

    resetSignal <= btnReset;
    ledOE <= oeSignal;
end Structural;
