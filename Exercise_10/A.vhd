
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A is
generic(
    DIM: integer :=3; --dimensione indirizzo
    M: integer := 8 --lunghezza stringhe
);
port( 
    START: in STD_LOGIC;
    RESET: in STD_LOGIC;
    CLK_A: in STD_LOGIC;
    ACK: in STD_LOGIC;
    REQ: out STD_LOGIC;
    DONE: in STD_LOGIC;
    DATA_OUT: out STD_LOGIC_VECTOR((M-1) downto 0);
    WR: out STD_LOGIC;
    
    TBE: in STD_LOGIC
);
end A;

architecture Structural of A is

component counter is
generic( DIM: integer :=3 );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0));
end component;

component ROM is
generic(
    DIM: integer :=3;
    N: integer :=8;
    M: integer :=8
);
port( 
    clk_a: in STD_LOGIC;
    rst: in STD_LOGIC;
    read: in STD_LOGIC;
    address_A: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    data_out: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;

component control_unit_A is
generic (
    DIM: integer :=3 );
port ( 
    start: in STD_LOGIC;
    address_A: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    clk_A: in STD_LOGIC;
    reset: in STD_LOGIC;
    ack: in STD_LOGIC;
    done: in STD_LOGIC;
    read: out STD_LOGIC;
    enable_counter: out STD_LOGIC;
    req: out STD_LOGIC;
    wr: out STD_LOGIC;
    
    tbe: in STD_LOGIC
);
end component;

-- segnali
signal count_en: STD_LOGIC;
signal re: STD_LOGIC;
signal addr_A: STD_LOGIC_VECTOR((DIM-1) downto 0);

begin

CU_A: control_unit_A
generic map( DIM=>3 )
port map(
    start => START,
    address_A => addr_A,
    clk_a => CLK_A,
    reset => RESET,
    ack => ACK,
    req => REQ,
    done => DONE,
    read => re,
    enable_counter => count_en,
    wr => WR,
    
    tbe => TBE
);

COUNTER_A: counter
generic map( DIM=>3 )
port map(
    clock => CLK_A,
    reset => RESET,
    enable => count_en,
    counter => addr_A
);


ROM_A: ROM
generic map(
    DIM=>3,
    N=>8,
    M=>8
)
port map(
    clk_a => CLK_A,
    rst => RESET,
    read => re,
    address_A => addr_A,
    data_out => DATA_OUT
);

end Structural;