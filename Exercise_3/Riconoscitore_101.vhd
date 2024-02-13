
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Riconoscitore_101 is
    Port ( 
        x: in std_logic;
        A: in std_logic;
        clock, reset: in std_logic;
        M: in std_logic := '1';
        y: out std_logic;
        
        debugState: out std_logic_vector(0 to 4)
    );
end Riconoscitore_101;

architecture Behavioral of Riconoscitore_101 is

type stato is (S0, S1, S2, S3, S4);
signal statoCorrente : stato := S0;
signal statoProssimo : stato;

signal yProssima : std_logic := '0';

attribute fsmEncoding : string;
attribute fsmEncoding of statoCorrente : signal is "one_hot";

begin
    stato_uscita: process(statoCorrente, x, M)
    
    begin case statoCorrente is
    
        when s0 =>
            debugState <= "10000";
            if(x='0') then
                if (M='0') then
                    statoProssimo <= s3;
                else
                    statoProssimo <= s0;
                end if;
                yProssima <= '0';
            else
                statoProssimo <= s1;
                yProssima<='0';
            end if;
            
         when s1 =>
         debugState <= "01000";
            if(x='0') then
                statoProssimo <= s2;
                yProssima <= '0';
            else
                if(M='0') then
                    statoProssimo <= s4;
                else
                    statoProssimo <= s1;
                end if;
                yProssima<='0';
            end if;
            
         when s2 =>
         debugState <= "00100";
            if(x='0') then
                statoProssimo <= s0;
                yProssima <= '0';
            else
                statoProssimo <= s0;
                yProssima<='1';
            end if;
              
         when s3 =>
         debugState <= "00010";
            statoProssimo <= s4;
            yProssima <= '0';
            
         when s4 =>
         debugState <= "00001";
            statoProssimo <= s0;
            yProssima <= '0';
    
        when others=>
            debugState <= "10000";
            statoProssimo <= s0;
            yProssima<='0';
        
        end case;
       
    end process;
    
    
    mem: process(clock)
    begin
        if(clock'event and clock='1') then
            if (reset = '1') then
                statoCorrente <= s0;
                y <= '0';
            elsif (A = '1') then 
                statoCorrente <= statoProssimo;
                y <= yProssima;
            end if;
        end if;     
    end process;

end Behavioral;
