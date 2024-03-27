library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simpleInterconnection_tb is
--  Port ( );
end simpleInterconnection_tb;

architecture Behavioral of simpleInterconnection_tb is

    component simpleInterconnection4to4 is
        generic(
            dataWidth : natural := 2
        );
        port(
            input0, input1, input2, input3: in std_logic_vector(dataWidth-1 downto 0);
            selectorTx, selectorRx: in std_logic_vector(1 downto 0);
            output0, output1, output2, output3: out std_logic_vector(dataWidth-1 downto 0)
        );
    end component;

    signal input0, input1, input2, input3, output0, output1, output2, output3: std_logic_vector(1 downto 0);
    signal selector1, selector2: std_logic_vector(1 downto 0);

begin

    dut : simpleInterconnection4to4
    port map ( input0, input1, input2, input3, selector1, selector2, output0, output1, output2, output3 );

    stimuli : process
    begin
    
        wait for 10 ns;
  
        input0 <= "10";
        input1 <= "11";
        input2 <= "01";
        input3 <= "11";
        
        wait for 10ns;
        
        selector1 <= "00";
        selector2 <= "11";
       
        wait for 10ns;
        
        selector2 <= "01";
       
        wait;
    end process;

end Behavioral;
