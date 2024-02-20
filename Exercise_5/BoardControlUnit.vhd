library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BoardControlUnit is
    port(
        clock, reset: in std_logic;
        setSignal: in std_logic;
        cancelSignal:   in std_logic;
        switchInput: in std_logic_vector(15 downto 0);
        secInput, minInput, hourInput: in std_logic_vector(7 downto 0);
        
        enableClock: out std_logic;
        loadSignal: out std_logic;
        selSec, selMin, selHour: out std_logic_vector(5 downto 0);
        displayEnable: out std_logic_vector(7 downto 0);
        valueToPrint:  out std_logic_vector(31 downto 0)
    );
end BoardControlUnit;

architecture Behavioral of BoardControlUnit is

    component clock_filter is
        generic(
            CLKIN_freq : integer := 100000000; --clock board 100MHz
            CLKOUT_freq : integer := 500       --frequenza desiderata 500Hz
                );
        Port ( 
           clock_in : in  STD_LOGIC;
           reset : in STD_LOGIC;
           clock_out : out  STD_LOGIC -- attenzione: non � un vero clock ma un impulso che sar� usato come enable
        ); 
    end component;

    type state is (idle, settingSeconds, settingMinutes, settingHours, disableState, loadingState, enableState);
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

    automa: process(currentState, setSignal, cancelSignal)
    begin
        displayEnable <= (others => '0');
        valueToPrint <= (others => '0');
        enableClock <= '0';
        loadSignal <= '0';
    
        case currentState is
            when idle =>
                if (setSignal = '1') then
                    nextState <= settingSeconds;
                else
                    nextState <= idle;                    
                    enableClock <= '1';
                    valueToPrint <= "00000000" & hourInput & minInput & secInput;
                    displayEnable <= "00111111";
                end if;
            when settingSeconds =>
                if (setSignal = '1') then
                    nextState <= settingMinutes;
                else
                    nextState <= settingSeconds;  
                    enableClock <= '1';
                    valueToPrint <= "00000000000000000000000000" & selSecLink;
                    displayEnable <= "00111111";
                    selSecLink <= switchInput(5 downto 0);
                end if;
            when settingMinutes =>
                if (setSignal = '1') then
                    nextState <= settingHours;
                else
                    nextState <= settingMinutes;  
                    enableClock <= '1';
                    valueToPrint <= "000000000000000000" & selMinLink & "00" & selSecLink;
                    displayEnable <= "00111111";
                    selMinLink <= switchInput(5 downto 0);
                end if;
            when settingHours =>
                if (setSignal = '1') then
                    nextState <= disableState;
                else
                    nextState <= settingHours;  
                    enableClock <= '1';
                    valueToPrint <= "0000000000" & selHourLink & "00" & selMinLink & "00" & selSecLink;
                    displayEnable <= "00111111";
                    selHourLink <= switchInput(5 downto 0);
                end if;
            when disableState =>
                nextState <= loadingState;
            when loadingState =>
                nextState <= enableState;  
                loadSignal <= '1';
            when enableState =>
                nextState <= idle;
            when others => 
                nextState <= idle;
        end case;
    end process;
    
    selSec <= selSecLink;
    selMin <= selMinLink;
    selHour <= selHourLink;

end Behavioral;
