library ieee;
use ieee.std_logic_1164.all;

entity tb_AB is
end tb_AB;

architecture tb of tb_AB is

    component AB
    generic( M: natural := 8 );
        port( CLK_A    : in std_logic;
              CLK_B    : in std_logic;
              RESET    : in std_logic;
              START    : in std_logic;
              SUM      : out std_logic_vector ((M-1) downto 0);
           
              Xi: out STD_LOGIC_VECTOR((M-1) downto 0);
              Yi: out STD_LOGIC_VECTOR((M-1) downto 0)
              --STOP: out STD_LOGIC
              );
    end component;


    constant VAL_M: natural :=8;

    signal CLK_A    : std_logic;
    signal CLK_B    : std_logic;
    signal RESET    : std_logic;
    signal START    : std_logic;
    signal SUM      : std_logic_vector ((VAL_M-1) downto 0);
    signal Yi       : std_logic_vector ((VAL_M-1) downto 0);
    signal Xi       : std_logic_vector ((VAL_M-1) downto 0);
    --signal STOP     : std_logic;
    constant clk_period_a : time := 12 ns;
    constant clk_period_b : time := 27 ns;
    
begin
   
   -- Clock generation
   clk_process_a : process
   begin
		clk_a <= '0';
		wait for clk_period_a/2;
		clk_a <= '1';
		wait for clk_period_a/2;
   end process;
   
   clk_process_b : process
   begin
		clk_b <= '0';
		wait for clk_period_b/2;
		clk_b <= '1';
		wait for clk_period_b/2;
   end process;

    dut : AB
    generic map( M=> 8 )
    port map (CLK_A    => clk_a,
              CLK_B    => clk_b,
              RESET    => RESET,
              START    => START,
              SUM      => SUM,
              Xi => Xi,
              Yi => Yi
              --STOP => STOP
              );

    stimuli : process
    begin
       
       reset <= '1';
       wait for 30 ns;
       reset <= '0';
       start<='1';
       wait for 30 ns;
       start<='0';
       
       
        wait;
    end process;

end tb;