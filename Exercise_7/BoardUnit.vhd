library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardUnit is
    port(
        clock: in std_logic;
        btnConfirm, btnReset: in std_logic;
        switch: in std_logic_vector(15 downto 0);
    
        ledProductFinished: out std_logic;
        cathodes, anodes: out std_logic_vector(7 downto 0)
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
    
    component MoltiplicatoreBooth is
        port(
            clock, reset, start:    in std_logic;
            X, Y:               in std_logic_vector(7 downto 0);
            
            P:                  out std_logic_vector(15 downto 0);
            productFinished:    out std_logic
        );
    end component;
    
    type state is (idle, startMultiplication, multiplicationFinished);
    signal currentState, nextState: state;
    
    signal operandsToPrint: std_logic_vector(31 downto 0);
    signal multiplySignal, start, reset: std_logic := '0';
    
    signal enableSignal: std_logic_vector(7 downto 0);
    
    signal outputProduct: std_logic_vector(15 downto 0);
    signal productReady: std_logic := '0';
    
begin
    boothMultiplier: MoltiplicatoreBooth
    port map(
        X => switch(15 downto 8),
        Y => switch(7 downto 0),
        
        clock => clock,
        reset => reset,
        start => start,
        
        P => outputProduct,
        productFinished => productReady
    );

    multiplyDebouncer: ButtonDebouncer
    port map(
        rst => reset,
        clk => clock,
        btn => btnConfirm,
        cleared_btn => multiplySignal
    );

    display: display_seven_segments
    port map(
        clk => clock,
        rst => reset,
        value => operandsToPrint,
        enable => enableSignal,
        dots => "00000000",
        anodes => anodes,
        cathodes => cathodes
    );
    
    reset <= btnReset;
    
    updateState: process(clock)
    begin
        if(clock'event and clock='1') then
            if(reset='1') then
                currentState <= idle;
            else
                currentState <= nextState;
            end if;    
        end if;
    end process;
    
    automa: process(currentState, multiplySignal, productReady)
    begin
        ledProductFinished <= '0';
        start <= '0';
    
        case currentState is
            when idle =>
                if (multiplySignal = '1') then
                    nextState <= startMultiplication;
                else
                    nextState <= idle;
                    enableSignal <= "00110011";
                    operandsToPrint <= "00000000" & switch(15 downto 8) & "00000000" & switch(7 downto 0);
                end if;
            when startMultiplication =>
                start <= '1';
                
                if (productReady = '1') then
                    nextState <= multiplicationFinished;
                else
                    nextState <= startMultiplication;
                end if;
            when multiplicationFinished =>
                nextState <= multiplicationFinished;
                ledProductFinished <= '1';
                enableSignal <= "00001111";
                operandsToPrint <= "0000000000000000" & outputProduct;
        end case;
    end process;

end structural;
