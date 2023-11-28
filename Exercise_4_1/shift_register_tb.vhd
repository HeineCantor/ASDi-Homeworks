library ieee;
use ieee.std_logic_1164.all;

entity shift_register_tb is
end shift_register_tb;

architecture tb of shift_register_tb is

    component shift_register
        generic(
        dim : integer
        );
        port (CLK : in std_logic;
              RST : in std_logic;
              MODE: in std_logic_vector;
              SI  : in std_logic;
              SO  : out std_logic);
    end component;

    signal clk_tb : std_logic;
    signal input  : std_logic :='0';
    signal output  : std_logic;
    signal rst : std_logic;
    signal mode: std_logic_vector (0 to 1) := (others => '0');

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
   
   
   
    uut : shift_register
    GENERIC MAP (dim => 8)
    port map (CLK => clk_tb,
              RST => rst,
              MODE => mode,
              SI  => input,
              SO  => output);
              

    stimuli : process
    begin
        
        rst <= '1';
        mode <="10";
        wait for 100ns;  --global reset
       
        rst <='0';
        input <= '1';
        wait for 100ns;
        input <= '0';
        wait for 100ns;
        input <= '1';
        
        -- EDIT Add stimuli here
        --wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
       -- TbSimEnded <= '1';
        wait;
    end process;

end tb;
