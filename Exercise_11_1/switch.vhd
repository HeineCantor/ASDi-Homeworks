
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is
generic(DIM: natural :=2);
    port(
        X1: in STD_LOGIC_VECTOR((DIM-1) downto 0);
        X2: in STD_LOGIC_VECTOR((DIM-1) downto 0);
        Y1: out STD_LOGIC_VECTOR((DIM-1) downto 0);
        Y2: out STD_LOGIC_VECTOR((DIM-1) downto 0);
        src: in STD_LOGIC;
        dst: in STD_LOGIC
    );
end switch;

architecture structural of switch is
    component mux_2_1
    port(   x1: in STD_LOGIC_VECTOR((DIM-1) downto 0);
            x2: in STD_LOGIC_VECTOR((DIM-1) downto 0);
            s: in  STD_LOGIC;
            y: out STD_LOGIC_VECTOR((DIM-1) downto 0)
    );
    end component mux_2_1;
    
    component demux_1_2 is
    port(    x: in STD_LOGIC_VECTOR((DIM-1) downto 0);
             s: in STD_LOGIC;
             y1: out STD_LOGIC_VECTOR((DIM-1) downto 0);
             y2: out STD_LOGIC_VECTOR((DIM-1) downto 0)
    );
    end component demux_1_2;
    
    signal muxToDemuxLink : STD_LOGIC_VECTOR(DIM-1 downto 0);
    
begin

    muxEntity : mux_2_1
    port map
    (
        x1 => X1,
        x2 => X2,
        s => src,
        y => muxToDemuxLink
    );
    
    demuxEntity : demux_1_2
    port map
    (
        x => muxToDemuxLink,
        s => dst,
        y1 => Y1,
        y2 => Y2
    );

end structural;
