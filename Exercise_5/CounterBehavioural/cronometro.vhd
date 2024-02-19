
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cronometro is
  Port (
        C: in std_logic;
        R: in std_logic;
        SET: in std_logic;
        EN: in std_logic;
        LOAD_HOUR: in std_logic_vector(0 to 5);
        LOAD_MIN: in std_logic_vector(0 to 5);
        LOAD_SEC: in std_logic_vector(0 to 5);
        HOUR: out std_logic_vector(0 to 5);
        MIN: out std_logic_vector(0 to 5);
        SEC: out std_logic_vector(0 to 5)
        );
end cronometro;

architecture Structural of cronometro is

component counter is
generic( DIM: integer :=6 );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC;
		   set: in STD_LOGIC;
		   load: in STD_LOGIC_VECTOR ((DIM-1) downto 0);
           counter : out  STD_LOGIC_VECTOR ((DIM-1) downto 0));
end component;

signal S1: std_logic_vector(0 to 5);
signal S2: std_logic_vector(0 to 5);
signal S3: std_logic_vector(0 to 5);

signal Q1: std_logic;
signal Q2: std_logic;
signal reset: std_logic;

begin

Q1 <= C and (S1(0) and S1(1) and S1(2) and (S1(3)) and not(S1(4)) and not(S1(5)));
Q2 <= C and (S1(0) and S1(1) and S1(2) and (S1(3)) and not(S1(4)) and not(S1(5))) and (S2(0) and S2(1) and S2(2) and not(S2(3)) and (S2(4)) and (S2(5)));

    count_mod64_1: counter
    port map(
    clock => C,
    reset => R,
	enable => EN,
	set => SET,
	load => LOAD_SEC,
    counter => S1
    );
    
    count_mod64_2: counter
    port map(
    clock => Q1,
    reset => R,
	enable => EN,
	set => SET,
	load => LOAD_MIN,
    counter => S2
    );
    
    count_mod64_3: counter
    port map(
    clock => Q2,
    reset => R,
	enable => EN,
    set => SET,
	load => LOAD_HOUR,
    counter => S3
    );

HOUR <= S3;
MIN <= S2;
SEC <= S1;


end Structural;
