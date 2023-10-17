library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_16_8bit is
    port(
        address : in std_logic_vector(3 downto 0);
        dataOut : out std_logic_vector(7 downto 0)
    );
end entity rom_16_8bit;

architecture RTL of rom_16_8bit is

    type MEMORY_16_8 is array(0 to 15) of std_logic_vector(7 downto 0);
    constant ROM_16_8: MEMORY_16_8 :=
    (
        x"00",
        x"01",
        x"02",
        x"03",
        x"04",
        x"05",
        x"06",
        x"07",
        x"f8",
        x"f9",
        x"fa",
        x"fb",
        x"fc",
        x"fd",
        x"fe",
        x"ff"
    );

    begin
        main: process(address)
            begin
                dataOut <= ROM_16_8(to_integer(unsigned(address)));
        end process main;

end architecture RTL;