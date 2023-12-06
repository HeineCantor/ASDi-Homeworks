
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Riconoscitore_101 is
    Port ( 
        x: in std_logic;
        A: in std_logic;
        RST: in std_logic;
        M: in std_logic := '1';
        y: out std_logic;
        
        debugState: out std_logic_vector(0 to 4)
    );
end Riconoscitore_101;

architecture Behavioral of Riconoscitore_101 is

type stato is (S0, S1, S2, S3, S4);
signal stato_corrente : stato := S0;
signal stato_prossimo : stato;

signal y_prossima : std_logic := '0';

attribute fsm_encoding : string;
attribute fsm_encoding of stato_corrente : signal is "one_hot";

begin
    stato_uscita: process(stato_corrente, x, M)
    
    begin case stato_corrente is
    
    when s0 =>
        debugState <= "10000";
        if(x='0') then
            if (M='0') then
                stato_prossimo <= s3;
            else
                stato_prossimo <= s0;
            end if;
            y_prossima <= '0';
        else
            stato_prossimo <= s1;
            y_prossima<='0';
        end if;
        
     when s1 =>
     debugState <= "01000";
        if(x='0') then
            stato_prossimo <= s2;
            y_prossima <= '0';
        else
            if(M='0') then
                stato_prossimo <= s4;
            else
                stato_prossimo <= s1;
            end if;
            y_prossima<='0';
        end if;
        
     when s2 =>
     debugState <= "00100";
        if(x='0') then
            stato_prossimo <= s0;
            y_prossima <= '0';
        else
            stato_prossimo <= s0;
            y_prossima<='1';
        end if;
          
     when s3 =>
     debugState <= "00010";
        stato_prossimo <= s4;
        y_prossima <= '0';
        
     when s4 =>
     debugState <= "00001";
        stato_prossimo <= s0;
        y_prossima <= '0';

    when others=>
        debugState <= "10000";
        stato_prossimo <= s0;
        y_prossima<='0';
    
    end case;
   
end process;
    
    
mem: process(A, RST)
begin
    if (RST='1') then
        stato_corrente<= s0;
        y<='0';
    elsif rising_edge(A) then
        stato_corrente <= stato_prossimo;
        y <= y_prossima;
     end if;
end process;
    
    

end Behavioral;
