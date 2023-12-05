library ieee;
use ieee.std_logic_1164.all;

entity ROM is
  port ( address : in std_logic_vector(3 downto 0);
         dataOut : out std_logic_vector(7 downto 0) );
end entity ROM;

architecture behavioral of ROM is
  type mem is array ( 0 to 2**4 - 1) of std_logic_vector(7 downto 0);
  constant rom : mem := (
    0  => "01010101",
    1  => "00000001",
    2  => "00000010",
    3  => "00000011",
    4  => "00000100",
    5  => "11110000",
    6  => "11110000",
    7  => "11110000",
    8  => "11110000",
    9  => "11110000",
    10 => "11110000",
    11 => "11110000",
    12 => "11110000",
    13 => "11110000",
    14 => "11110000",
    15 => "11000111");
begin
   process (address)
   begin
     case address is
       when "0000" => dataOut <= rom(0);
       when "0001" => dataOut <= rom(1);
       when "0010" => dataOut <= rom(2);
       when "0011" => dataOut <= rom(3);
       when "0100" => dataOut <= rom(4);
       when "0101" => dataOut <= rom(5);
       when "0110" => dataOut <= rom(6);
       when "0111" => dataOut <= rom(7);
       when "1000" => dataOut <= rom(8);
       when "1001" => dataOut <= rom(9);
       when "1010" => dataOut <= rom(10);
       when "1011" => dataOut <= rom(11);
       when "1100" => dataOut <= rom(12);
       when "1101" => dataOut <= rom(13);
       when "1110" => dataOut <= rom(14);
       when "1111" => dataOut <= rom(15);
       when others => dataOut <= "00000000";
	 end case;
  end process;
end architecture behavioral;
