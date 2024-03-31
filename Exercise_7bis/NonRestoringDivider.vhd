library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NonRestoringDivider is
    port(
        clock, reset, start:    in std_logic;
        D, V:                   in std_logic_vector(3 downto 0);
        Q, R:                   out std_logic_vector(3 downto 0);
        divisionFinished:       out std_logic
    );
end NonRestoringDivider;

architecture structural of NonRestoringDivider is

    component UnitaOperativa is
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
    end component;
    
    component UnitaControllo is
        port(
            clock, reset, start:    in std_logic;
            count:  in std_logic_vector(1 downto 0);
            
            sign:   in std_logic;
            
            loadM, loadAQ, loadS, countSignal, subSignal, shiftAQ: out std_logic;
            selAQ:  out std_logic_vector(1 downto 0);
            
            divisionFinished: out std_logic
        );
    end component;
    
    signal signLink, loadMlink, loadAQlink, countSignallink, subSignallink, shiftAQlink: std_logic;
    signal selAQlink, countLink: std_logic_vector(1 downto 0);
    
begin

    operativeUnit: UnitaOperativa
    port map(
        D => D,
        V => V,
        clock => clock,
        reset => reset,
        
        loadAQ => loadAQlink,
        loadM => loadMlink,
        shiftAQ => shiftAQlink,
        selAQ => selAQlink,
        subSignal => subSignallink,
        countSignal => countSignallink,
        sOutput => signLink,
        count => countLink,
        Q => Q,
        R => R
    );

    controlUnit: UnitaControllo
    port map(
        clock => clock,
        reset => reset,
        start => start,
        
        count => countlink,
        
        sign => signLink,
        
        loadM => loadMlink,
        loadAQ => loadAQlink,
        countSignal => countSignallink,
        subSignal => subSignallink,
        shiftAQ => shiftAQlink,
        selAQ => selAQlink,
        divisionFinished => divisionFinished
    );

end structural;
