library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
generic( DIM: integer :=6 );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
		   maxCount: in std_logic_vector(dim-1 downto 0);
		   set: in STD_LOGIC;
		   loadValue: in STD_LOGIC_VECTOR ((DIM-1) downto 0);
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0);
           overflow: out std_logic
           ); 
end counter;

architecture Behavioral of counter is

    signal c : std_logic_vector ((DIM-1) downto 0) := (others => '0');
    signal counted: std_logic := '0';
    
begin


counter_process: process(clock, reset, set)
begin
     if reset = '1' then
		  c <= (others => '0');
     elsif set='1' then
	       c<=loadValue;
     elsif(rising_edge(clock)) then
        counted <= '0';
     
	   if enable = '1' then
	      if (c = maxCount) then
	           c <= (others => '0');
	           counted <= '1';
	      else
		      c <= std_logic_vector(unsigned(c) + 1);
		  end if;
	   end if;
	 end if;
end process;

counter <= c;
overflow <= counted;

end Behavioral;
