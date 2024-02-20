library ieee;
use ieee.std_logic_1164.all;

entity shift_register_tb is
end shift_register_tb;

architecture tb of shift_register_tb is

    component SR
        generic (N: natural range 0 to 32 := 8);
        port (CLOCK : in std_logic;
              RST : in std_logic;
              MODE: in std_logic_vector;
              D  : in std_logic;
              Q  : out std_logic_vector);
    end component;

    constant N: natural :=8;
    signal clk_tb : std_logic;
    signal input  : std_logic :='0';
    signal output : std_logic_vector ((N-1) downto 0);
    signal rst : std_logic;
    signal mode: std_logic_vector (1 downto 0) := (others => '0');

    constant clk_period : time := 20 ns; 
    

begin
    -- Clock generation
   clk_process : process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;
   
   
    uut : SR
    GENERIC MAP (N => 8)
    port map (CLOCK => clk_tb,
              RST => rst,
              MODE => mode,
              D  => input,
              Q  => output(N-1 downto 0));
              
    stimuli : process
    begin
        
        rst <= '1';
        mode <="00";
        wait for 50ns;
        rst <='0';      
        
        input <= '1';
        wait for 60ns;
        input <= '0';
        wait for 60ns;
        input <= '1';
        wait for 30ns;
        
        rst <= '1';
        mode <="01";
        wait for 50ns;
        rst <='0';
        
        input <= '1';
        wait for 60ns;
        input <= '0';
        wait for 60ns;
        input <= '1';
        wait for 30ns;
        
        rst <= '1';
        mode <="10";
        wait for 50ns;
        rst <='0';
        
        input <= '1';
        wait for 60ns;
        input <= '0';
        wait for 60ns;
        input <= '1';
        wait for 30ns;
        
        
        rst <= '1';
        mode <="11";
        wait for 50ns;
        rst <='0';
        
        input <= '1';
        wait for 60ns;
        input <= '0';
        wait for 60ns;
        input <= '1';
        wait for 30ns;
        
        wait;
    end process;

end tb;
