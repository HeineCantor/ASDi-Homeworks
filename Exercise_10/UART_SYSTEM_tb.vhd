
library ieee;
use ieee.std_logic_1164.all;

entity tb_UART_SYSTEM is
end tb_UART_SYSTEM;

architecture tb of tb_UART_SYSTEM is

    component UART_SYSTEM
    generic( M: natural := 8 );
        port (CLK      : in std_logic;
              RESET    : in std_logic;
              START    : in std_logic;
              
              DATA_IN  : out std_logic_vector (M-1 downto 0);
              DATA_OUT : out std_logic_vector (M-1 downto 0);
              PE       : out std_logic;
              FE       : out std_logic;
              OE       : out std_logic
        );
    end component;

    
    signal RESET    : std_logic;
    signal START    : std_logic;
    signal DATA_IN  : std_logic_vector (7 downto 0);
    signal DATA_OUT : std_logic_vector (7 downto 0);
    signal PE       : std_logic;
    signal FE       : std_logic;
    signal OE       : std_logic;


    signal clk_tb: STD_LOGIC;
    constant clk_period : time := 20 ns;
    
    
begin

   -- Clock generation
   clk_process_a : process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;

    dut : UART_SYSTEM
    generic map( M=>8 )
    port map (CLK      => clk_tb,
              RESET    => RESET,
              START    => START,
              
              DATA_IN  => DATA_IN,
              DATA_OUT => DATA_OUT,
              PE       => PE,
              FE       => FE,
              OE       => OE
              );

    stimuli : process
    begin
    
       reset <= '1';
       wait for 100 ns;
       reset <= '0';
       wait for 10 ns;
       
       start<='1';
       wait for 30 ns;
       start<='0';

        wait;
    end process;

end tb;