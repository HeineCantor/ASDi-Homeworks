----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2023 09:56:51 AM
-- Design Name: 
-- Module Name: demux_1_4_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interconnection_network_tb is
--  Port ( );
end interconnection_network_tb;

architecture Behavioral of interconnection_network_tb is
    component interconnection_network
    port(
        input       : in    std_logic_vector(0 to 15);
        output      : out   std_logic_vector(0 to 3);
        
        inputIndex  : in    std_logic_vector(0 to 3);
        outputIndex : in    std_logic_vector(0 to 1)
    );
    end component;

    signal input            :    std_logic_vector(0 to 15)      := (others => 'U');
    signal inputSelector    :    std_logic_vector(0 to 3)   := (others => 'U');
    signal outputSelector   :    std_logic_vector(0 to 1)   := (others => 'U');
    signal output           :    std_logic_vector(0 to 3)       := (others => 'U');
    
    begin
        uut: interconnection_network
        port map(
            input => input,
            output => output,
            inputIndex => inputSelector,
            outputIndex => outputSelector
        );
        
        stim_proc:process
        begin
        
        wait for 100 ns;
        
        input <= "0101101011000011";
        inputSelector <= "0011";
        outputSelector <= "10";
        
        wait for 10 ns;
        
        inputSelector <= "0010";
        
        wait for 10 ns;
        
        outputSelector <= "01";
        
        wait for 10 ns;
        
        input <= "0111101011000011";
        
        wait for 10 ns;
        
        assert output = "0100"
        report "errore"
        severity failure;

        wait;
        
        end process;


end Behavioral;
