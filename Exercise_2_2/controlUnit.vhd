
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity controlUnit is
Port (
        switch : in std_logic_vector (0 to 3);
        outputLed: out std_logic_vector(0 to 3)
 );
end controlUnit;

architecture Behavioral of controlUnit is

component S is
port (   inputAddress : in std_logic_vector(3 downto 0);
         systemOutput : out std_logic_vector(3 downto 0) );
end component;

begin

    uut: S
    port map(
        inputAddress => switch,
        systemOutput => outputLed
    );


end Behavioral;
