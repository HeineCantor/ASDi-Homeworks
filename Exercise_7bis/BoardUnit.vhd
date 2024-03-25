library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardUnit is
    port(
        clock: in std_logic;
        btnReset, btnStart: in std_logic;
        switch: in std_logic_vector(15 downto 0);
        
        ledDivisionFinished: out std_logic;
        anodes, cathodes: out std_logic_vector(7 downto 0)
    );
end BoardUnit;

architecture Behavioral of BoardUnit is

    component NonRestoringDivider is
        port(
            clock, reset, start:    in std_logic;
            D, V:                   in std_logic_vector(3 downto 0);
            Q, R:                   out std_logic_vector(3 downto 0);
            divisionFinished:       out std_logic
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
    
    component Mux2to1 is
        generic (
            width : integer range 0 to 32 := 8
        );
        port( 
           a, b: in std_logic_vector(width-1 downto 0); 
           sel: in std_logic;
           o: out std_logic_vector(width-1 downto 0)
        );
    end component;
    
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
    
    component EncoderBCD is
        port(
            input: in std_logic_vector(3 downto 0);
            
            output: out std_logic_vector(7 downto 0)
        );
    end component;

    signal resetSignal, startSignal, operationCompleted: std_logic;
    
    signal operand1, operand2, result, rest: std_logic_vector(3 downto 0);
    signal displayOperand1, displayOperand2, displayResult, displayRest: std_logic_vector(7 downto 0);
    
    signal displayValue: std_logic_vector(31 downto 0);
begin

    debouncerStart: ButtonDebouncer
    port map(
        rst => resetSignal,
        clk => clock,
        btn => btnStart,
        cleared_btn => startSignal
    );
    
    displayMux: Mux2to1
    generic map(
        width => 32
    )
    port map(
        a => "00000000" & displayOperand1 & "00000000" & displayOperand2,
        b => "00000000" & displayResult & "00000000" & displayRest,
        sel => operationCompleted,
        o => displayValue
    );
    
    dividerBCD: EncoderBCD
    port map(
        input => operand1,
        output => displayOperand1
    );
    
    divisorBCD: EncoderBCD
    port map(
        input => operand2,
        output => displayOperand2
    );
    
    resultBCD: EncoderBCD
    port map(
        input => result,
        output => displayResult
    );
    
    restBCD: EncoderBCD
    port map(
        input => rest,
        output => displayRest
    );
    
    displayManager: display_seven_segments
    port map(
        clk => clock,
        rst => resetSignal,
        value => displayValue,
        enable => (others => '1'),
        dots => (others => '0'),
        anodes => anodes,
        cathodes => cathodes
    );

    dividerSystem: NonRestoringDivider
    port map(
        clock => clock,
        reset => resetSignal,
        start => startSignal,
        D => operand1,
        V => operand2,
        Q => result,
        R => rest,
        divisionFinished => operationCompleted
    );
    
    operand1 <= switch(11 downto 8);
    operand2 <= switch(3 downto 0);
    ledDivisionFinished <= operationCompleted;
    resetSignal <= btnReset;

end Behavioral;
