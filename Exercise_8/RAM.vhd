
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
generic(
    DIM: integer :=2; --dimensione indirizzo
    N: integer :=4; --numero stringhe
    M: integer :=8  --lunghezza stringa
);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    S: in STD_LOGIC_VECTOR((M-1) downto 0);
    address_B: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    write: in STD_LOGIC;
    read: in STD_LOGIC;
    Y: out STD_LOGIC_VECTOR((M-1) downto 0);
    S1: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end RAM;

architecture Behavioral of RAM is

type RAM_ARRAY is array (0 to 2*N-1) of STD_LOGIC_VECTOR((M-1) downto 0);

signal RAM: RAM_ARRAY :=(
    b"00000011",
    b"00001001",
    b"10000000",
    b"00000111",
    b"00000000",
    b"00000000",
    b"00000000",
    b"00000000"
);

begin
    process(clk_b)
        begin
        
        if(clk_b'event AND clk_b='1') then
            if reset='1' then
                Y<="00000000";
            elsif write='1' then
                RAM(to_integer(unsigned(address_B))+N) <= S;
                S1 <= S;
            elsif read='1' then
                Y<=RAM(to_integer(unsigned(address_B)));
            end if;
        end if;
     end process;

end Behavioral;
