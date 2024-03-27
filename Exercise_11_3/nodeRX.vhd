library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodeRX is
    generic(
        address: std_logic_vector(1 downto 0) := "00"
    );
    port(
        clock: in std_logic;
        inputData: in std_logic_vector(1 downto 0);
        readyToTransmit: in std_logic;
        
        readyToReceive: out std_logic;
        outputData: out std_logic_vector(1 downto 0)
    );
end nodeRX;

architecture structural of nodeRX is

begin

    readyToReceive <= '0';
    outputData <= inputData;

end structural;
