----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2023 02:08:13 PM
-- Design Name: 
-- Module Name: ripple_carry_adder - structural
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

entity ripple_carry_adder is
    generic(
        width : positive := 4
    );
    port(
        a : in STD_LOGIC_VECTOR (0 to width);
        b : in STD_LOGIC_VECTOR (0 to width);
        carry_in : in STD_LOGIC;
        
        s : out STD_LOGIC_VECTOR (0 to width);
        carry_out : out STD_LOGIC
    );
end ripple_carry_adder;

architecture structural of ripple_carry_adder is
    component full_adder
        port(
            a : in STD_LOGIC;
            b : in STD_LOGIC;
            carry_in : in STD_LOGIC;
            
            sum : out STD_LOGIC;
            carry_out : out STD_LOGIC
        );	
	end component;
	
	
    begin
        
        c_all: FOR i IN 0 TO width - 1 GENERATE
            internal_adder: full_adder port map(
                
            );
        END GENERATE;


end structural;
