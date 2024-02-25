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
               ENABLE : in  STD_LOGIC_VECTOR (7 downto 0);
               DOTS : in  STD_LOGIC_VECTOR (7 downto 0);
               ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
               CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component EncoderSignedBCD is
        port(
            input: in std_logic_vector(7 downto 0);
            
            output: out std_logic_vector(15 downto 0)
        );
    end component;
    
    component EncoderSignedBCD16 is
        port(
            input: in std_logic_vector(15 downto 0);
            
            output: out std_logic_vector(23 downto 0)
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
    
    component MoltiplicatoreBooth is
        port(
            clock, reset, start:    in std_logic;
            X, Y:               in std_logic_vector(7 downto 0);
            
            P:                  out std_logic_vector(15 downto 0);
            productFinished:    out std_logic
        );
    end component;
    
    component Mux2to1 is
        generic (
            width : integer range 1 to 32 := 8
        );
        port( 
           a, b: in std_logic_vector(width-1 downto 0); 
           sel: in std_logic;
           c: out std_logic_vector(width-1 downto 0)
        );
    end component;
    
    component BoardControlUnit is
        port(
            clock, reset: in std_logic;
            
            multiplySignal, productReady: in std_logic;
            
            startMultiplication, displaySelector: out std_logic;
            productOperationFinish: out std_logic
        );
    end component;
    
    signal operand1, operand2: std_logic_vector(7 downto 0) := (others => '0');
    signal displayOperand1, displayOperand2: std_logic_vector(15 downto 0) := (others => '0');
    signal displayResult: std_logic_vector(23 downto 0);
    signal operandsDisplay, resultDisplay, valueToPrint: std_logic_vector(31 downto 0);
    signal multiplySignal, start, reset: std_logic := '0';
    
    signal enableSignal: std_logic_vector(7 downto 0);
    
    signal muxSelectorDisplay: std_logic := '0';
    
    signal outputProduct: std_logic_vector(15 downto 0);
    signal productReady, operationFinished: std_logic := '0';
    
begin
    boothMultiplier: MoltiplicatoreBooth
    port map(
        X => operand1,
        Y => operand2,
        
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

    encoderOperand1: EncoderSignedBCD
    port map(
        input => operand1,
        output => displayOperand1
    );
    
    encoderOperand2: EncoderSignedBCD
    port map(
        input => operand2,
        output => displayOperand2
    );

    encoderResult: EncoderSignedBCD16
    port map(
        input => outputProduct,
        
        output => displayResult
    );

    displayMux: Mux2to1
    generic map(
        width => 32
    )
    port map(
        a => operandsDisplay,
        b => resultDisplay,
        sel => muxSelectorDisplay,
        c => valueToPrint
    );

    display: display_seven_segments
    port map(
        clk => clock,
        rst => reset,
        value => valueToPrint,
        enable => (others => '1'),
        dots => "00000000",
        anodes => anodes,
        cathodes => cathodes
    );
    
    controlUnit: BoardControlUnit
    port map(
        clock => clock,
        reset => reset,
        multiplySignal => multiplySignal,
        productReady => productReady,
        startMultiplication => start,
        displaySelector => muxSelectorDisplay,
        productOperationFinish => operationFinished
    );
    
    operand1 <= switch(15 downto 8);
    operand2 <= switch(7 downto 0);
    
    operandsDisplay <= displayOperand1 & displayOperand2;
    resultDisplay <= "00000000" & displayResult;
    --resultDisplay <= "0000000000000000" & outputProduct;
    
    reset <= btnReset;
    ledProductFinished <= operationFinished;

end structural;
