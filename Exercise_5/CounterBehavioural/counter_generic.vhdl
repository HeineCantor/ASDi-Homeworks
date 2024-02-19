
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;


entity counter is
generic( DIM: integer :=6 );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
		   set: in STD_LOGIC;
		   load: in STD_LOGIC_VECTOR ((DIM-1) downto 0);
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0)
           ); 
end counter;

architecture Behavioral of counter is

signal c : std_logic_vector ((DIM-1) downto 0) := (others => '0');

begin
counter <= c;

counter_process: process(clock, reset, set, c)
begin
    
     if reset = '1' then
		  c <= (others => '0');
	 elsif c="111100" then
        c<=(others => '0');
     elsif set='1' then
	       c<=load;
     elsif(clock'event AND clock='1') then
	   if enable = '1' then
		  c <= std_logic_vector(unsigned(c) + 1);
	   end if;
	 end if;

end process;

end Behavioral;
