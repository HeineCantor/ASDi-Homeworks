----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2023 09:44:02 AM
-- Design Name: 
-- Module Name: demux_1_4 - Behavioral
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

entity demux_1_4 is
    port(       a : in STD_LOGIC;
                z : in  STD_LOGIC_VECTOR(0 to 1);
                y  : out STD_LOGIC_VECTOR(0 to 3)
        );
end demux_1_4;

architecture dataflow of demux_1_4 is

    begin
        y <= a & "000"      when z = "00" else
            "0" & a & "00"  when z = "01" else
            "00" & a & "0"  when z = "10" else
            "000" & a       when z = "11" else
            "----";

end dataflow;
