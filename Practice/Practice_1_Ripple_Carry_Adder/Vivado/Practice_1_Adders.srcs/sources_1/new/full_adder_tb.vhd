----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2023 01:51:00 PM
-- Design Name: 
-- Module Name: full_adder_tb - full_adder
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

entity full_adder_tb is
--  Port ( );
end full_adder_tb;

architecture full_adder of full_adder_tb is

	component full_adder
        port(
            a : in STD_LOGIC;
            b : in STD_LOGIC;
            carry_in : in STD_LOGIC;
            
            sum : out STD_LOGIC;
            carry_out : out STD_LOGIC
        );	
	end component;
	
	signal x_1	     : STD_LOGIC := 'U';
	signal x_2 	     : STD_LOGIC := 'U'; 
	signal c_i         : STD_LOGIC := 'U'; 
	signal y           : STD_LOGIC := 'U'; 
	signal c_o      : STD_LOGIC := 'U'; 

    begin
        utt : entity work.full_adder(dataflow) port map(
			a => x_1,
			b => x_2,
			carry_in => c_i,
			sum => y,
			carry_out => c_o
		);
        
		stim_proc : process
		begin
		
		wait for 100ns;
		
		x_1 <= '0';
		x_2 <= '0';
		c_i <= '0';
		
		wait for 10ns;
		
		x_1 <= '1';
		
		wait for 10ns;
		
		x_1 <= '0';
		x_2 <= '1';
		
		wait for 10ns;
		
		x_1 <= '1';
		
		wait for 10ns;
		
		x_1 <= '0';
		x_2 <= '0';
		c_i <= '1';
		
		wait for 10ns;
		
        x_1 <= '1';
		
		wait for 10ns;
		
		x_1 <= '0';
		x_2 <= '1';
		
		wait for 10ns;
		
		x_1 <= '1';
		
		wait for 10ns;
		
		wait;
		end process;

end full_adder;
