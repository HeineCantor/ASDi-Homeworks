library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ROM is
port(
    CLK : in std_logic;
    read: in std_logic;
    ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM
    DATAOUT : out std_logic_vector(7 downto 0) -- dato su 8 bit letto dalla ROM
    );
end ROM;

-- creo una ROM di 8 elementi da 8 bit ciascuno
architecture behavioral of ROM is
  type mem is array ( 0 to 2**3 - 1) of std_logic_vector(7 downto 0);
  constant rom : mem := (
    0  => "11110000",
    1  => "11110001",
    2  => "11110010",
    3  => "11110011",
    4  => "11110100",
    5  => "11110101",
    6  => "11110110",
    7  => "11110111");
    
begin
   process (ADDR)
   begin
     case ADDR is
       when "000" => dataOut <= rom(0);
       when "001" => dataOut <= rom(1);
       when "010" => dataOut <= rom(2);
       when "011" => dataOut <= rom(3);
       when "100" => dataOut <= rom(4);
       when "101" => dataOut <= rom(5);
       when "110" => dataOut <= rom(6);
       when "111" => dataOut <= rom(7);
       when others => dataOut <= "00000000";
	 end case;
  end process;
end architecture behavioral;