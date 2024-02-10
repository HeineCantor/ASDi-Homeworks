library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnitaOperativa_tb is
end UnitaOperativa_tb;

architecture structural of UnitaOperativa_tb is

    component UnitaOperativa is
        port(
            D, V            : in std_logic_vector(3 downto 0);
            
            clock, reset    : in std_logic;
            
            loadAQ, loadM, loadS   : in std_logic;
            shiftAQ         : in std_logic;
            selAQ           : in std_logic_vector(1 downto 0);
            subSignal       : in std_logic;
            countSignal     : in std_logic;
            
            sOutput         : out std_logic;
            
            count           : out std_logic_vector(1 downto 0);
            Q, R            : out std_logic_vector(3 downto 0)
        );
    end component;

    signal D, V, Q, R: std_logic_vector(3 downto 0);
    signal reset, shiftAQ, loadAQ, loadM, loadS, subSignal, countSignal, sOutput: std_logic;
    signal selAQ, count: std_logic_vector(1 downto 0);

    signal clock: std_logic;
    signal CLOCK_PERIOD: time := 10 ns;

begin

    clockProcess: process
    begin
        clock <= '1';
        wait for CLOCK_PERIOD;
        clock <= '0';
        wait for CLOCK_PERIOD;
    end process;

    uut: UnitaOperativa
    port map(
        D, V, clock, reset, loadAQ, loadM, loadS, shiftAQ, selAQ, subSignal, countSignal, sOutput, count, Q, R
    );
    
    simProcess: process
    begin
    
        wait for 100 ns;
        
        D <= "1010";
        V <= "0011";
        reset <= '1';
        selAQ <= "01";
        
        wait for 20 ns;
        
        reset <= '0';
        
        loadAQ <= '1';
        loadM <= '1';
        
        wait for 20ns;
        
        loadS <= '1';
        loadAQ <= '0';
        loadM <= '0';
        
        wait for 25ns;
        
        loadS <= '0';
        shiftAQ <= '1';
        
        wait for 20ns;
        
        shiftAQ <= '0';
        subSignal <= '1';
        selAQ <= "10";
        
        wait for 20ns;
        
        loadAQ <= '1';
        
        wait;
    end process;

end structural;
