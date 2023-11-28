library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FF_D is
    port(
        d, clk: in std_logic;
        q: out std_logic
    );
end FF_D;


architecture behav of FF_D is
begin
    process(clk)
    begin
        if(clk'event and clk='1') then
            q <= d;
        end if;
     end process;
end behav;