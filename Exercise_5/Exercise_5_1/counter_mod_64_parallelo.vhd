
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_mod_64_parallelo is
  Port (
    C: in std_logic;
    R: in std_logic;
    MAX_CONT: in std_logic;
    SET: in std_logic;
    LOAD: in std_logic_vector(0 to 5);
    cont: out std_logic_vector(0 to 5)
  );
end counter_mod_64_parallelo;


architecture structural of counter_mod_64_parallelo is

component counter_mod_2_parallelo is
  Port (
    C: in std_logic;
    R: in std_logic;
    MAX_CONT: in std_logic;
    SET: in std_logic;
    LOAD: in std_logic_vector(0 to 1);
    cont: out std_logic_vector(0 to 1)
  );
end component;
    
       
    signal S1: std_logic_vector(0 to 1);
    signal S3: std_logic_vector(0 to 1);
    signal S5: std_logic_vector(0 to 1);
    signal Q1: std_logic;
    signal Q3: std_logic;
    
    signal LOAD1: std_logic_vector(0 to 1);
    signal LOAD2: std_logic_vector(0 to 1);
    signal LOAD3: std_logic_vector(0 to 1);
    
    signal reset: std_logic;
    
    begin
    
    -- Necessario inserire "and not(reset)" per un corretto reset dei contatori in cascata
    Q1 <= (S1(0) and S1(1)) and not(reset);
    Q3 <= (S3(0) and S3(1)) and not(reset);
    
    -- reset a 60  --> 11 11 00 (di conseguenza 59)
    reset <= S5(0) and S5(1) and S3(0) and S3(1);
    
    LOAD1 <= LOAD(4) & LOAD(5);
    LOAD2 <= LOAD(2) & LOAD(3);
    LOAD3 <= LOAD(0) & LOAD(1);
    
    count_mod2_1:counter_mod_2_parallelo
    port map(
        C=>C,
        R => R,
        MAX_CONT => reset,
        SET => SET,
        LOAD => LOAD1,
        cont => S1
    );
    
    count_mod2_2:counter_mod_2_parallelo
    port map(
        C=>Q1,
        R => R,
        MAX_CONT => reset,
        SET => SET,
        LOAD => LOAD2,
        cont => S3
    );
    
    count_mod2_3:counter_mod_2_parallelo
    port map(
        C=>Q3,
        R => R,
        MAX_CONT => reset,
        SET => SET,
        LOAD => LOAD3,
        cont => S5
    );
    
    cont <= S5 & S3 & S1;
end structural;
