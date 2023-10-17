library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity elaborator_tb is
end elaborator_tb;

architecture behavioral of elaborator_tb is

    component elaborator
        port(
            dataInput   : in  std_logic_vector(7 downto 0);
            dataOutput  : out std_logic_vector(3 downto 0)
        );
    end component;

    signal inputSignal    : std_logic_vector(7 downto 0) := (others => 'U');
    signal outputSignal   : std_logic_vector(3 downto 0) := (others => 'U');

begin

    uut : elaborator
    port map 
    ( 
        dataInput => inputSignal,
        dataOutput => outputSignal
    );

    stim_proc : process
    begin
        
        wait for 100 ns;

        inputSignal <= "01101100";

        wait for 10 ns;

        inputSignal <= "00011111";

        wait for 10 ns;

        inputSignal <= "10100101";

        wait for 10 ns;

        assert outputSignal = "1010"
        report "error"
        severity failure;

        wait;
    end process;

end;
