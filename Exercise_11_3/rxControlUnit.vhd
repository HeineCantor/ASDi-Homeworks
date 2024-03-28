library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rxControlUnit is
    port(
        clock, reset: in std_logic;
        txReq: in std_logic;
        
        rxAck, loadData: out std_logic
    );
end rxControlUnit;

architecture Behavioral of rxControlUnit is

    type state is (idle, dataLoading, waitForReqLow);
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
    
    automa: process(currentState, txReq)
    begin
        rxAck <= '0';
        loadData <= '0';
        
        case currentState is
            when idle =>
                if (txReq = '1') then
                    nextState <= dataLoading;
                else
                    nextState <= idle;
                end if;
            when dataLoading =>
                loadData <= '1';
                nextState <= waitForReqLow;         
            when waitForReqLow =>
                rxAck <= '1';
                
                if (txReq = '0') then
                    nextState <= idle;
                else
                    nextState <= waitForReqLow;
                end if;   
        end case;
    end process;

end Behavioral;
