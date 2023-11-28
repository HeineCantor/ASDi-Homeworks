
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    generic(
        dim : integer
    );
    port(CLK, RST, SI : in std_logic;
         MODE: in std_logic_vector :="00";
         SO : out std_logic);
end shift_register;

architecture archi of shift_register is
    signal tmp: std_logic_vector((dim - 2) downto 0);
    signal y: std_logic;
begin

    process (CLK,y,tmp)
    begin
        if (CLK'event and CLK='1') then
            if (RST='1') then
                tmp <= (others=>'0');
            else
            
            -- shift a dx
            if (MODE = "00") then
                tmp(0) <= SI;
                for i in (dim-2) downto 0 + 1 loop
                    tmp(i) <= tmp(i-1);
                end loop;    
                y <= tmp(dim-2);     
             end if;
             
             -- shift a sx
             if (MODE = "01") then
                tmp(dim-2) <= SI;
                for i in 0+1 to dim-2 loop
                    tmp(i-1) <= tmp(i);
                end loop;
                y <= tmp(0);       
             end if;    
             
             -- shift a dx di 2
             if (MODE = "10") then
                tmp(0) <= '0';
                tmp(1) <= SI;
                for i in (dim-2) downto 0 + 2 loop
                    tmp(i) <= tmp(i-2);
                end loop;    
                y <= tmp(dim-3);       
             end if; 
 
            -- shift a sx di 2
             if (MODE = "11") then
                tmp(dim-2) <= '0';
                tmp(dim-3) <= SI;
                for i in (dim-3) downto 2 loop
                    tmp(i-2) <= tmp(i);
                end loop;      
                y <= tmp(1);     
             end if;      
             
            end if;
        end if;

      end process;

      SO <= y;

end archi;
