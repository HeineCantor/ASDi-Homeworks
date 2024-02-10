
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- mi servono log_2(16) selettori

entity mux_16_1 is
    port(   
        b    : in std_logic_vector(0 to 15);
        s    : in std_logic_vector(0 to 3);
        y0   : out std_logic
    );
end mux_16_1;


architecture structural of mux_16_1 is

    signal u : std_logic_vector(0 to 3) := (others => 'U');

    component mux_4_1
        port(   a   : in std_logic_vector(0 to 3);
                z   : in std_logic_vector(0 to 1);
                y   : out std_logic
        );
    end component;

    begin
        mux0: mux_4_1
            Port map(   a => b(0 to 3),
                        z => s(2 to 3),
                        y  => u(0)
            );
        mux1: mux_4_1
            Port map(   a => b(4 to 7),
                        z => s(2 to 3),
                        y  => u(1)
            );
        mux2: mux_4_1
            Port map(   a => b(8 to 11),
                        z => s(2 to 3),
                        y  => u(2)
            );
        mux3: mux_4_1
            Port map(   a => b(12 to 15),
                        z => s(2 to 3),
                        y  => u(3)
            );
        mux4: mux_4_1
            Port map(   a => u(0 to 3),
                        z => s(0 to 1),
                        y  => y0
            );
end structural;







