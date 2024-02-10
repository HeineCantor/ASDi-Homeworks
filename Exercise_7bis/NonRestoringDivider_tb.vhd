library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NonRestoringDivider_tb is
end NonRestoringDivider_tb;

architecture structural of NonRestoringDivider_tb is

    component NonRestoringDivider is
        port(
            clock, reset, start:    in std_logic;
            D, V:                   in std_logic_vector(3 downto 0);
            Q, R:                   out std_logic_vector(3 downto 0);
            divisionFinished:       out std_logic
        );
    end component;

    signal clock: std_logic;
    constant CLK_period : time := 10 ns;

    signal D, V, Q, R: std_logic_vector(3 downto 0);
    signal outputReady, reset, start: std_logic;

begin

    simClock: process
    begin
        clock <= '0';
        wait for CLK_period;
        clock <= '1';
        wait for CLK_period;
    end process;
    
    uut: NonRestoringDivider
    port map(
        clock => clock,
        reset => reset,
        start => start,
        D => D,
        V => V,
        Q => Q,
        R => R,
        divisionFinished => outputReady
    );
    
    simProcess: process
    begin
        wait for 100ns;
        
        D <= "1001";
        V <= "0011";
        
        wait for 10ns;
        
        start <= '1';
        wait for 30ns;
        start <= '0';
        
        wait for 30 ns;
        
        wait;
    end process;

end structural;
