library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity contatore_modulo_64 is
    generic (
        modulo : positive range 1 to 64 := 60
    );
    port (    
        clk: in std_logic;

        outputValue: out std_logic_vector (0 to 63);
        overflow: out std_logic   
   );
end contatore_modulo_64;

architecture Behavioral of contatore_modulo_64 is

    

begin

    counterProcess : process(clk)
        variable internalCounter : integer := 0;
    begin
        if(rising_edge(clk)) then
            internalCounter := internalCounter + 1;
            overflow <= '0';

            if(internalCounter = modulo) then
                internalCounter := 0;
                overflow <= '1';
            end if;

            outputValue <= std_logic_vector(to_unsigned(internalCounter, outputValue'length));
        end if;
    end process;

end Behavioral;
