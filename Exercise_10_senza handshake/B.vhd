
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity B is
generic(
    M: integer := 8;
    DIM: integer := 3
);
port(
    DATA_IN: in STD_LOGIC_VECTOR((M-1) downto 0);
    CLK_B: in STD_LOGIC;
    RESET: in STD_LOGIC;
    RDA: in STD_LOGIC;
    EN_READ: in STD_LOGIC;
    
    RD: out STD_LOGIC;
    DATA_OUT: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end B;

architecture Structural of B is

component counter is
generic( DIM: integer :=3 );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --enable viene dal divisore di frequenza
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0)); -- COUNTER corrisponde ad ADDRESS
end component;

component RAM is
generic(
    DIM: integer :=3; --dimensione indirizzo
    N: integer :=8; --numero stringhe
    M: integer :=8  --lunghezza stringa
);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    data_in: in STD_LOGIC_VECTOR((M-1) downto 0);
    address_B: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    write: in STD_LOGIC;
    read: in STD_LOGIC;
    Y: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;

component register_B is
generic( M: integer := 8);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    data_in: in STD_LOGIC_VECTOR((M-1) downto 0);
    read: in STD_LOGIC;
    data_out: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;

component control_unit_B is
generic( DIM: integer :=3);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    enableRead: in STD_LOGIC;
      
    enable_counter: out STD_LOGIC;    
    write: out STD_LOGIC;
    read_reg: out STD_LOGIC;

    rda: in STD_LOGIC;
    rd: out STD_LOGIC
);
end component;


--segnali
signal en_counter: STD_LOGIC;
signal addr: STD_LOGIC_VECTOR((DIM-1) downto 0);
signal we: STD_LOGIC;
signal re_reg: STD_LOGIC;
signal re: STD_LOGIC;
signal internal_data: STD_LOGIC_VECTOR((M-1) downto 0);
signal uscita_ram: STD_LOGIC_VECTOR((M-1) downto 0);

begin
COUNTER_B: counter
port map(
    clock => CLK_B,
    reset => RESET,
    enable => en_counter,
    counter => addr
);

MEM_B: RAM
port map(
    clk_b => CLK_B,
    reset =>  RESET,
    data_in => internal_data,
    address_B => addr,
    write => we,
    read => re,
    Y => uscita_ram
);

REG_B: register_B
port map(
    clk_b => CLK_B,
    reset => RESET,
    data_in => DATA_IN,
    read => re_reg,
    data_out => internal_data
);

CU_B: control_unit_B
port map(
    clk_b => CLK_B,
    reset => RESET,
    enableRead => EN_READ,
    
    enable_counter => en_counter,
    write => we,
    read_reg => re_reg,
 
    rda => RDA,
    rd => RD
);

DATA_OUT <= uscita_ram;

end Structural;
