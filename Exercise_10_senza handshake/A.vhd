library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A is
generic(
    DIM: integer :=3; --dimensione indirizzo
    M: integer := 8 --lunghezza stringhe
);
port( 
    RESET: in STD_LOGIC;
    CLK_A: in STD_LOGIC;
    EN_WRITE: in STD_LOGIC;
    
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
		   enable : in STD_LOGIC; --enable viene dal divisore di frequenza
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0)); -- COUNTER corrisponde ad ADDRESS
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
    address_A: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    clk_A: in STD_LOGIC;
    reset: in STD_LOGIC;
    enable_write: in STD_LOGIC;
    
    read: out STD_LOGIC;
    enable_counter: out STD_LOGIC;
    
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
port map(
    address_A => addr_A,
    clk_a => CLK_A,
    reset => RESET,
    enable_write => EN_WRITE,
    
    read => re,
    enable_counter => count_en,
    
    wr => WR,
    tbe => TBE
);

COUNTER_A: counter
port map(
    clock => CLK_A,
    reset => RESET,
    enable => count_en,
    counter => addr_A
);


ROM_A: ROM
port map(
    clk_a => CLK_A,
    rst => RESET,
    read => re,
    address_A => addr_A,
    data_out => DATA_OUT
);

end Structural;