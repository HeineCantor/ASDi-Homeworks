----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2023 13:39:55
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


entity full_adder is

    port( 
        a: in std_logic;
        b: in std_logic;
        carry_in: in std_logic;
    
        sum:out std_logic;
        carry_out:out std_logic
    );
    
end full_adder;

architecture dataflow of full_adder is

    begin
        sum <= (a XOR B XOR carry_in);
        carry_out <=  (a AND b) OR (carry_in  AND (a OR b) );

end dataflow;
