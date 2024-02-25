library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardControlUnit is
    port(
        clock, reset: in std_logic;
        
        multiplySignal, productReady: in std_logic;
        
        startMultiplication, displaySelector: out std_logic;
        productOperationFinish: out std_logic
    );
end BoardControlUnit;

architecture Behavioral of BoardControlUnit is

    type state is (idleState, startMultiplicationState, waitingMultiplicationState, multiplicationFinishedState);
    signal currentState, nextState: state;
    
    signal start, operationFinished: std_logic;

begin
    updateState: process(clock)
    begin
        if(clock'event and clock='1') then
            if(reset='1') then
                currentState <= idleState;
            else
                currentState <= nextState;
            end if;    
        end if;
    end process;
    
    automa: process(currentState, multiplySignal, productReady)
    begin
        operationFinished <= '0';
        start <= '0';
        displaySelector <= '0';
    
        case currentState is
            when idleState =>
                if (multiplySignal = '1') then
                    nextState <= startMultiplicationState;
                else
                    nextState <= idleState;
                    displaySelector <= '0';
                end if;
            when startMultiplicationState =>
                start <= '1';
                
                nextState <= waitingMultiplicationState;
            when waitingMultiplicationState =>
                if (productReady = '1') then
                    nextState <= multiplicationFinishedState;
                else
                    nextState <= waitingMultiplicationState;
                end if;
            when multiplicationFinishedState =>
                nextState <= multiplicationFinishedState;
                operationFinished <= '1';
                displaySelector <= '1';
        end case;
    end process;
    
    startMultiplication <= start;
    productOperationFinish <= operationFinished;
end Behavioral;
