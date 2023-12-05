library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Riconoscitore_101_TB is
end Riconoscitore_101_TB;

architecture Behavioral of Riconoscitore_101_TB is

COMPONENT Riconoscitore_101
    PORT(
        x: in std_logic;
        A: in std_logic;
        RST: in std_logic;
        M: in std_logic := '0';
        y: out std_logic
    );
END COMPONENT;

   signal x : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal M: std_logic := '0';
   signal test: std_logic_vector (0 to 19) := (others => '0');
    
 	--Outputs
   signal y : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
 
 BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	-- qui specifico quale architecture simulare di quelle definite
   uut: Riconoscitore_101 port map(
          x => x,
          A => CLK,
          RST => RST,
          M => M,
          Y => Y
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
    wait for 100 ns;	
   
   test <= "01001010110111001011";
   
   rst <= '1';
   wait for 1ns;
   rst <= '0';
   
   FOR i in 0 to 19 LOOP
   
    x <= test(i);
    wait for 10 ns;
 
   END LOOP;
  
    wait;
   end process;
   
end;