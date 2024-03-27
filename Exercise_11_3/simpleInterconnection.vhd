library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simpleInterconnection4to4 is
    port(
        inputArray: in std_logic_vector(3 downto 0);
        selectorTx, selectorRx: in std_logic_vector(1 downto 0);
        outputArray: out std_logic_vector(3 downto 0)
    );
end simpleInterconnection4to4;

architecture behavioral of simpleInterconnection4to4 is

    signal inputSelection: std_logic;

begin

    inputSelection <=   inputArray(3) when selectorTx="00" else
                        inputArray(2) when selectorTx="01" else
                        inputArray(1) when selectorTx="10" else
                        inputArray(0) when selectorTx="11" else
                        'U';
                        
    outputArray <=      inputSelection & "000" when selectorRx="00" else
                        "0" & inputSelection & "00" when selectorRx="01" else
                        "00" & inputSelection & "0" when selectorRx="10" else
                        "000" & inputSelection when selectorRx="11" else
                        "UUUU";
                    
end behavioral;
