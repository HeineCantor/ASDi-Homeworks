
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
    generic(
        activation_ms : integer
    );
  Port (    clk: in std_logic;
            button: in std_logic;
            pressed: out std_logic     
   );
end debouncer;

architecture Behavioral of debouncer is

begin
   clk_process : process(clk, button)
   variable clkDiv: std_logic := '0';
   variable div: integer := 100;
   
   variable counter : integer := 0;
   
   variable btnCounter : integer := 0;
   
   variable maxCountForButton : integer := activation_ms * 1000; -- milliseconds for activation in ns
   
   begin
    if(rising_edge(clk)) then
        counter := counter + 1;
    end if;
    clkDiv := '0';
    
    if(counter = div+1) then
        counter := 0;
        clkDiv := '1';
    end if;
    
    if(clkDiv = '1') then
        if(button = '1') then
            btnCounter := btnCounter + 1;   -- TODO: handle integer overflow (non tenere premuto il bottone :>)
        else
            btnCounter := 0;
        end if;
    
        if (btnCounter > maxCountForButton) then
            pressed <= '1';
        else
            pressed <= '0';
        end if;
    end if;
    
   end process;


end Behavioral;
