
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    port(
        start: in STD_LOGIC;
        enableRead: in STD_LOGIC;
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        read: out STD_LOGIC;
        read_ram: out STD_LOGIC;
        write: out STD_LOGIC;
        address: in STD_LOGIC_VECTOR(2 downto 0);
        stop: out STD_LOGIC;
        en: out STD_LOGIC
    );
end control_unit;

architecture Behavioral of control_unit is
type stato is (INIT, STOP_STATE, WAITING_FOR_ENABLE, EN_COUNT, READ_ROM, ROM_TO_M, M_TO_RAM, PRINT);

signal stato_corrente : stato := INIT;
signal stato_prossimo: stato;


begin

EXIT_STATE: process(stato_corrente,start,reset,address)
begin

    en <= '0';
    read <= '0';
    read_ram <= '0';
    write <= '0';
    stop <= '0';
                    
    case stato_corrente is

        when INIT =>
            if(start = '1') then
                stato_prossimo <= WAITING_FOR_ENABLE;
            else
                stato_prossimo <= INIT;
            end if;
        
        when STOP_STATE =>
            stop <= '1';
            
        when WAITING_FOR_ENABLE =>
            if(enableRead = '1') then
                stato_prossimo <= READ_ROM;
            else
                stato_prossimo <= WAITING_FOR_ENABLE;
            end if;
            
        when READ_ROM => 
            read <= '1';
            stato_prossimo <= M_TO_RAM;     
       
        when EN_COUNT =>
          if address="111" then
                stato_prossimo <= STOP_STATE;
          else
            en <= '1';
            stato_prossimo <= WAITING_FOR_ENABLE;
          end if;       
      
        when M_TO_RAM =>
            write <= '1';
            stato_prossimo <= PRINT;
            
        when PRINT =>
            read_ram <= '1';
            stato_prossimo <= EN_COUNT;
            
        when others =>
            stato_prossimo <= INIT;
                   
    end case;
end process;



MEM: process(clk)
    begin
        if (clk'event AND clk='1') then
            if reset = '1' then
            stato_corrente <= INIT;
            else
            stato_corrente <= stato_prossimo;
            end if;
        end if;
end process;
    
end Behavioral;
