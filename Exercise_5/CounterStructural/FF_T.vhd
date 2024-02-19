
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_T is
  Port (
    clk: in std_logic;
    reset: in std_logic;
    set: in std_logic;
    load: in std_logic;
    Y: out std_logic
  );
end FF_T;

architecture Behavioral of FF_T is

    signal TY: std_logic:='0';
    
begin
    ff: process(clk,reset,set,load)
    begin
        if(reset='1') then
            TY<='0';
        elsif(set='1') then
            TY <= load;     
        -- fronte di discesa    
        elsif(clk'EVENT AND clk='0') then         
            TY<=not TY;        
        end if;
    end process;
    
 Y<=TY;
 
end Behavioral;
