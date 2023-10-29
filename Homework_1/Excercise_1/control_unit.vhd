----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2023 10:37:58 AM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    port
    (
        SW : in std_logic_vector(0 to 15);
        
        l : out std_logic_vector(0 to 3)
    );
end control_unit;

architecture dataflow of control_unit is

    component interconnection_network
        port(
            input       : in    std_logic_vector(0 to 15);
            output      : out   std_logic_vector(0 to 3);
            
            inputIndex  : in    std_logic_vector(0 to 3);
            outputIndex : in    std_logic_vector(0 to 1)
        );
    end component interconnection_network;

    signal mockData :    std_logic_vector(0 to 15)    := (others => 'U');

begin

    interconnectEntity : interconnection_network
    port map
    (
        input => mockData,
        output => l,
        inputIndex => sw(0 to 3),
        outputIndex => sw(4 to 5)
    );

    mockData <= "0101010110101010"; 

end dataflow;
