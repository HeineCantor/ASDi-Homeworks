library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodeTX is
    port(
        clock, reset: in std_logic;
        startTransmit: in std_logic;
        inputData: in std_logic_vector(1 downto 0);
        readyToReceive: in std_logic;
        address: in std_logic_vector(1 downto 0);
        
        readyToTransmit, transmitCompleted: out std_logic;
        outputFrame: out std_logic_vector(3 downto 0)
    );
end nodeTX;

architecture structural of nodeTX is

    component txControlUnit is
        port(
            clock, reset: in std_logic;
            startTransmissionProcess: in std_logic;
            rxAck: in std_logic;
            
            txReq, txCompleted: out std_logic
        );
    end component;

begin

    outputFrame <= address & inputData;
    
    txCU: txControlUnit
    port map(
        clock => clock,
        reset => reset,
        startTransmissionProcess => startTransmit,
        rxAck => readyToReceive,
        
        txReq => readyToTransmit,
        txCompleted => transmitCompleted
    );

end structural;
