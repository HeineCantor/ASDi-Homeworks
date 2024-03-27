library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_2_1 is
generic( DIM: natural :=2);
    
port(       x1: in STD_LOGIC_VECTOR((DIM-1) downto 0);
            x2: in STD_LOGIC_VECTOR((DIM-1) downto 0);
            s : in  STD_LOGIC;
            y  : out STD_LOGIC_VECTOR((DIM-1) downto 0)
    );
    
end mux_2_1;


architecture dataflow of mux_2_1 is
    begin
        y <= x1 when s='0' else
             x2 when s='1' else
             "UU";
end dataflow;