
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_SYSTEM is
generic( M: natural := 8 );
port(

    CLK: in STD_LOGIC;
    RESET: in STD_LOGIC;
    EN_WR, EN_RD: in STD_LOGIC;

    DATA_IN: out STD_LOGIC_VECTOR(7 downto 0);
    DATA_OUT: out STD_LOGIC_VECTOR(7 downto 0);
    PE: out STD_LOGIC;
    FE: out STD_LOGIC;
    OE: out STD_LOGIC;
    
    WR: out STD_LOGIC;
    TY: out STD_LOGIC;
    EN_COUNT: out STD_LOGIC
);
end UART_SYSTEM;

architecture Behavioral of UART_SYSTEM is

component A is
generic(
    DIM: integer :=3; --dimensione indirizzo
    M: integer := 8 --lunghezza stringhe
);
port( 
    CLK_A: in STD_LOGIC;
    RESET: in STD_LOGIC;
    EN_WRITE: in STD_LOGIC;
    
    DATA_OUT: out STD_LOGIC_VECTOR((M-1) downto 0);

    WR: out STD_LOGIC;   
    TBE: in STD_LOGIC
);
end component;

component B is
generic(
    M: integer := 8;
    DIM: integer := 3
);
port(
    DATA_IN: in STD_LOGIC_VECTOR((M-1) downto 0);
    CLK_B: in STD_LOGIC;
    RESET: in STD_LOGIC;
    EN_READ: in STD_LOGIC;
    
    RDA: in STD_LOGIC;
    RD: out STD_LOGIC;
    DATA_OUT: out STD_LOGIC_VECTOR((M-1) downto 0)
);
end component;


component Rs232RefComp is
    Port ( 
		TXD 	: out std_logic  	:= '1';
    	RXD 	: in  std_logic;					
    	CLK 	: in  std_logic;					--Master Clock
		DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
		DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		RDA	: inout std_logic;						--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
		TBE	: inout std_logic 	:= '1';				--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
		RD		: in  std_logic;					--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
		WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
		PE		: out std_logic;					--Parity Error Flag
		FE		: out std_logic;					--Frame Error Flag
		OE		: out std_logic;					--Overwrite Error Flag
		RST		: in  std_logic	:= '0');			--Master Reset
end component;





signal int_wr: STD_LOGIC;
signal int_data: STD_LOGIC_VECTOR(7 downto 0);
signal int_ty: STD_LOGIC;
signal dbout: STD_LOGIC_VECTOR(7 downto 0);
signal int_rda: STD_LOGIC;
signal int_rd: STD_LOGIC :='0';
signal clk_d: STD_LOGIC;
signal d: STD_LOGIC_VECTOR(7 downto 0);
signal int_tbe: STD_LOGIC;


begin

COMP_A: A
port map(
    CLK_A=> CLK,
    RESET=> RESET,
    EN_WRITE => EN_WR,
    
    DATA_OUT=> int_data,
    
    WR=> int_wr,
    TBE =>int_tbe
);


UART_T: Rs232RefComp
port map(
	TXD => int_ty,
    RXD	=> '1',			
    CLK => CLK,
	DBIN => int_data,
	DBOUT => OPEN,
	RDA => OPEN,
	TBE => int_tbe,
	RD => '0',
	WR => int_wr,
	PE => OPEN,
	FE => OPEN,
	OE => OPEN,
	RST => RESET
);

UART_R : Rs232RefComp
port map(
	TXD => OPEN,
    RXD	=> int_ty,			
    CLK => CLK,
	DBIN => int_data,
	DBOUT => dbout,
	RDA => int_rda,
	TBE => OPEN,
	RD => int_rd,
	WR => '0',
	PE => PE,
	FE => FE,
	OE => OE,
	RST => RESET
);


COMP_B: B
port map(
    DATA_IN=> dbout,
    CLK_B=> CLK,
    RESET=> RESET,
    EN_READ => EN_RD,
    RDA=> int_rda,
    RD=> int_rd,
    DATA_OUT => d
);

DATA_IN <= int_data;
DATA_OUT <= dbout;
--DIVISORE <= clk_d;
WR <= int_wr;
TY<=int_ty;


end Behavioral;