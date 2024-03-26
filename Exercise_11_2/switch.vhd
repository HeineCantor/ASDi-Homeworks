
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is
    generic(
        addressDim: natural := 3;
        dataDim: natural :=2;
        depth: natural := 0
    );
    port(
        X1: in STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0) := (others => '0');
        X2: in STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0) := (others => '0');
        Y1: out STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0) := (others => '0');
        Y2: out STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0) := (others => '0')
    );
end switch;

architecture structural of switch is
    component mux_2_1
    port(   x1: in STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0);
            x2: in STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0);
            s: in  STD_LOGIC;
            y: out STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0)
    );
    end component mux_2_1;
    
    component switchControlUnit is
        port(
            en1, en2: in std_logic;
            addrBit1, addrBit2: in std_logic;
            selector1, selector2: out std_logic
        );
    end component;
    
    signal muxSelector: std_logic_vector(1 downto 0);
    
begin

    controlUnit: switchControlUnit
    port map(
        en1 => x1(1+addressDim+dataDim-1),
        en2 => x2(1+addressDim+dataDim-1),
        addrBit1 => x1(addressDim+dataDim-1-depth),
        addrBit2 => x2(addressDim+dataDim-1-depth),
        selector1 => muxSelector(0),
        selector2 => muxSelector(1)
    );

    mux1: mux_2_1
    port map
    (
        x1 => X1,
        x2 => X2,
        s => muxSelector(0),
        y => y1
    );
    
    mux2: mux_2_1
    port map
    (
        x1 => X1,
        x2 => X2,
        s => muxSelector(1),
        y => y2
    );

end structural;
