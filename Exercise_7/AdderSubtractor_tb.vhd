library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AdderSubtractor_tb is
--  Port ( );
end AdderSubtractor_tb;

architecture structural of AdderSubtractor_tb is

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
    
    signal testX, testY: std_logic_vector(7 downto 0);
    signal testCin: std_logic;
    
    signal outputSum: std_logic_vector(7 downto 0);
    signal testCout: std_logic;

begin

    uut: AdderSubtractor
    generic map(
        length => 8
    )
    port map(
        X => testX,
        Y => testY,
        cIn => testCin,
        cOut => testCout,
        Z => outputSum
    );
    
    sim: process
    begin
    
        testCin <= '0';
    
        wait for 100 ns;
        
        testX <= "00001000";
        testY <= "00000010";
        
        wait for 10 ns;
        
        testCin <= '1';
        
        wait for 10 ns;
        
        testY <= "00001010";
        
        wait;
    
    end process;

end structural;
