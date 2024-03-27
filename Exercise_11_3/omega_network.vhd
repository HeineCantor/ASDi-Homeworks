
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity omega_network is
generic( DIM: natural :=2);
port (
    IN1,IN2,IN3,IN4: in STD_LOGIC_VECTOR(2+(DIM-1) downto 0);
    AB1,AB2,AB3,AB4: in STD_LOGIC;
    OUT1,OUT2,OUT3,OUT4: out STD_LOGIC_VECTOR((DIM-1) downto 0)
 );
end omega_network;

architecture Structural of omega_network is

component switch is
    port(
        X1: in STD_LOGIC_VECTOR((DIM-1) downto 0);
        X2: in STD_LOGIC_VECTOR((DIM-1) downto 0);
        Y1: out STD_LOGIC_VECTOR((DIM-1) downto 0);
        Y2: out STD_LOGIC_VECTOR((DIM-1) downto 0);
        src: in STD_LOGIC;
        dst: in STD_LOGIC
    );
end component;

component control_unit is
    Port (
        en1: in STD_LOGIC;
        en2: in STD_LOGIC;
        en3: in STD_LOGIC;
        en4: in STD_LOGIC;
        in1,in2,in3,in4: in STD_LOGIC_VECTOR(2+(DIM-1) downto 0);
        srcAddr: out STD_LOGIC_VECTOR(1 downto 0);
        dstAddr: out STD_LOGIC_VECTOR(1 downto 0)
    );
end component;


signal u1, u2, u3, u4: STD_LOGIC_VECTOR((DIM-1) downto 0);

signal internal_src: STD_LOGIC_VECTOR(1 downto 0);
signal dstAddress: STD_LOGIC_VECTOR(1 downto 0);

begin


CU: control_unit
port map(
    en1 => AB1,
    en2 => AB2,
    en3 => AB3,
    en4 => AB4,
    in1 => IN1,
    in2 => IN2,
    in3 => IN3,
    in4 => IN4,
    srcAddr => internal_src,
    dstAddr=> dstAddress
);

sw1: switch
port map(
    X1 => IN1(1 downto 0),
    X2 => IN2(1 downto 0),
    Y1 => u1,
    Y2 => u2,
    src => internal_src(0),
    dst => dstAddress(1)
);

sw2: switch
port map(
    X1 => u1,
    X2 => u3,
    Y1 => OUT1,
    Y2 => OUT2,
    src => internal_src(1),
    dst => dstAddress(0)
);

sw3: switch
port map(
    X1 => IN3(1 downto 0),
    X2 => IN4(1 downto 0),
    Y1 => u3,
    Y2 => u4,
    src => internal_src(0),
    dst => dstAddress(1)
);

sw4: switch
port map(
    X1 => u2,
    X2 => u4,
    Y1 => OUT3,
    Y2 => OUT4,
    src => internal_src(1),
    dst => dstAddress(0)
);

end Structural;
