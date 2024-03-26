library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity omega_network is
    generic( 
        addressDim: natural := 3;
        dataDim: natural :=2
    );
    port (
        IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7: in STD_LOGIC_VECTOR(1+addressDim+dataDim-1 downto 0);
        OUT0,OUT1,OUT2,OUT3,OUT4,OUT5,OUT6,OUT7: out STD_LOGIC_VECTOR(dataDim-1 downto 0)
    );
end omega_network;

architecture Structural of omega_network is

    component switch is
        generic(
            addressDim: natural := 3;
            dataDim: natural :=2;
            depth: natural := 0
        );
        port(
            X1: in STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0)  := (others => '0');
            X2: in STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0)  := (others => '0');
            Y1: out STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0)  := (others => '0');
            Y2: out STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0)  := (others => '0')
        );
    end component;

type switchOutputLink is array(0 to 7) of STD_LOGIC_VECTOR((1+addressDim+dataDim-1) downto 0);
signal layer1: switchOutputLink;
signal layer2: switchOutputLink;
signal outputLayer: switchOutputLink;

begin

    switch00: switch
    port map(
        x1 => in0,
        x2 => in4,
        y1 => layer1(0),
        y2 => layer1(1)
    );
    
    switch01: switch
    port map(
        x1 => in1,
        x2 => in5,
        y1 => layer1(2),
        y2 => layer1(3)
    );
    
    switch02: switch
    port map(
        x1 => in2,
        x2 => in6,
        y1 => layer1(4),
        y2 => layer1(5)
    );
    
    switch03: switch
    port map(
        x1 => in3,
        x2 => in7,
        y1 => layer1(6),
        y2 => layer1(7)
    );
    
    switch10: switch
    generic map(
        depth => 1
    )
    port map(
        x1 => layer1(0),
        x2 => layer1(4),
        y1 => layer2(0),
        y2 => layer2(1)
    );
    
    switch11: switch
    generic map(
        depth => 1
    )
    port map(
        x1 => layer1(1),
        x2 => layer1(5),
        y1 => layer2(2),
        y2 => layer2(3)
    );
    
    switch12: switch
    generic map(
        depth => 1
    )
    port map(
        x1 => layer1(2),
        x2 => layer1(6),
        y1 => layer2(4),
        y2 => layer2(5)
    );
    
    switch13: switch
    generic map(
        depth => 1
    )
    port map(
        x1 => layer1(3),
        x2 => layer1(7),
        y1 => layer2(6),
        y2 => layer2(7)
    );
    
    switch20: switch
    generic map(
        depth => 2
    )
    port map(
        x1 => layer2(0),
        x2 => layer2(4),
        y1 => outputLayer(0),
        y2 => outputLayer(1)
    );
    
    switch21: switch
    generic map(
        depth => 2
    )
    port map(
        x1 => layer2(1),
        x2 => layer2(5),
        y1 => outputLayer(2),
        y2 => outputLayer(3)
    );
    
    switch22: switch
    generic map(
        depth => 2
    )
    port map(
        x1 => layer2(2),
        x2 => layer2(6),
        y1 => outputLayer(4),
        y2 => outputLayer(5)
    );
    
    switch23: switch
    generic map(
        depth => 2
    )
    port map(
        x1 => layer2(3),
        x2 => layer2(7),
        y1 => outputLayer(6),
        y2 => outputLayer(7)
    );
    
    out0 <= outputLayer(0)(dataDim-1 downto 0);
    out1 <= outputLayer(1)(dataDim-1 downto 0);
    out2 <= outputLayer(2)(dataDim-1 downto 0);
    out3 <= outputLayer(3)(dataDim-1 downto 0);
    out4 <= outputLayer(4)(dataDim-1 downto 0);
    out5 <= outputLayer(5)(dataDim-1 downto 0);
    out6 <= outputLayer(6)(dataDim-1 downto 0);
    out7 <= outputLayer(7)(dataDim-1 downto 0);

end Structural;
