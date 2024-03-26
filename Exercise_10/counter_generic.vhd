
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;


entity counter is
generic( DIM: integer :=3 );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --enable viene dal divisore di frequenza
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0)); -- COUNTER corrisponde ad ADDRESS
end counter;

architecture Behavioral of counter is

signal c : std_logic_vector ((DIM-1) downto 0) := (others => '0');
begin
counter <= c;

counter_process: process(clock)
begin
    
     if(clock'event AND clock='1') then	  
	   if reset = '1' then
		  c <= (others => '0');
	   elsif enable = '1' then
		  c <= std_logic_vector(unsigned(c) + 1);
	  end if;
	 end if;
end process;

end Behavioral;