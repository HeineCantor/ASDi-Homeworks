library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contatore_modulo_tb is
--  Port ( );
end contatore_modulo_tb;

architecture Behavioral of contatore_modulo_tb is


component contatore_modulo_64 is
    generic (
        modulo : positive range 1 to 64 := 60
    );
    port (    
        clk: in std_logic;

        outputValue: out std_logic_vector (0 to 63);
        overflow: out std_logic   
   );
end component;

    constant CLK_period : time := 10 ns;
    signal CLK : std_logic := '0';

    signal manualInput : std_logic := 'U';

    signal outputCounter : std_logic_vector(0 to 63);
    signal outputOverflow : std_logic;

begin
   uut: contatore_modulo_64 
   port map(
        clk=>manualInput,
        outputValue=>outputCounter,
        overflow=>outputOverflow
    );

   -- Stimulus process
   stim_proc: process
   begin
    wait for 100 ns;	
    
    for i in 0 to 100 loop

        manualInput <= '1';

        wait for 10 ns;

        manualInput <= '0';

        wait for 10 ns;

    end loop;

    wait;
   end process;
 
end Behavioral;
