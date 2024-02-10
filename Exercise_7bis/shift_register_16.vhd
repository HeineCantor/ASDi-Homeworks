library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister8 is
    port(
        parallelIn:                in std_logic_vector(7 downto 0);
        clock, shift, reset, load:  in std_logic;
        serialIn:                   in std_logic;
        parallelOut:               out std_logic_vector(7 downto 0)
    );
end ShiftRegister8;

architecture Behavioral of ShiftRegister8 is

    signal internalValue:   std_logic_vector(7 downto 0);

begin

    shiftRegisterProcess: process(clock)
    begin
        if(clock'event and clock='1') then
            if(reset = '1') then
                internalValue <= (others => '0');
            else
                if (load = '1') then
                    internalValue <= parallelIn;
                elsif (shift = '1') then
                    internalValue(7 downto 1) <= internalValue(6 downto 0);
                    internalValue(0) <= serialIn;
                end if;
            end if;
        end if;
    end process;
    
    parallelOut <= internalValue;

end Behavioral;
