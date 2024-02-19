
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
    
    -- segnali utilizzati come AND del progetto contatore
    -- vedere figura del progetto parallelo per capire
    signal Q0: std_logic;

    --signal set: std_logic;
    --signal load: std_logic_vector(0 to 1);
    --signal reset_cont: std_logic;
        
    begin
    
    --reset_cont <= S0 and S1 and S2 and S3;
    
    -- definizione simil AND port
    -- per implementazione parallela
    
    --**************************ATTENZIONE*****************************
    --********Vedere se funziona aggiungendo il reset alle AND (non credo serva pi�)*********
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
