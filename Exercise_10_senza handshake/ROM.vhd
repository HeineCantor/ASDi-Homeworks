
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ROM is
generic(
    DIM: natural :=3;
    N: natural :=8;
    M: natural :=8
);
port( 
    clk_a: in STD_LOGIC;
    rst: in STD_LOGIC;
    read: in STD_LOGIC;
    address_A: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    data_out: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end ROM;

architecture Behavioral of ROM is
type ROM_ARRAY is array (0 to (N-1)) of STD_LOGIC_VECTOR((M-1) downto 0);
signal ROM: ROM_ARRAY :=(
    b"00000000",
    b"00000001",
    b"00000010",
    b"00000011",
    b"00000100",
    b"00000101",
    b"00000110",
    b"00000111"
);

begin
    process(clk_a)
    begin
        if (clk_A'event AND clk_A='1') then
            if(read='1') then
                data_out <= ROM(to_integer(unsigned(address_A)));
            end if;
        end if;
    end process;

end Behavioral;
