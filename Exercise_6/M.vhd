library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity M is
    port(
        input: in std_logic_vector (7 downto 0);
        output: out std_logic_vector(3 downto 0)
    );
end M;

architecture Behavioral of M is
    begin
        process(input)
        begin
            FOR i in 0 to 3 LOOP
                output(i) <= not(input(i));
            END LOOP;
        END process;   
END Behavioral;
