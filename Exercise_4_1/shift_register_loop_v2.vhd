
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    generic(
        dim : integer
    );
    port(CLK, RST, SI : in std_logic;
         MODE: in std_logic_vector :="00";
         SO : out std_logic);
end shift_register;

architecture Behavioral of shift_register is
    signal internal_value: std_logic_vector((dim - 1) downto 0);
    signal y: std_logic;
begin

    process (CLK,y,internal_value)
    begin
        if (CLK'event and CLK='1') then
            if (RST='1') then
                internal_value <= (others=>'0');
            else
            
            -- shift a dx
            if (MODE = "00") then
                internal_value(0) <= SI;
                for i in (dim-1) downto 0 + 1 loop
                    internal_value(i) <= internal_value(i-1);
                end loop;    
                y <= internal_value(dim-1);    
             end if;
             
             -- shift a sx
             if (MODE = "01") then
                internal_value(dim-1) <= SI;
                for i in 0+1 to dim-1 loop
                    internal_value(i-1) <= internal_value(i);
                end loop;
                y <= internal_value(0);       
             end if;    
             
             -- shift a dx di 2
             if (MODE = "10") then
                internal_value(0) <= '0';
                internal_value(1) <= SI;
                for i in (dim-1) downto 0 + 2 loop
                    internal_value(i) <= internal_value(i-2);
                end loop;    
                y <= internal_value(dim-1);       
             end if; 
 
            -- shift a sx di 2
             if (MODE = "11") then
                internal_value(dim-1) <= '0';
                internal_value(dim-2) <= SI;
                for i in (dim-2) downto 2 loop
                    internal_value(i-2) <= internal_value(i);
                end loop;      
                y <= internal_value(1);     
             end if;      
             
            end if;
           end if;
 
      end process;

      SO <= y;

end Behavioral;
