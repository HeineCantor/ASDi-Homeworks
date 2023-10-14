----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2023 13:24:44
-- Design Name: 
-- Module Name: rca_tb - Behavioral
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

entity rca_tb is
end rca_tb;

architecture Behavioral of rca_tb is
    component rca is 
    generic (N: natural range 0 to 32 :=8);
    port(
        a : in STD_LOGIC_VECTOR (N-1 downto 0);
        b : in STD_LOGIC_VECTOR (N-1 downto 0);
        ci : in STD_LOGIC;
        
        s : out STD_LOGIC_VECTOR (N-1 downto 0);
        co : out STD_LOGIC
    );
    end component;

    signal OP_A_ext: std_logic_vector(3 downto 0);
	signal OP_B_ext: std_logic_vector(3 downto 0);
	signal CIN_ext: std_logic;
	signal S_ext: std_logic_vector(3 downto 0);
	signal COUT_ext: std_logic;

begin
    uut: rca
        generic map (N=>4)
        port map(
            a => OP_A_ext,
		    b => OP_B_ext,
		    ci => CIN_ext,
		    s => S_ext,
		    co => COUT_ext
        );
        
        stim_proc: process
        begin
            wait for 100ns;
		
		-- 0+7=7 ok
		OP_A_ext <= "0000";
		OP_B_ext <= "0111";
		CIN_ext <= '0';
		
		wait for 10 ns;
		
		-- (-1)+(-2)=-3 ok
		OP_A_ext <= "1111";
		OP_B_ext <= "1110";
		wait for 10 ns;
		
		-- 1+7=8 overflow
		OP_A_ext <= "0001";
		OP_B_ext <= "0111";
		CIN_ext <= '0';
		
		wait for 10 ns;
		
		-- (-1) + (-8) = -9 overflow
		OP_A_ext <= "1111";
		OP_B_ext <= "1000";
		wait for 10 ns;
		
		-- 7-3=4 ok
		OP_A_ext <= "0111";
		OP_B_ext <= "1101";
		CIN_ext <= '0';
		
		wait for 10 ns;
		
		OP_A_ext <= "1000";
		OP_B_ext <= "1101";
		wait for 10 ns;
		wait;
	end process;
	
end Behavioral;
