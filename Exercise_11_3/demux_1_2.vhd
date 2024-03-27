
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_1_2 is
generic( DIM: natural :=2 );
    port(       x : in STD_LOGIC_VECTOR((DIM-1) downto 0);
                s : in  STD_LOGIC;
                y1  : out STD_LOGIC_VECTOR((DIM-1) downto 0) := (others => '0');
                y2: out STD_LOGIC_VECTOR((DIM-1) downto 0) := (others => '0')
        );
end demux_1_2;

architecture dataflow of demux_1_2 is

    begin
            y1 <= x when s='0' else "00";
            y2 <= x when s='1' else "00";
  
end dataflow;
