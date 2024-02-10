library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity full_system_tb is
end full_system_tb;

architecture behavioral of full_system_tb is

    component full_system
        port(
            inputAddress    : in  std_logic_vector(3 downto 0);
            dataOutput      : out std_logic_vector(3 downto 0)
        );
    end component;

    signal inputSignal    : std_logic_vector(3 downto 0) := (others => 'U');
    signal outputSignal   : std_logic_vector(3 downto 0) := (others => 'U');

begin

    uut : full_system
    port map 
    ( 
        inputAddress => inputSignal,
        dataOutput => outputSignal
    );

    stim_proc : process
    begin
        
        wait for 100 ns;

        inputSignal <= "1111";

        wait for 10 ns;

        inputSignal <= "1100";

        wait for 10 ns;

        inputSignal <= "0011";

        wait for 10 ns;

        assert outputSignal = x"0"
        report "error"
        severity failure;

        wait;
    end process;

end;
