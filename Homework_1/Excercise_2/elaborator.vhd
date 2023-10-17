library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity elaborator is
    port(
        dataInput   : in  std_logic_vector(7 downto 0);
        dataOutput  : out std_logic_vector(3 downto 0)
    );
end entity elaborator;

architecture dataflow of elaborator is
    begin
        dataOutput <= dataInput(7 downto 4);
end architecture dataflow;