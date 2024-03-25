library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnitaControllo is
    port(
        clock, reset, start:    in std_logic;
        count:  in std_logic_vector(1 downto 0);
        
        sign:   in std_logic;
        
        loadM, loadAQ, loadS, countSignal, subSignal, shiftAQ: out std_logic;
        selAQ:  out std_logic_vector(1 downto 0);
        
        divisionFinished: out std_logic
    );
end UnitaControllo;

architecture Behavioral of UnitaControllo is
    
    type state is (idle, operandPreparation, goPrepareS, goShift, goOperation, goUpdateS, goUpdate, goCount, correctionState, endState);
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
    
    automa: process(currentState, start, count)
    begin
    
        countSignal <= '0';
        subSignal <= '0';
        loadM <= '0';
        loadAQ <= '0';
        loadS <= '0';
        shiftAQ <= '0';
        selAQ <= "01";
        
        divisionFinished <= '0';
        
        CASE currentState is
            WHEN idle =>
                if (start = '1') then
                    nextState <= operandPreparation;
                else
                    nextState <= idle;
                end if;             
                
            WHEN operandPreparation =>
                loadM <= '1';
                loadAQ <= '1';
                
                nextState <= goPrepareS;
                
            WHEN goPrepareS =>
                loadS <= '1';
                
                nextState <= goShift;
                
            WHEN goShift =>
                shiftAQ <= '1';
                
                nextState <= goOperation;
                
            WHEN goOperation =>
                if (sign = '0') then
                    subSignal <= '1';
                    
                    selAQ <= "10";
                    loadAQ <= '1';
                elsif (sign = '1') then
                    selAQ <= "10";
                    loadAQ <= '1';
                end if;
                
                nextState <= goUpdateS;
                
            WHEN goUpdateS =>
                loadS <= '1';
                
                nextState <= goUpdate;            
                
            WHEN goUpdate =>
                selAQ <= "11";
                loadAQ <= '1';
                
                if (count = "11") then
                    nextState <= correctionState;
                else
                    nextState <= goCount;
                end if; 
                
            WHEN goCount =>
                countSignal <= '1';
                
                nextState <= goShift;
                
            WHEN correctionState =>
                if (sign = '1') then
                    selAQ <= "10";
                    loadAQ <= '1';
                end if;
                
                nextState <= endState;
                
            WHEN endState =>
                divisionFinished <= '1';
                
                nextState <= endState;   
        END CASE;
    
    end process;

end Behavioral;
