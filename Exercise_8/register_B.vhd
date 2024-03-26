
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_B is
generic( M: natural := 8);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    X_in: in STD_LOGIC_VECTOR((M-1) downto 0);
    read: in STD_LOGIC;
    X_out: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end register_B;

architecture Behavioral of register_B is

begin
    process(clk_b)
    begin
    
    if(clk_b'event AND clk_b='1') then
        if reset='1' then
            X_out<="00000000";
        elsif read='1' then
            X_out <= X_in;
        end if;
    end if;
    end process;
    
end Behavioral;
