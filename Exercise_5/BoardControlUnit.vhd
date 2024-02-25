library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardControlUnit is
    port(
        clock, reset: in std_logic;
        setSignal: in std_logic;
        intertimeSignal: in std_logic;
        cancelSignal:   in std_logic;
        switchInput: in std_logic_vector(5 downto 0);
        
        enableClock: out std_logic;
        loadSignal: out std_logic;
        selSec, selMin, selHour: out std_logic_vector(5 downto 0);
        selDisplayOutput:  out std_logic_vector(1 downto 0);
        memoryWrite, memoryRead: out std_logic
    );
end BoardControlUnit;

architecture Behavioral of BoardControlUnit is

    type state is (idle, settingSeconds, settingMinutes, settingHours, disableState, loadingState, enableState, readFromMem, intertimeState, storeInMem);
    signal currentState, nextState: state;
    
    signal selSecLink, selMinLink, selHourLink: std_logic_vector(5 downto 0) := (others => '0');

begin

    updateState: process(clock)
    begin
        if(clock'event and clock='1') then
            if(reset='1') then
                currentState <= idle;
            else
                currentState <= nextState;
            end if;    
        end if;
    end process;

    automa: process(currentState, setSignal, cancelSignal, intertimeSignal)
    begin
        enableClock <= '0';
        loadSignal <= '0';
        selDisplayOutput <= "01";
        memoryWrite <= '0';
        memoryRead <= '0';
    
        case currentState is
            when idle =>
                if (setSignal = '1') then
                    nextState <= settingSeconds;
                elsif (intertimeSignal = '1') then
                    nextState <= intertimeState;
                elsif( cancelSignal = '1') then
                    nextState <= storeInMem;
                else
                    nextState <= idle;                    
                    enableClock <= '1';
                    selDisplayOutput <= "01";
                end if;
            when settingSeconds =>
                if (setSignal = '1') then
                    nextState <= settingMinutes;
                else
                    nextState <= settingSeconds;  
                    enableClock <= '1';
                    selSecLink <= switchInput(5 downto 0);
                    selDisplayOutput <= "10";
                end if;
            when settingMinutes =>
                if (setSignal = '1') then
                    nextState <= settingHours;
                else
                    nextState <= settingMinutes;  
                    enableClock <= '1';
                    selMinLink <= switchInput(5 downto 0);
                    selDisplayOutput <= "10";
                end if;
            when settingHours =>
                if (setSignal = '1') then
                    nextState <= disableState;
                else
                    nextState <= settingHours;  
                    enableClock <= '1';
                    selHourLink <= switchInput(5 downto 0);
                    selDisplayOutput <= "10";
                end if;
            when disableState =>
                nextState <= loadingState;
            when loadingState =>
                nextState <= enableState;  
                loadSignal <= '1';
            when enableState =>
                nextState <= idle;
            when readFromMem =>
                memoryRead <= '1';
                nextState <= intertimeState;
            when intertimeState =>
                if (cancelSignal = '1') then
                    nextState <= idle;
                elsif (intertimeSignal = '1') then
                    nextState <= readFromMem;
                else
                    enableClock <= '1';
                    nextState <= intertimeState;
                    selDisplayOutput <= "11";
                end if;
            when storeInMem =>
                memoryWrite <= '1';
                nextState <= idle;
            when others => 
                nextState <= idle;
        end case;
    end process;
    
    selSec <= selSecLink;
    selMin <= selMinLink;
    selHour <= selHourLink;

end Behavioral;
