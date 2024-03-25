library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ButtonDebouncer is
    generic (                       
        CLK_period: integer := 10;  
        btn_noise_time: integer := 10000000 
                                            
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
end ButtonDebouncer;

architecture Behavioral of ButtonDebouncer is

type stato is (NOT_PRESSED, CHK_PRESSED, PRESSED, CHK_NOT_PRESSED);
signal BTN_state : stato := NOT_PRESSED;

constant max_count : integer := btn_noise_time/CLK_period; 

begin

deb: process (CLK)
variable count: integer := 0;

begin
   if rising_edge(CLK) then
	   
	   if( RST = '1') then
	       BTN_state <= NOT_PRESSED;
	       CLEARED_BTN <= '0';
	   else
	   	  case BTN_state is
			when NOT_PRESSED =>
			    if( BTN = '1' ) then
					BTN_state <= CHK_PRESSED;
				else 
					BTN_state <= NOT_PRESSED;
				end if;
            when CHK_PRESSED =>
                if(count = max_count -1) then
                    if(BTN = '1') then 
                        count:=0;
                        CLEARED_BTN <= '1';
                        BTN_state <= PRESSED;
                    else
                        count:=0;
                        BTN_state <= NOT_PRESSED;
                    end if;
                        
                else 
                    count:= count+1;
                    BTN_state <= CHK_PRESSED;
                end if;
                
            when PRESSED =>
                CLEARED_BTN<= '0';
			     
			    if(BTN = '0') then
				    BTN_state <= CHK_NOT_PRESSED;
				else
				    BTN_state <= PRESSED;
				end if;
			
			when CHK_NOT_PRESSED =>
			    if(count = max_count -1) then
                    if(BTN = '0') then 
                        count:=0;
                        BTN_state <= NOT_PRESSED;
                    else
                        count:=0;
                        BTN_state <= PRESSED;
                    end if;
                        
                else 
                    count:= count+1;
                    BTN_state <= CHK_NOT_PRESSED;
                end if;
                
            when others => 
                BTN_state <= NOT_PRESSED;
		  end case;
    end if;  
  end if;  
end process;


end Behavioral;
