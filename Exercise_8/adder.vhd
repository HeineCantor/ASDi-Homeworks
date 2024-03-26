
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity adder is
port(
    X: in STD_LOGIC_VECTOR(7 downto 0);
    Y: in STD_LOGIC_VECTOR(7 downto 0);
    S: out STD_LOGIC_VECTOR(7 downto 0)
 );
end adder;

architecture Behavioral of adder is

begin
    process(X,Y)
    begin
        S(7 downto 0) <= X(7 downto 0) + Y(7 downto 0);
    end process;
end Behavioral;
