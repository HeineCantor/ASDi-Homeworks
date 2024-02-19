
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system is
  Port ( 
  START: in STD_LOGIC;
  enableRead: in STD_LOGIC;
  CLK: in STD_LOGIC;
  RST: in STD_LOGIC;
  STOP: out STD_LOGIC;
  OUTPUT: out STD_LOGIC_VECTOR(3 downto 0) :="0000"
  );
end system;

architecture Structural of system is

component control_unit is
    port(
        start: in STD_LOGIC;
        enableRead: in STD_LOGIC;
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        read: out STD_LOGIC;
        read_ram: out STD_LOGIC;
        write: out STD_LOGIC;
        address: in STD_LOGIC_VECTOR (2 downto 0);
        stop: out STD_LOGIC;
        en: out STD_LOGIC
    );
end component;


component counter_mod8 is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (2 downto 0));
end component;


component ROM is
port(
    CLK : in std_logic;
    read: in std_logic;
    ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM
    DATAOUT : out std_logic_vector(7 downto 0) -- dato su 8 bit letto dalla ROM
    );
end component;


component M is
    port(
        input: in std_logic_vector (7 downto 0);
        output: out std_logic_vector(3 downto 0)
    );
end component;


component mem is
generic(
    address_length: natural := 3;
    data_length: natural := 4
);
port(
    clock: in std_logic;
    read: in std_logic;
    write: in std_logic;
    address: in std_logic_vector((address_length - 1) downto 0);
    data_input: in std_logic_vector ((data_length - 1) downto 0);
    data_output: out std_logic_vector ((data_length - 1) downto 0) :="0000"
);
end component;


--segnali
signal CU_reset: STD_LOGIC;
signal CU_read_ROM: STD_LOGIC;
signal CU_write_MEM: STD_LOGIC;
signal addr: STD_LOGIC_VECTOR(2 downto 0);
signal CU_enable: STD_LOGIC;
signal data_out: STD_LOGIC_VECTOR(7 downto 0);
signal data_out_M: STD_LOGIC_VECTOR(3 downto 0);
signal uscita: STD_LOGIC_VECTOR(3 downto 0) :="0000";
signal CU_read_RAM: STD_LOGIC;

begin

--assegnazione segnali
CU_reset <= RST;

CU: control_unit
port map(
    start => START,
    enableRead => enableRead,
    clk => CLK,
    reset => CU_reset,
    read => CU_read_ROM,
    read_ram => CU_read_RAM,
    write => CU_write_MEM,
    address => addr,
    stop => STOP,
    en => CU_enable
);


COUNT: counter_mod8
port map(
    enable => CU_enable,
    clock => CLK,
    reset => RST, --CU_RESET
    counter => addr 
);

ROM_MEM: rom
port map(
    CLK => CLK,
    read => CU_read_ROM,
    addr => addr,
    dataout => data_out
);


MACHINE: M
port map(
    input => data_out,
    output => data_out_M
);


RAM: mem
port map(
    clock => CLK,
    read => CU_read_RAM,
    write => CU_write_MEM,
    address => addr,
    data_input => data_out_M,
    data_output => uscita
);

output <= uscita;


end Structural;
