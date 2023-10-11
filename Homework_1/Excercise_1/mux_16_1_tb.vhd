library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity mux_16_1_tb is
end mux_16_1_tb;

architecture behavioral of mux_16_1_tb is

    component mux_16_1
        port (b0  : in std_logic;
              b1  : in std_logic;
              b2  : in std_logic;
              b3  : in std_logic;
              b4  : in std_logic;
              b5  : in std_logic;
              b6  : in std_logic;
              b7  : in std_logic;
              b8  : in std_logic;
              b9  : in std_logic;
              b10 : in std_logic;
              b11 : in std_logic;
              b12 : in std_logic;
              b13 : in std_logic;
              b14 : in std_logic;
              b15 : in std_logic;
              s0  : in std_logic;
              s1  : in std_logic;
              s2  : in std_logic;
              s3  : in std_logic;
              y0   : out std_logic);
    end component;

    signal input    : STD_LOGIC_VECTOR (0 to 15)    := (others => '0');
    signal control  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal output   :STD_LOGIC                      := '0';
begin

    uut : mux_16_1
    port map (  b0  => input(0),
                b1  => input(1),
                b2  => input(2),
                b3  => input(3),
                b4  => input(4),
                b5  => input(5),
                b6  => input(6),
                b7  => input(7),
                b8  => input(8),
                b9  => input(9),
                b10 => input(10),
                b11 => input(11),
                b12 => input(12),
                b13 => input(13),
                b14 => input(14),
                b15 => input(15),
                s0  => control(0),
                s1  => control(1),
                s2  => control(2),
                s3  => control(3),
                y0   => output
            );

    stim_proc : process
    begin
        
        wait for 100 ns;

        --input = b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15
        --control = s3 s2 s1 s0

       input    <= "1011010010111011";
       control  <= "1111";
       wait for 10 ns; --b15 in uscita

       control <= "0000";
       wait for 10 ns; --b0 in uscita

        assert output = '1'
        report "errore"
        severity failure;

        wait;
    end process;

end;
