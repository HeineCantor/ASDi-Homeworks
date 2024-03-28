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
            
            rxAck, loadData: out std_logic
        );
    end component;
    
    signal loadInternalData: std_logic;
    signal internalData: std_logic_vector(1 downto 0);

begin

    rxCU: rxControlUnit
    port map(
        clock => clock,
        reset => reset,
        txReq => readyToTransmit,
        
        rxAck => readyToReceive,
        loadData => loadInternalData
    );

    outputData <= internalData;
    
    registerProcess: process(clock)
    begin
        if (clock'event and clock='1') then
            if (reset = '1') then
                internalData <= "00";
            else
                if (loadInternalData = '1') then
                    internalData <= inputData;
                end if;
            end if;
        end if;
    end process;

end structural;
