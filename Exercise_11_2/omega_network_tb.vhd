library ieee;
use ieee.std_logic_1164.all;

entity tb_omega_network is
end tb_omega_network;

architecture tb of tb_omega_network is

    component omega_network is
        generic( 
            addressDim: natural := 3;
            dataDim: natural :=2
        );
        port (
            IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7: in STD_LOGIC_VECTOR(1+addressDim+dataDim-1 downto 0);
            OUT0,OUT1,OUT2,OUT3,OUT4,OUT5,OUT6,OUT7: out STD_LOGIC_VECTOR(dataDim-1 downto 0)
        );
    end component;

    signal in0,in1,in2,in3,in4,in5,in6,in7: std_logic_vector (5 downto 0) := (others => '1');
    signal out0,out1,out2,out3,out4,out5,out6,out7: std_logic_vector (1 downto 0) := (others => '0');

begin

    dut : omega_network
    port map (
        in0 => in0,
        in1 => in1,
        in2 => in2,
        in3 => in3,
        in4 => in4,
        in5 => in5,
        in6 => in6,
        in7 => in7,
        out0 => out0,
        out1 => out1,
        out2 => out2,
        out3 => out3,
        out4 => out4,
        out5 => out5,
        out6 => out6,
        out7 => out7
    );

    stimuli : process
    begin
    
        wait for 10 ns;
        
        in0<="111111"; 
        in1<="110101";
        in2<="010000";
        in3<="000110";
        in4<="111111";
        in5<="100010";
        in6<="011111";
        in7<="110000";
        
        wait for 10ns;
       
        wait;
    end process;

end tb;