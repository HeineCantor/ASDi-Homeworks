library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SR is
    generic (N: natural range 0 to 32 := 8);
    port(
        D: in std_logic;
        clock, rst: in std_logic;
        MODE: in std_logic_vector(1 downto 0);
        Q: out std_logic_vector(N-1 downto 0)
    );
end SR;


architecture struct of SR is

    component myFF_D is
    port(
        d, clk: in std_logic;
        q: out std_logic
    );
    end component;
    
    
    component mux_4_1 is
    port(   a : in STD_LOGIC_VECTOR(0 to 3);
            z : in  STD_LOGIC_VECTOR(0 to 1);
            y  : out STD_LOGIC
    );
    end component;
    
    
    
    signal data_out: std_logic_vector(0 to N-1);
    signal f_out: std_logic_vector(0 to N);
    
begin
    FF_D_0_TO_N: for i in 1 to N-1 generate
        FF_D_0: myFF_D port map(
        d => data_out(i),
        clk => clock,
        q => f_out(i)
        );
    end generate;

    MUX_0_TO_N_2: for i in 0 to N-1 generate
    IF_CLAUSE: if i=0 generate
        MUX_0: mux_4_1 port map(
            a(0)=> data_out(0),
            a(1)=> f_out(2),
            a(2)=> data_out(0),
            a(3)=> f_out(3),
            z=> MODE,
            y=> data_out(1)
        );
    end generate IF_CLAUSE;
    
    ELSE_CLAUSE_1: if i = 1 generate
        MUX_1: mux_4_1 port map(
            a(0)=> f_out(1),
            a(1)=> f_out(3),
            a(2)=> data_out(0),
            a(3)=> f_out(4),
            z=> MODE,
            y=> data_out(2)
        );
    end generate ELSE_CLAUSE_1;
    
    
    MUX_GENERAL: for i in 2 to N-3 generate
        MUX_GENERAL: mux_4_1 port map(
            a(0)=> f_out(i-1),
            a(1)=> f_out(i+1),
            a(2)=> f_out(i-2),
            a(3)=> f_out(i+2),
            z=> MODE,
            y=> data_out(i)
        );
        end generate MUX_GENERAL;
    
   
    ELSE_CLAUSE_2: if i = (N-2) generate
    MUX_N_2: mux_4_1 port map(
            a(0)=> f_out(N-3),
            a(1)=> f_out(N-1),
            a(2)=> f_out(N-4),
            a(3)=> data_out(0),
            z=> MODE,
            y=> data_out(2)
        );
    end generate ELSE_CLAUSE_2;
    
    ELSE_CLAUSE_3: if i = (N-1) generate
    MUX_N_1: mux_4_1 port map(
            a(0)=> f_out(N-2),
            a(1)=> data_out(0),
            a(2)=> f_out(N-3),
            a(3)=> data_out(0),
            z=> MODE,
            y=> data_out(2)
        );
    end generate ELSE_CLAUSE_3;
    
    
    
    end generate;
    
    Q <= f_out(1 to N);

end struct;






