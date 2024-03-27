library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodeTX is
    port(
        clock: in std_logic;
        startTransmit, startHandshake: in std_logic;
        inputData: in std_logic_vector(1 downto 0);
        readyToReceive: in std_logic;
        address: in std_logic_vector(1 downto 0);
        
        requestForTransmit, readyToTransmit, transmitCompleted: out std_logic;
        outputFrame: out std_logic_vector(3 downto 0)
    );
end nodeTX;

architecture structural of nodeTX is

begin

    readyToTransmit <= '0';
    outputFrame <= address & inputData;

end structural;
