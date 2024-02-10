library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnitaOperativa is
    port(
        X, Y:           in std_logic_vector(7 downto 0);
        clock, reset:   in std_logic;
        
        subSignal, countIn,
        loadAQ, loadM, shiftAQ, selAQ:  in std_logic;
        
        outputProduct:  out std_logic_vector(15 downto 0);
        qPadding:       out std_logic;
        count:          out std_logic_vector(2 downto 0)   
    );
end UnitaOperativa;

architecture structural of UnitaOperativa is

    component Mux2to1 is
        generic (
            width : integer range 0 to 16 := 8
        );
        port( 
           a, b: in std_logic_vector(width-1 downto 0); 
           sel: in std_logic;
           c: out std_logic_vector(width-1 downto 0)
        );
    end component;

    component ShiftRegisterPadding is
        generic(
            width:  integer := 16;
            padding: integer := 1;
            signPreserve: boolean := true
        );
        port(
            parallelIn:                 in std_logic_vector(width-1 downto 0);
            clock, shift, reset, load:  in std_logic;
            
            serialIn:                   in std_logic;
            
            parallelOut:                out std_logic_vector(width-1 downto 0);
            paddingOut:                 out std_logic_vector(padding-1 downto 0)
        );
    end component;
        
    component register_8 is
        port(
            dataInput:                  in std_logic_vector(7 downto 0);
            clock, reset, load:         in std_logic;
            dataOutput:                 out std_logic_vector(7 downto 0)  
        );
    end component;
    
    component counter_mod8 is
        port(
            clock, reset    :   in std_logic;
            count_in        :   in std_logic;
            count           :   out std_logic_vector(2 downto 0)       
        );
    end component;
    
    component AdderSubtractor is
        generic(
            length: integer := 8
        );
        port(
            X, Y:   in std_logic_vector(length-1 downto 0);
            cIn:    in std_logic;
            cOut:   out std_logic;
            Z:      out std_logic_vector(length-1 downto 0)
        );
    end component;

    signal AQ_Init, AQ_Sum, parallelLinkAQ: std_logic_vector(15 downto 0);
    signal dataInputM, dataOutputM:         std_logic_vector(7 downto 0);
    signal adderOperand1, adderOperand2:    std_logic_vector(7 downto 0);
    
    signal riporto : std_logic;
    
    signal sum: std_logic_vector(7 downto 0);
    
    signal AQoutput:    std_logic_vector(15 downto 0);

begin

    AQ_Init  <= "00000000" & X;
    dataInputM <= Y;
    
    registerAQ: ShiftRegisterPadding
    port map(
        parallelIn => parallelLinkAQ,
        clock => clock,
        shift => shiftAQ,
        reset => reset,
        load => loadAQ,
        serialIn => '0',
        parallelOut => AQoutput,
        paddingOut(0) => qPadding
    );
    
    outputProduct <= AQoutput;
    
    registerM: register_8
    port map(
        dataInput => dataInputM,
        clock => clock,
        reset => reset,
        load => loadM,
        dataOutput => dataOutputM
    );

    adderOperand1 <= AQoutput(15 downto 8);
    adderOperand2 <= dataOutputM;
    
    addsub: AdderSubtractor
    port map(
        X => adderOperand1,
        Y => adderOperand2,
        cIn => subSignal,
        cOut => riporto,
        Z => sum
    );
    
    AQ_Sum <= sum &  AQoutput(7 downto 0);
    
    Amultiplexer: Mux2to1
    generic map(width => 16)
    port map(
        a => AQ_Init,
        b => AQ_Sum,
        sel => selAQ,
        c => parallelLinkAQ
    );
    
    Counter: counter_mod8
    port map(
        clock => clock,
        reset => reset,
        count_in => countIn,
        count => count
    );

end structural;
