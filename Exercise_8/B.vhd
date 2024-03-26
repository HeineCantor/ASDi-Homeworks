
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity B is
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
end B;

architecture Structural of B is

component counter is
generic( DIM: natural :=2 );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --enable viene dal divisore di frequenza
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0)); -- COUNTER corrisponde ad ADDRESS
end component;

component RAM is
generic(
    DIM: natural :=2; --dimensione indirizzo
    N: natural :=4; --numero stringhe
    M: natural :=8  --lunghezza stringa
);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    S: in STD_LOGIC_VECTOR((M-1) downto 0);
    address_B: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    write: in STD_LOGIC;
    read: in STD_LOGIC;
    Y: out STD_LOGIC_VECTOR((M-1) downto 0);
    S1: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;

component adder is
port(
    X: in STD_LOGIC_VECTOR(7 downto 0);
    Y: in STD_LOGIC_VECTOR(7 downto 0);
    S: out STD_LOGIC_VECTOR(7 downto 0)
 );
end component;

component register_B is
generic( M: natural := 8);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    X_in: in STD_LOGIC_VECTOR((M-1) downto 0);
    read: in STD_LOGIC;
    X_out: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;

component control_unit_B is
generic( DIM: natural :=2);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    req: in STD_LOGIC;
    address_B: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    read_reg: out STD_LOGIC;
    write: out STD_LOGIC;
    read: out STD_LOGIC;
    enable_counter: out STD_LOGIC;
    ack: out STD_LOGIC
    --stop: out STD_LOGIC
);
end component;


--segnali
signal en_counter: STD_LOGIC;
signal addr: STD_LOGIC_VECTOR((DIM-1) downto 0);
signal string_S: STD_LOGIC_VECTOR((M-1) downto 0);
signal we: STD_LOGIC;
signal re: STD_LOGIC;
signal string_Y: STD_LOGIC_VECTOR((M-1) downto 0);
signal string_X_out: STD_LOGIC_VECTOR((M-1) downto 0);
signal re_reg: STD_LOGIC;


begin
COUNTER_B: counter
generic map( DIM=>2 )
port map(
    clock => CLK_B,
    reset => RESET,
    enable => en_counter,
    counter => addr
);

MEM_B: RAM
generic map(
    DIM=>2, --dimensione indirizzo
    N=>4, --numero stringhe
    M=>8  --lunghezza stringa
)
port map(
    clk_b => CLK_B,
    reset =>  RESET,
    S => string_S,
    address_B => addr,
    write => we,
    read => re,
    Y => string_Y,
    S1 => SUM
);

ADDER_B: adder
port map(
    X => string_X_out,
    Y => string_Y,
    S => string_S
 );
 
REG_B: register_B
generic map( M=> 8)
port map(
    clk_b => CLK_B,
    reset => RESET,
    X_in => X,
    read => re_reg,
    X_out => string_X_out
);

CU_B: control_unit_B
generic map( DIM=>2)
port map(
    clk_b => CLK_B,
    reset => RESET,
    req => REQ,
    address_B => addr,
    read_reg => re_reg,
    write => we,
    read => re,
    enable_counter => en_counter,
    ack => ACK
    --stop => STOP
);

Yi <= string_Y;

end Structural;
