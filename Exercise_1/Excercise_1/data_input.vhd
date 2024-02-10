----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2023 10:44:52 AM
-- Design Name: 
-- Module Name: data_input - Behavioral
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

entity data_input is
    port
    (
        clock   : in std_logic;
        
        data8bit    : in std_logic_vector(7 downto 0);          
        outputData  : out std_logic_vector(15 downto 0) := (others => '0');
        
        notifyLeft  : out std_logic;
        notifyRight : out std_logic;
        
        buttonL     : in std_logic;
        buttonR     : in std_logic
    );
end data_input;

architecture Behavioral of data_input is
    begin
    main : process(clock)
    
    begin
    
    notifyLeft <= buttonL;
    notifyRight <= buttonR;
    
    -- not the best but ok
    if(rising_edge(clock)) then
        if(buttonL = '1') then
            outputData(7 downto 0) <= data8bit;
        end if;
        
        if(buttonR = '1') then
            outputData(15 downto 8) <= data8bit;
        end if;
    end if;
    
    end process;

end Behavioral;
