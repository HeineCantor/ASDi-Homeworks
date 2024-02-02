
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_mod_2_parallelo is
  Port (
    C: in std_logic;
    R: in std_logic;
    MAX_CONT: in std_logic;
    SET: in std_logic;
    LOAD: in std_logic_vector(0 to 1);
    cont: out std_logic_vector(0 to 1)
  );
end counter_mod_2_parallelo;

architecture structural of counter_mod_2_parallelo is

    component FF_T is
    Port (
    clk: in std_logic;
    reset: in std_logic;
    max: in std_logic;
    set: in std_logic;
    load: in std_logic;
    Y: out std_logic
    );
    end component;
    

    signal S0: std_logic;
    signal S1: std_logic; 
    signal Q0: std_logic;

        
    begin
    
    -- segnale utilizzato come AND (del progetto contatore parallelo)
    Q0 <= C and S0;
    
    ff1: FF_T
    port map(
        clk => C,
        reset => R,
        max => MAX_CONT,
        set => SET,
        load => LOAD(1),
        Y => S0
    );
    
    ff2: FF_T
    port map(
        clk => Q0,
        reset => R,
        max =>MAX_CONT,
        set => SET,
        load => LOAD(0),
        Y => S1
    );


    cont <= S1 & S0;
end structural;
