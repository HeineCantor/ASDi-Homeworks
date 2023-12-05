----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2023 11:32:35
-- Design Name: 
-- Module Name: rom_tb - Behavioral
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
--use work.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rom_tb is
end rom_tb;

architecture Behavioral of rom_tb is
    component ROM
    port(
    address : in std_logic_vector(3 downto 0);
    dout : out std_logic_vector(7 downto 0)
    );
    end component;
    
    signal input   : STD_LOGIC_VECTOR (3 downto 0)    := (others => '0');
    signal output  : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');


begin

    uut : ROM
    port map(
        address => input,
        dout => output
    );
    
 
    stim_proc : process
    begin
        wait for 100 ns;
    
        input <= "0000";
        wait for 10 ns;
    
        input <= "1111";
        wait for 10 ns;
        wait;
end process;
    
end;
    
    
    
