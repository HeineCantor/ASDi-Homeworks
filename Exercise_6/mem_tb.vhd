
library ieee;
use ieee.std_logic_1164.all;

entity tb_mem is
end tb_mem;

architecture tb of tb_mem is

    component mem
        generic(
            address_length : natural := 4;
            data_length: natural := 4);
            
        port (clock       : in std_logic;
              read        : in std_logic;
              write       : in std_logic;
              address     : in std_logic_vector ((address_length - 1) downto 0);
              data_input  : in std_logic_vector ((data_length - 1) downto 0);
              data_output : out std_logic_vector ((data_length - 1) downto 0));
    end component;


    constant addr_len: natural :=4;
    constant data_len: natural :=4;
    
    signal clk_tb : std_logic;
    signal read        : std_logic;
    signal write       : std_logic;
    signal address     : std_logic_vector ((addr_len - 1) downto 0);
    signal data_input  : std_logic_vector ((data_len - 1) downto 0);
    signal data_output : std_logic_vector ((data_len - 1) downto 0);
    
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

    dut : mem
    GENERIC MAP (address_length => addr_len,
                 data_length =>  data_len)
                 
    port map (clock       => clk_tb,
              read        => read,
              write       => write,
              address     => address,
              data_input  => data_input,
              data_output => data_output);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        --clk_tb <= '0';
        read <= '0';
        write <= '0';
        address <= (others => '0');
        data_input <= (others => '0');
        wait for 10 ns;
        
        -- EDIT Add stimuli here
        address <="0000";
        read <= '1';
        wait for 30 ns;
        read <='0';
        wait for 30 ns;
        
        data_input <= "1010";
        wait for 30 ns;
        write <='1';
        wait for 30 ns;
        write <='0';
        wait for 50 ns;
        
             
        address<="0100";
        data_input <="1111";
        wait for 30 ns;
        write <='1';
        wait for 30 ns;
        write <='0';
        wait for 50 ns;
        
        
        address <="0000";
        read <= '1';
        wait for 30 ns;
        address <="0100";
        read <= '1';
        wait for 30 ns;
        
        wait;
    end process;

end tb;

