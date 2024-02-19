
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    port(
        start: in STD_LOGIC;
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
type stato is (INIT, STOP_STATE, EN_COUNT, READ_ROM, ROM_TO_M, M_TO_RAM, PRINT);

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
--            en <= '0';
--            read <= '0';
--            read_ram <= '0';
--            write <= '0';
--            stop <= '0';
           
    
            if(start = '1') then
                stato_prossimo <= READ_ROM;
            else
                stato_prossimo <= INIT;
            end if;
        
        when STOP_STATE =>
        
            stop <= '1';
            --stato_prossimo <= STOP_STATE;

            
        when EN_COUNT =>
        
          if address="111" then
                --stop <= '1';
                stato_prossimo <= STOP_STATE;
          else
            en <= '1';
            --read <= '1';
            stato_prossimo <= READ_ROM;
          end if;
          
        when READ_ROM => 
            --en <= '0';
            read <= '1';
            stato_prossimo <= M_TO_RAM;
      
            
--        when ROM_TO_M =>
--            en <= '0';
--            read <= '0';
--            stato_prossimo <= M_TO_RAM;
        
        when M_TO_RAM =>
            write <= '1';
            stato_prossimo <= PRINT;
            
        when PRINT =>
            --write <= '0';
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
