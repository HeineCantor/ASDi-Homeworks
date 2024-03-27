library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity txControlUnit is
    port(
        clock, reset: in std_logic;
        startTransmissionProcess: in std_logic;
        rxAck: in std_logic;
        
        txReq, txCompleted: out std_logic
    );
end txControlUnit;

architecture Behavioral of txControlUnit is

    type state is (idle, waitForAck);
    signal currentState, nextState: state;

begin

    updateState: process(clock)
    begin
        if (clock'event and clock='1') then
            if (reset = '1') then
                currentState <= idle;
            else
                currentState <= nextState;
            end if;
        end if;
    end process;
    
    automa: process(currentState, startTransmissionProcess, rxAck)
    begin
        txReq <= '0';
        txCompleted <= '0';
        
        case currentState is
            when idle =>
                if (startTransmissionProcess = '1') then
                    nextState <= waitForAck;
                else
                    nextState <= idle;
                end if;
            when waitForAck =>
                txReq <= '1';
                
                if (rxAck = '1') then
                    txCompleted <= '1';
                    nextState <= idle;
                else
                    nextState <= waitForAck;
                end if;   
        end case;
    end process;

end Behavioral;
