library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity mux_16_1_tb is
end mux_16_1_tb;

architecture behavioral of mux_16_1_tb is

    component mux_16_1
        port(   
            b    : in std_logic_vector(0 to 15);
            s    : in std_logic_vector(0 to 3);
            y0   : out std_logic
        );
    end component;

    signal input    : STD_LOGIC_VECTOR (0 to 15)    := (others => 'U');
    signal control  : STD_LOGIC_VECTOR (0 to 3) := (others => 'U');
    signal output   : STD_LOGIC                      := '0';
begin

    uut : mux_16_1
    port map (  b => input,
                s => control,
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
