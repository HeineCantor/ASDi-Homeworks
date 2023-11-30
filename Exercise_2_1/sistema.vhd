library ieee;
use ieee.std_logic_1164.all;

entity S is
  port ( a : in std_logic_vector(3 downto 0);
         y : out std_logic_vector(3 downto 0) );
end entity S;

architecture behavioral of S is
    signal u : STD_LOGIC_VECTOR (7 downto 0);
    
    component ROM is
    port ( address : in std_logic_vector(3 downto 0);
         dout : out std_logic_vector(7 downto 0) );
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
            address => a,
            dout => u
        );

    M0: M
        port map(
            input => u,
            output => y
        );

end architecture behavioral;
