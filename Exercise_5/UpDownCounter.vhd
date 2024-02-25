library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UpDownCounter is
    generic( 
        dim: integer range 1 to 8 := 6
    );
    Port ( 
       clock : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       enableUp, enableDown : in STD_LOGIC;
       counter : out  STD_LOGIC_VECTOR (dim-1 downto 0)
   ); 
end UpDownCounter;

architecture Behavioral of UpDownCounter is
    signal internalValue: std_logic_vector(dim-1 downto 0) := (others => '0');
begin
    countProcess: process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                internalValue <= (others => '0');
            elsif (enableUp = '1') then
                internalValue <= std_logic_vector(unsigned(internalValue)+1);
            elsif (enableDown = '1') then
                internalValue <= std_logic_vector(unsigned(internalValue)-1);
            end if;
        end if;
    end process;
    
    counter <= internalValue;
end Behavioral;
