library ieee;
use ieee.std_logic_1164.all;

entity tb_control_unit is
end tb_control_unit;

architecture tb of tb_control_unit is

    component control_unit
    generic(DIM: natural :=2);
        port (en1 : in std_logic;
              en2 : in std_logic;
              en3 : in std_logic;
              en4 : in std_logic;
              in1 : in std_logic_vector (2+(dim-1) downto 0);
              in2 : in std_logic_vector (2+(dim-1) downto 0);
              in3 : in std_logic_vector (2+(dim-1) downto 0);
              in4 : in std_logic_vector (2+(dim-1) downto 0);
              src : out std_logic_vector (1 downto 0);
              dst : out std_logic_vector (1 downto 0));
    end component;

    constant DIM: natural :=2;
    signal en1 : std_logic;
    signal en2 : std_logic;
    signal en3 : std_logic;
    signal en4 : std_logic;
    signal in1 : std_logic_vector (2+(dim-1) downto 0);
    signal in2 : std_logic_vector (2+(dim-1) downto 0);
    signal in3 : std_logic_vector (2+(dim-1) downto 0);
    signal in4 : std_logic_vector (2+(dim-1) downto 0);
    signal src : std_logic_vector (1 downto 0);
    signal dst : std_logic_vector (1 downto 0);

begin

    dut : control_unit
    port map (en1 => en1,
              en2 => en2,
              en3 => en3,
              en4 => en4,
              in1 => in1,
              in2 => in2,
              in3 => in3,
              in4 => in4,
              src => src,
              dst => dst);

    stimuli : process
    begin
    
    
        en1<='0';
        en2<='1';
        en3<='0';
        en4<='0';
        
        in1 <= "0111";
        in2 <= "1110";
        in3 <= "0001";
        in4 <= "0100";

        wait;
    end process;

end tb;
