library ieee;
use ieee.std_logic_1164.all;

entity tb_omega_network is
end tb_omega_network;

architecture tb of tb_omega_network is

    component omega_network
    generic(DIM: natural :=2);
        port (IN1  : in std_logic_vector (2+(dim-1) downto 0);
              IN2  : in std_logic_vector (2+(dim-1) downto 0);
              IN3  : in std_logic_vector (2+(dim-1) downto 0);
              IN4  : in std_logic_vector (2+(dim-1) downto 0);
              OUT1 : out std_logic_vector ((dim-1) downto 0);
              OUT2 : out std_logic_vector ((dim-1) downto 0);
              OUT3 : out std_logic_vector ((dim-1) downto 0);
              OUT4 : out std_logic_vector ((dim-1) downto 0);
              AB1  : in std_logic;
              AB2  : in std_logic;
              AB3  : in std_logic;
              AB4  : in std_logic);
    end component;

    constant DIM: natural :=2;
    signal IN1  : std_logic_vector (2+(dim-1) downto 0);
    signal IN2  : std_logic_vector (2+(dim-1) downto 0);
    signal IN3  : std_logic_vector (2+(dim-1) downto 0);
    signal IN4  : std_logic_vector (2+(dim-1) downto 0);
    signal OUT1 : std_logic_vector ((dim-1) downto 0);
    signal OUT2 : std_logic_vector ((dim-1) downto 0);
    signal OUT3 : std_logic_vector ((dim-1) downto 0);
    signal OUT4 : std_logic_vector ((dim-1) downto 0);
    signal AB1  : std_logic;
    signal AB2  : std_logic;
    signal AB3  : std_logic;
    signal AB4  : std_logic;

begin

    dut : omega_network
    port map (IN1  => IN1,
              IN2  => IN2,
              IN3  => IN3,
              IN4  => IN4,
              OUT1 => OUT1,
              OUT2 => OUT2,
              OUT3 => OUT3,
              OUT4 => OUT4,
              AB1  => AB1,
              AB2  => AB2,
              AB3  => AB3,
              AB4  => AB4);

    stimuli : process
    begin
    
        wait for 10 ns;
  
        --    DEST DATA
        --     [  |  ]
        IN1 <= "0111";
        IN2 <= "1110";
        IN3 <= "0001";
        IN4 <= "0110";
        
        AB1 <= '1';
        AB2 <= '1';
        AB3 <= '1';
        AB4 <= '1';
        
        wait for 10 ns;
        AB1 <= '0';
        AB2 <= '1';
        AB3 <= '1';
        AB4 <= '1';
        
        wait for 10 ns;
        AB1 <= '0';
        AB2 <= '0';
        AB3 <= '1';
        AB4 <= '1';
        
        wait for 10 ns;
        AB1 <= '0';
        AB2 <= '0';
        AB3 <= '0';
        AB3 <= '0';
        AB4 <= '1';
        
        wait for 10 ns;
        AB1 <= '1';
        AB2 <= '0';
        AB3 <= '0';
        AB3 <= '0';
        AB4 <= '1';
        
        wait for 10 ns;
        AB1 <= '0';
        AB2 <= '1';
        AB3 <= '1';
        AB3 <= '0';
        AB4 <= '0';
       
        wait;
    end process;

end tb;