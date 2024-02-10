library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_system is
    port(
        inputAddress    : in  std_logic_vector(3 downto 0);
        dataOutput      : out std_logic_vector(3 downto 0)
    );
end entity full_system;

architecture structural of full_system is
    component rom_16_8bit 
        port(
            address : in std_logic_vector(3 downto 0);
            dataOut : out std_logic_vector(7 downto 0)
        );
    end component rom_16_8bit;

    component elaborator
        port(
            dataInput   : in  std_logic_vector(7 downto 0);
            dataOutput  : out std_logic_vector(3 downto 0)
        );
    end component elaborator;

    signal ROMToElaboratorLink : std_logic_vector(7 downto 0) := (others => 'U');

    begin
        romEntity : rom_16_8bit
        port map
        (
            address => inputAddress,
            dataOut => ROMToElaboratorLink
        );

        elaboratorEntity : elaborator
        port map
        (
            dataInput => ROMToElaboratorLink,
            dataOutput => dataOutput
        );

end architecture structural;