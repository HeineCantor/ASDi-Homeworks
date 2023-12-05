library ieee;
use ieee.std_logic_1164.all;

entity S is
  port ( inputAddress : in std_logic_vector(3 downto 0);
         systemOutput : out std_logic_vector(3 downto 0) );
end entity S;

architecture behavioral of S is
    signal ROMToMachineLink : STD_LOGIC_VECTOR (7 downto 0);
    
    component ROM is
    port ( address : in std_logic_vector(3 downto 0);
         dataOut : out std_logic_vector(7 downto 0) );
    end component ROM;
    
    component M is
    port(
        input : in STD_LOGIC_VECTOR(7 downto 0);
        output: out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component M;
    

begin
    rom0: ROM
        port map(
            address => inputAddress,
            dataOut => ROMToMachineLink
        );

    M0: M
        port map(
            input => ROMToMachineLink,
            output => systemOutput
        );

end architecture behavioral;
