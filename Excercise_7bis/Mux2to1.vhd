library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux3to1 is
    generic (
        width : integer range 0 to 16 := 8
    );
	port( 
	   a, b, c: in std_logic_vector(width-1 downto 0); 
       sel: in std_logic_vector(1 downto 0);
	   o: out std_logic_vector(width-1 downto 0)
	);
end Mux3to1;

architecture Behavioral of Mux3to1 is

begin

    o <=    a when sel = "01" else
            b when sel = "10" else
            c when sel = "11" else
            (others => 'U');

end Behavioral;
