library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity rom_16_8bit_tb is
end rom_16_8bit_tb;

architecture behavioral of rom_16_8bit_tb is

    component rom_16_8bit
        port 
        (
            address : in std_logic_vector(3 downto 0);
            dataOut : out std_logic_vector(7 downto 0)
        );
    end component;

    signal inputAddress : std_logic_vector(3 downto 0) := (others => 'U');
    signal outputData   : std_logic_vector(7 downto 0) := (others => 'U');

begin

    uut : rom_16_8bit
    port map 
    ( 
        address => inputAddress,
        dataOut => outputData
    );

    stim_proc : process
    begin
        
        wait for 100 ns;

        inputAddress <= "0000";

        wait for 10 ns;

        inputAddress <= "1100";

        wait for 10 ns;

        inputAddress <= "1111";

        wait for 10 ns;

        assert outputData = x"ff"
        report "error"
        severity failure;

        wait;
    end process;

end;
