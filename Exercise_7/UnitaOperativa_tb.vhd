library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnitaOperativa_tb is
end UnitaOperativa_tb;

architecture Behavioral of UnitaOperativa_tb is

    component UnitaOperativa is
        port(
            X, Y:           in std_logic_vector(7 downto 0);
            clock, reset:   in std_logic;
            
            subSignal, countIn,
            loadAQ, loadM, shiftAQ, selAQ:  in std_logic;
            
            outputProduct:  out std_logic_vector(15 downto 0);
            qPadding:       out std_logic;
            count:          out std_logic_vector(2 downto 0)   
        );
    end component;

    signal testX, testY: std_logic_vector(7 downto 0);
    signal clock, reset: std_logic;

    signal subSignal, countIn, counterReset, loadAQ, loadM, shiftAQ, selAQ: std_logic;
    
    signal qPadding: std_logic;
    
    signal outputProduct: std_logic_vector(15 downto 0);
    signal count: std_logic_vector(2 downto 0);

    constant CLK_period : time := 10 ns;
begin

    uut: UnitaOperativa
    port map(
        X => testX,
        Y => testY,
        clock => clock,
        reset => reset,
        subSignal => subSignal,
        countIn => countIn,
        loadAQ => loadAQ,
        loadM => loadM,
        shiftAQ => shiftAQ,
        selAQ => selAQ,
        qPadding => qPadding,
        outputProduct => outputProduct,
        count => count
    );
    
   CLK_process :process
   begin
		clock <= '0';
		wait for CLK_period/2;
		clock <= '1';
		wait for CLK_period/2;
   end process;
   
    simulation: process
    begin
        wait for 100ns;
        
        testY <= "00000011";
        testX <= "00001100";
        
        countIn <= '0';
        subSignal <= '0';
        selAQ <= '0';
        loadAQ <= '0';
        loadM <= '0';
        shiftAQ <= '0';
        
        wait for 10ns;
        
        loadM <= '1';
        loadAQ <= '1';
        
        wait for 15ns;
        
        loadM <= '0';
        loadAQ <= '0';

        shiftAQ <= '1';
        
        wait for 11ns;
        
        shiftAQ <= '0';

        subSignal <= '1';
    
        selAQ <= '1';
        loadAQ <= '1';
        
        wait for 11ns;
        
        subSignal <= '0';
        
        selAQ <= '0';
        loadAQ <= '0';
        
        wait;
    
    end process;

end Behavioral;
