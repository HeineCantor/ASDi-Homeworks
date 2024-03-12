
library ieee;
use ieee.std_logic_1164.all;

entity tb_UART_SYSTEM is
end tb_UART_SYSTEM;

architecture tb of tb_UART_SYSTEM is

    component UART_SYSTEM
        port (CLK      : in std_logic;
              RESET    : in std_logic;
              START    : in std_logic;
              EN_WR, EN_RD: in STD_LOGIC;
              
              DATA_IN  : out std_logic_vector (7 downto 0);
              DATA_OUT : out std_logic_vector (7 downto 0);
              PE       : out std_logic;
              FE       : out std_logic;
              OE       : out std_logic;
              WR       : out std_logic;
              TY      : out std_logic;
              EN_COUNT     : out std_logic);
    end component;

    
    signal RESET    : std_logic;
    signal START    : std_logic;
    signal PAR      : std_logic;
    signal DATA_IN  : std_logic_vector (7 downto 0);
    signal DATA_OUT : std_logic_vector (7 downto 0);
    signal PE       : std_logic;
    signal FE       : std_logic;
    signal OE       : std_logic;
    signal WR       : std_logic;
    signal TY      : std_logic;
    signal EN_COUNT, EN_WR, EN_RD     : std_logic;

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
    port map (CLK      => clk_tb,
              RESET    => RESET,
              START    => START,
              EN_WR => EN_WR,
              EN_RD => EN_RD,
              
              DATA_IN  => DATA_IN,
              DATA_OUT => DATA_OUT,
              PE       => PE,
              FE       => FE,
              OE       => OE,
              WR       => WR,
              TY      => TY,
              EN_COUNT     => EN_COUNT);

    stimuli : process
    begin
    
       reset <= '1';
       wait for 100 ns;
       reset <= '0';
       wait for 10 ns;
       
       start<='1';
       en_wr <= '1';
       wait for 80 ns;  
       en_wr <= '1';
       wait for 20ns;
       en_wr <= '0';

       wait for 1500us;  
       en_wr <= '1';
       wait for 20ns;
       en_wr <= '0';


        wait;
    end process;

end tb;