library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnitaOperativa is
    port(
        D, V            : in std_logic_vector(3 downto 0);
        
        clock, reset    : in std_logic;
        
        loadAQ, loadM   : in std_logic;
        shiftAQ         : in std_logic;
        selAQ           : in std_logic_vector(1 downto 0);
        subSignal       : in std_logic;
        countSignal     : in std_logic;
        
        sOutput         : out std_logic;
        
        count           : out std_logic_vector(1 downto 0);
        Q, R            : out std_logic_vector(3 downto 0)
    );
end UnitaOperativa;

architecture structural of UnitaOperativa is

    component ShiftRegister is
        generic(
            length : natural := 8
        );
        port(
            parallelIn:                in std_logic_vector((length-1) downto 0);
            clock, shift, reset, load:  in std_logic;
            serialIn:                   in std_logic;
            parallelOut:               out std_logic_vector((length-1) downto 0)
        );
    end component;
    
    component AdderSubtractor is
        generic(
            length: integer := 5
        );
        port(
            X, Y:   in std_logic_vector(length-1 downto 0);
            cIn:    in std_logic;
            cOut:   out std_logic;
            Z:      out std_logic_vector(length-1 downto 0)
        );
    end component;
    
    component DRisingEdge
        port(
            dataIn:      in std_logic;
            clock, load: in std_logic;
            
            dataOut:     out std_logic
        );
    end component;
    
    component RegisterFF is
        generic(
            dataWidth : integer range 1 to 64 := 4
        );
        port(
            dataIn:             in std_logic_vector(dataWidth-1 downto 0);
            
            clock, reset, load: in std_logic;
            
            dataOut:            out std_logic_vector(dataWidth-1 downto 0)
        );
    end component;
    
    component CounterMod4 is
        port(
            clock, reset    :   in std_logic;
            count_in        :   in std_logic;
            count           :   out std_logic_vector(1 downto 0)       
        );
    end component;
    
    component Mux3to1 is
        generic (
            width : integer range 0 to 16 := 8
        );
        port( 
           a, b, c: in std_logic_vector(width-1 downto 0); 
           sel: in std_logic_vector(1 downto 0);
           o: out std_logic_vector(width-1 downto 0)
        );
    end component;

    signal initAQ, parallelInAQ : std_logic_vector(8 downto 0);
    signal parallelOutAQ:         std_logic_vector(8 downto 0);
    
    signal adderOperand1, adderOperand2: std_logic_vector(3 downto 0);
    signal fullOperand1, fullOperand2:   std_logic_vector(4 downto 0);
    signal sumOutput:                    std_logic_vector(4 downto 0);
    
    signal riporto: std_logic; 
    
    signal sign: std_logic := '0';
    signal q0settingAQ, sumSettingAQ: std_logic_vector(8 downto 0);
begin

    initAQ <= "00000" & D;
    
    counter: CounterMod4
    port map(
        clock => clock,
        reset => reset,
        count_in => countSignal,
        count => count
    );
    
    registerM: RegisterFF
    port map(
        dataIn => V,
        clock => clock,
        reset => reset,
        load => loadM,
        dataOut => adderOperand2
    );
    
    shiftRegisterAQ: ShiftRegister
    generic map(
        length => 9
    )
    port map(
        parallelIn => parallelInAQ,
        clock => clock,
        reset => reset,
        load => loadAQ,
        shift => shiftAQ,
        serialIn => '-',
        parallelOut => parallelOutAQ
    );
    
    muxAQ: Mux3to1
    generic map(
        width => 9
    )
    port map(
        a => initAQ,
        b => sumSettingAQ,
        c => q0settingAQ,
        sel => selAQ,
        o => parallelInAQ
    );
    
    addSub: AdderSubtractor
    generic map(
        length => 5
    )
    port map(
        X => fullOperand1,
        Y => fullOperand2,
        Z => sumOutput,
        cIn => subSignal,
        cOut => riporto
    );
    
    sign <= parallelOutAQ(8);
    
    fullOperand1 <= parallelOutAQ(8 downto 4);
    fullOperand2 <= "0" & adderOperand2;
    
    q0settingAQ <= parallelOutAQ(8 downto 1) & (not sign);
    sumSettingAQ <= sumOutput & parallelOutAQ(3 downto 0);
    
    sOutput <= sign;
    
    R <= parallelOutAQ(7 downto 4);
    Q <= parallelOutAQ(3 downto 0);

end structural;
