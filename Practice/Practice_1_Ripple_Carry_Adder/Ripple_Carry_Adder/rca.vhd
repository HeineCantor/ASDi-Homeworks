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

entity rca is
    generic (N: natural range 0 to 32 := 8); 
    port(
        a : in STD_LOGIC_VECTOR (N-1 downto 0);
        b : in STD_LOGIC_VECTOR (N-1 downto 0);
        ci : in STD_LOGIC;
        
        s : out STD_LOGIC_VECTOR (N-1 downto 0);
        co : out STD_LOGIC
    );
end rca;

architecture structural of rca is
    component full_adder
        port(
            a: in std_logic;
            b: in std_logic;
            carry_in: in std_logic;
    
            sum:out std_logic;
            carry_out:out std_logic
        );
    end component;

    signal c_int : STD_LOGIC_VECTOR (N-1 downto 0);

begin

    FOR_0_TO_N: for i in 0 to N-1 GENERATE
        
        IF_CLAUSE: if i=0 GENERATE
            FA_0: full_adder port map(
                a => a(0),
                b => b(0),
                carry_in => ci,
                sum => s(0),
                carry_out => c_int(0)
            );
        END GENERATE IF_CLAUSE;
        
        ELSE_CLAUSE: if i/=0 GENERATE
            FA_comp: full_adder port map(
                a => a(i),
                b => b(i),
                carry_in => c_int(i-1),
                sum => s(i),
                carry_out => c_int(i)
            );
    END GENERATE ELSE_CLAUSE;
    
    END GENERATE FOR_0_TO_N;

end structural;
