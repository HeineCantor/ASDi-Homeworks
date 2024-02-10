library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFF is
    generic(
        dataWidth : integer range 1 to 64 := 8
    );
    port(
        dataIn:             in std_logic_vector(dataWidth-1 downto 0);
        
        clock, reset, load: in std_logic;
        
        dataOut:            out std_logic_vector(dataWidth-1 downto 0)
    );
end RegisterFF;

architecture Behavioral of RegisterFF is
    signal internalValue: std_logic_vector(dataWidth-1 downto 0);
begin

    registerProcess: process(clock)
    begin
        if(clock'event and clock = '1') then -- rising edge
            if (reset = '1') then
                internalValue <= (others => '0');
            elsif (load = '1') then
                internalValue <= dataIn;
            end if;
        end if;
    end process;
    
    dataOut <= internalValue;

end Behavioral;
