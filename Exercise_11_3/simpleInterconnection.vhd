library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simpleInterconnection4to4 is
    generic(
        dataWidth : natural := 2
    );
    port(
        input0, input1, input2, input3: in std_logic_vector(dataWidth-1 downto 0);
        selectorTx, selectorRx: in std_logic_vector(1 downto 0);
        output0, output1, output2, output3: out std_logic_vector(dataWidth-1 downto 0)
    );
end simpleInterconnection4to4;

architecture behavioral of simpleInterconnection4to4 is

    signal inputSelection: std_logic_vector(dataWidth-1 downto 0);

begin

    inputSelection <=   input0 when selectorTx="00" else
                        input1 when selectorTx="01" else
                        input2 when selectorTx="10" else
                        input3 when selectorTx="11" else
                        (others => '-');
                        
    output0 <=          inputSelection when selectorRx="00" else
                        "00";
                        
    output1 <=          inputSelection when selectorRx="01" else
                        "00";
                        
    output2 <=          inputSelection when selectorRx="10" else
                        "00";
                        
    output3 <=          inputSelection when selectorRx="11" else
                        "00";     
                    
end behavioral;
