library ieee;
use ieee.std_logic_1164.all;

entity tb_switch is
end tb_switch;

architecture tb of tb_switch is

    component switch
    generic( DIM: natural :=2);
        port (X1  : in std_logic_vector ((dim-1) downto 0);
              X2  : in std_logic_vector ((dim-1) downto 0);
              Y1  : out std_logic_vector ((dim-1) downto 0);
              Y2  : out std_logic_vector ((dim-1) downto 0);
              src : in std_logic;
              dst : in std_logic);
    end component;

    constant N: natural :=2;
    signal X1  : std_logic_vector ((N-1) downto 0);
    signal X2  : std_logic_vector ((N-1) downto 0);
    signal Y1  : std_logic_vector ((N-1) downto 0);
    signal Y2  : std_logic_vector ((N-1) downto 0);
    signal src : std_logic;
    signal dst : std_logic;

begin

    dut : switch
    port map (X1  => X1,
              X2  => X2,
              Y1  => Y1,
              Y2  => Y2,
              src => src,
              dst => dst);

    stimuli : process
    begin
        X1<="01";
        X2<="10";
        src<='0';
        dst<='0';

        wait;
    end process;

end tb;