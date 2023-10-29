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

entity demux_1_4_tb is
--  Port ( );
end demux_1_4_tb;

architecture Behavioral of demux_1_4_tb is
    component demux_1_4
    port(       
                a : in STD_LOGIC;
                z : in  STD_LOGIC_VECTOR(0 to 1);
                y  : out STD_LOGIC_VECTOR(0 to 3)
        );
    end component;

    signal input :      std_logic                   := 'U';
    signal control :    std_logic_vector(0 to 1)    := (others => 'U');
    signal output :     std_logic_vector(0 to 3)    := (others => 'U');
    
    begin
        uut: demux_1_4
        port map(
            a => input,
            z => control,
            y => output
        );
        
        stim_proc:process
        begin
        
        wait for 100 ns;
        
        input <= '1';
        control <= "00";
        
        wait for 10 ns;
        
        control <= "01";
        
        wait for 10 ns;
        
        control <= "10";
        
        wait for 10 ns;
        
        control <= "11";
        
        wait for 10 ns;
        
        assert output = "00"
        report "errore"
        severity failure;

        wait;
        
        end process;


end Behavioral;
