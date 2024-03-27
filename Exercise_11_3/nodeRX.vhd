library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodeRX is
    generic(
        address: std_logic_vector(1 downto 0) := "00"
    );
    port(
        clock, reset: in std_logic;
        inputData: in std_logic_vector(1 downto 0);
        readyToTransmit: in std_logic;
        
        readyToReceive: out std_logic;
        outputData: out std_logic_vector(1 downto 0)
    );
end nodeRX;

architecture structural of nodeRX is

    component rxControlUnit is
        port(
            clock, reset: in std_logic;
            txReq: in std_logic;
            
            rxAck: out std_logic
        );
    end component;

begin

    rxCU: rxControlUnit
    port map(
        clock => clock,
        reset => reset,
        txReq => readyToTransmit,
        
        rxAck => readyToReceive
    );

    outputData <= inputData;

end structural;
