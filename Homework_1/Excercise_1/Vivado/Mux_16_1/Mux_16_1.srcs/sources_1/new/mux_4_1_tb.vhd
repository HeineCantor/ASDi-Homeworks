----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/15/2023 10:51:01 AM
-- Design Name: 
-- Module Name: mux_4_1_tb - Behavioral
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

entity mux_4_1_tb is
--  Port ( );
end mux_4_1_tb;

architecture Behavioral of mux_4_1_tb is
    component mux_4_1
    port(       
            a : in STD_LOGIC_VECTOR(0 to 3);
            z : in  STD_LOGIC_VECTOR(0 to 1);
            y  : out STD_LOGIC
    );
    end component;

    signal input :      std_logic_vector(0 to 3)    := (others => 'U');
    signal control :    std_logic_vector(0 to 1)    := (others => 'U');
    signal output :     std_logic                   := 'U';
    
    begin
        uut: mux_4_1
        port map(
            a => input,
            z => control,
            y => output
        );
        
        stim_proc:process
        begin
        
        wait for 100 ns;
        
        input <= "1010";
        control <= "00";
        
        wait for 10 ns;
        
        control <= "01";
        
        wait for 10 ns;
        
        input <= "1110";
        
        wait for 10 ns;
        
        control <= "10";
        
        wait for 10 ns;
        
        input <= "1100";
        
        wait for 10 ns;
        
        control <= "11";
        
        wait for 10 ns;
        
        assert output = '0'
        report "errore"
        severity failure;

        wait;
        
        end process;


end Behavioral;
