library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DRisingEdge is
    port(
        dataIn:      in std_logic;
        clock, load: in std_logic;
        
        dataOut:     out std_logic
    );
end DRisingEdge;

architecture Behavioral of DRisingEdge is
    signal internalValue: std_logic := '0';
begin

    latchProcess: process(clock)
    begin
    
        if(clock'event and clock ='1') then
        
            if (load = '1') then
                internalValue <= dataIn;
            end if;
        
        end if;
    
    end process;
    
    dataOut <= internalValue;

end Behavioral;
