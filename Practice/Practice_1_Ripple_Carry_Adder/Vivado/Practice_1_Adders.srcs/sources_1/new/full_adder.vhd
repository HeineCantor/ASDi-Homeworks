----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2023 01:44:31 PM
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
    port(
        a : in STD_LOGIC;
        b : in STD_LOGIC;
        carry_in : in STD_LOGIC;
        
        sum : out STD_LOGIC;
        carry_out : out STD_LOGIC
    );
end full_adder;

architecture dataflow of full_adder is

    begin
		sum <= (a XOR b XOR carry_in);
		carry_out <= (a AND b) OR (carry_in AND (a OR b));

end dataflow;
