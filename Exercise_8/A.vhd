
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A is
generic(
    DIM: natural :=2; --dimensione indirizzo
    M: natural := 8 --lunghezza stringhe
);
port( 
    START: in STD_LOGIC;
    CLK_A: in STD_LOGIC;
    RESET: in STD_LOGIC;
    ACK: in STD_LOGIC;
    REQ: out STD_LOGIC;
    X: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end A;

architecture Structural of A is

component counter is
generic( DIM: natural :=2 );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0));
end component;

component ROM is
generic(
    int: natural :=2;
    N: natural :=4;
    M: natural :=8
);
port( 
    clk_a: in STD_LOGIC;
    rst: in STD_LOGIC;
    read: in STD_LOGIC;
    address_A: in STD_LOGIC_VECTOR((int-1) downto 0);
    X: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;

component control_unit_A is
generic (
    DIM: integer :=2 );
port ( 
    start: in STD_LOGIC;
    address_A: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    clk_A: in STD_LOGIC;
    reset: in STD_LOGIC;
    ack: in STD_LOGIC;
    read: out STD_LOGIC;
    enable_counter: out STD_LOGIC;
    req: out STD_LOGIC
);
end component;

-- segnali
signal count_en: STD_LOGIC;
signal re: STD_LOGIC;
signal addr_A: STD_LOGIC_VECTOR((DIM-1) downto 0);

begin

CU_A: control_unit_A
generic map(DIM=> 2)
port map(
    start => START,
    address_A => addr_A,
    clk_a => CLK_A,
    reset => RESET,
    ack => ACK,
    read => re,
    enable_counter => count_en,
    req => REQ
);

COUNTER_A: counter
generic map( DIM=>2 )
port map(
    clock => CLK_A,
    reset => RESET,
    enable => count_en,
    counter => addr_A
);


ROM_A: ROM
generic map(
    int=>2,
    N=>4,
    M=>8
)
port map(
    clk_a => CLK_A,
    rst => RESET,
    read => re,
    address_A => addr_A,
    X => X
);

end Structural;