----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2023 18:24:29
-- Design Name: 
-- Module Name: sistema_tb - Behavioral
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

entity sistema_tb is
end sistema_tb;

architecture Behavioral of sistema_tb is

    component S port(
        a : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(3 downto 0) );
    end component S;
   
    signal data_in    : STD_LOGIC_VECTOR (0 to 3)    := (others => '0');
    signal data_out  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin
    uut: S
    port map(
        a => data_in,
        y => data_out
    );

   stim_proc : process
    begin
    
       wait for 100 ns;
       
       data_in    <= "0000";
       wait for 10 ns;

       data_in    <= "1111";
       wait for 10 ns;
               
        wait;
    end process;

end;
