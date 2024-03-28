----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2024 07:03:14 PM
-- Design Name: 
-- Module Name: comSystem_tb - structural
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

entity comSystem_tb is
--  Port ( );
end comSystem_tb;

architecture structural of comSystem_tb is
    component comSystem is
        port(
            clock, reset: in std_logic;
            inData0, inData1, inData2, inData3: in std_logic_vector(1 downto 0);
            address0, address1, address2, address3: in std_logic_vector(1 downto 0);
            enable0, enable1, enable2, enable3: in std_logic;
            
            outData0, outData1, outData2, outData3: out std_logic_vector(1 downto 0)
        );
    end component;
    
    signal clock, reset: std_logic;
    
    signal inData0, inData1, inData2, inData3: std_logic_vector(1 downto 0);
    signal address0, address1, address2, address3: std_logic_vector(1 downto 0);
    signal enable0, enable1, enable2, enable3: std_logic;
    
    signal outData0, outData1, outData2, outData3: std_logic_vector(1 downto 0);
    
    constant CLK_period : time := 10 ns;
begin

    clockGenerator: process
    begin
        clock <= '0';
        wait for CLK_period;
        clock <= '1';
        wait for CLK_period;
    end process;

    dut: comSystem
    port map(clock, reset, inData0, inData1, inData2, inData3, address0, address1, address2, address3, enable0, enable1, enable2, enable3, outData0, outData1, outData2, outData3);
    
    reset <= '0';
    
    simulation: process
    begin
        wait for 100ns;
        
        inData0 <= "10";
        inData1 <= "00";
        inData2 <= "01";
        inData3 <= "11";
        
        address0 <= "10";
        address1 <= "00";
        address2 <= "11";
        address3 <= "01";
        
        enable0 <= '1';
        enable1 <= '0';
        enable2 <= '1';
        enable3 <= '0';
        
        wait for 30 ns;
        
        enable0 <= '0';
        
        wait for 150 ns;
        
        enable2 <= '0';
        
        wait for 150 ns;
        
        enable1 <= '1';
        enable3 <= '1';
        
        wait for 50ns;
        
        enable1 <= '0';
        
        wait for 150ns;
        
        enable3 <= '0';
        
        wait;
        
    end process;

end structural;
