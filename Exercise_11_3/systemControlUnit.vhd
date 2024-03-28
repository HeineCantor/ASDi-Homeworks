library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity systemControlUnit is
    port(
        clock, reset: in std_logic;
        enableArray: in std_logic_vector(3 downto 0);
        rxAddress0, rxAddress1, rxAddress2, rxAddress3: in std_logic_vector(1 downto 0);
        transmissionComplete: in std_logic;
        
        selectorTx, selectorRx: out std_logic_vector(1 downto 0);
        startHandshakingArray, enableOmegaInput: out std_logic_vector(3 downto 0)
    );
end systemControlUnit;

architecture Behavioral of systemControlUnit is

    type state is (idleState, setupInterconnection, enableChannel, startHandshaking, waitForHandshake, disableChannel);

    signal currentState, nextState: state;
    signal currentTransmitter: std_logic_vector(3 downto 0);

begin

    updateState: process(clock)
    begin 
        if (clock'event and clock='1') then
            if (reset = '1') then
                currentState <= idleState;
            else
                currentState <= nextState;
            end if;
        end if;    
    end process;
    
    automa: process(currentState, enableArray, transmissionComplete)
    begin
        case currentState is
            when idleState =>
                if (enableArray(0) /= '1' and enableArray(1) /= '1' and enableArray(2) /= '1' and enableArray(3) /= '1') then
                    nextState <= idleState;
                else
                    nextState <= setupInterconnection;
                end if;
                
            when setupInterconnection =>
                if (enableArray(3)='1') then
                    currentTransmitter <= "1000";
                    selectorTx <= "00";
                    selectorRx <= rxAddress0;
                elsif (enableArray(2) = '1') then
                    currentTransmitter <= "0100";
                    selectorTx <= "01";
                    selectorRx <= rxAddress1;
                elsif (enableArray(1) = '1') then
                    currentTransmitter <= "0010";
                    selectorTx <= "10";
                    selectorRx <= rxAddress2;
                else
                    currentTransmitter <= "0001";
                    selectorTx <= "11";
                    selectorRx <= rxAddress3;
                end if;
                
                nextState <= enableChannel;
                
            when enableChannel =>
                enableOmegaInput <= currentTransmitter;
                nextState <= startHandshaking;
                
            when startHandshaking =>
                startHandshakingArray <= currentTransmitter;
                nextState <= waitForHandshake;
                
            when waitForHandshake =>
                if (transmissionComplete = '1') then
                    nextState <= disableChannel;
                else
                    nextState <= waitForHandshake;             
                end if;
                
            when disableChannel =>
                enableOmegaInput <= "0000";
                startHandshakingArray <= "0000";
                currentTransmitter <= "0000";
                if (enableArray = "0000") then
                    nextState <= idleState;
                else
                    nextState <= setupInterconnection;             
                end if;                   
        end case;
    end process;

end Behavioral;
