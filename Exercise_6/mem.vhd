library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
entity mem is
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
end mem;
 
architecture arch of mem is
    type ram_type is array (0 to (2**(address_length) -1)) of std_logic_vector((data_length - 1) downto 0);
    signal ram: ram_type;
begin
 
process(clock) is
begin
    if rising_edge(clock)then
        if(read = '1') then
            data_output <= ram(conv_integer(unsigned(address)));
        elsif (write = '1') then
            ram(conv_integer(unsigned(address))) <= data_input;
        end if;     
    end if;
end process;
 
end arch;