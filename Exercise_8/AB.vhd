
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AB is
generic( M: natural := 8 );
port( 
    CLK_A: in STD_LOGIC;
    CLK_B: in STD_LOGIC;
    RESET: in STD_LOGIC;
    START: in STD_LOGIC;
    SUM: out STD_LOGIC_VECTOR((M-1) downto 0);
    Xi: out STD_LOGIC_VECTOR((M-1) downto 0);
    Yi: out STD_LOGIC_VECTOR((M-1) downto 0)
    
    --STOP: out STD_LOGIC
);
end AB;

architecture Behavioral of AB is

component A is
generic(
    DIM: natural :=2;
    M: natural := 8
);
port( 
    START: in STD_LOGIC;
    CLK_A: in STD_LOGIC;
    RESET: in STD_LOGIC;
    ACK: in STD_LOGIC;
    REQ: out STD_LOGIC;
    X: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;

component B is
generic(
    M: natural := 8;
    DIM: natural := 2
);
port( 
    CLK_B: in STD_LOGIC;
    RESET: in STD_LOGIC;
    REQ: in STD_LOGIC;
    X: in STD_LOGIC_VECTOR((M-1) downto 0);
    ACK: out STD_LOGIC;
    SUM: out STD_LOGIC_VECTOR((M-1) downto 0);
    --STOP: out STD_LOGIC;
    Yi: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;


signal internal_ack: STD_LOGIC;
signal internal_X: STD_LOGIC_VECTOR((M-1) downto 0);
signal internal_req: STD_LOGIC;


begin

COMP_A: A
generic map(
    DIM=>2,
    M=>8
)
port map( 
    START => START,
    CLK_A => CLK_A,
    RESET => RESET,
    ACK => internal_ack,
    REQ => internal_req,
    X => internal_X
);

COMP_B: B
generic map(
    M=>8,
    DIM=> 2
)
port map( 
    CLK_B => CLK_B,
    RESET => RESET,
    REQ => internal_req,
    X => internal_X,
    ACK => internal_ack,
    SUM => SUM,
    --STOP => STOP,
    Yi => Yi
);

Xi<= internal_X;

end Behavioral;