
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ROM is
generic(
    int: integer :=2;
    N: integer:=4;
    M: integer :=8
);
port( 
    clk_a: in STD_LOGIC;
    rst: in STD_LOGIC;
    read: in STD_LOGIC;
    address_A: in STD_LOGIC_VECTOR((int-1) downto 0);
    X: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end ROM;

architecture Behavioral of ROM is
type ROM_ARRAY is array (0 to (N-1)) of STD_LOGIC_VECTOR((M-1) downto 0);
signal ROM: ROM_ARRAY :=(
    b"00000101",
    b"00001000",
    b"00000001",
    b"00001000"
);

begin
    process(clk_a)
    begin
        if (clk_A'event AND clk_A='1') then
            if(read='1') then
                X <= ROM(to_integer(unsigned(address_A)));
            end if;
        end if;
    end process;

end Behavioral;
