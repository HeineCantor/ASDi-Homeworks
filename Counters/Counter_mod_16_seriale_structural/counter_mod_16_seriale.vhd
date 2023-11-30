
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_mod_16_seriale is
  Port (
    C: in std_logic;
    R: in std_logic;
    cont: out std_logic_vector(0 to 3)
  );
end counter_mod_16_seriale;

architecture structural of counter_mod_16_seriale is

    component FF_T is
    Port (
    clk: in std_logic;
    reset: in std_logic;
    Y: out std_logic
    );
    end component;

    signal S1: std_logic;
    signal S2: std_logic;
    signal S3: std_logic;
    signal S4: std_logic;
    
    begin
    ff1: FF_T
    port map(
        clk => C,
        reset => R,
        Y => S1
    );
    ff2: FF_T
    port map(
        clk => S1,
        reset => R,
        Y => S2
    );
    ff3: FF_T
    port map(
        clk => S2,
        reset => R,
        Y => S3
    );
    ff4: FF_T
    port map(
        clk => S3,
        reset => R,
        Y => S4
    );
    
    cont <= S4 & S3 & S2 & S1;
end structural;
