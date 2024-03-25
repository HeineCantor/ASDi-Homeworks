library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1 is
    generic (
        width : integer range 0 to 32 := 8
    );
	port( 
	   a, b: in std_logic_vector(width-1 downto 0); 
       sel: in std_logic;
	   o: out std_logic_vector(width-1 downto 0)
	);
end Mux2to1;

architecture Behavioral of Mux2to1 is
    begin
    
        o <=    a when sel = '0' else
                b when sel = '1' else
                (others => 'U');
end Behavioral;
