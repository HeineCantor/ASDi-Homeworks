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
        switch      : in std_logic_vector(0 to 13);
        
        CLK100MHZ   : in std_logic;
        
        LED16_R     : out std_logic;
        LED16_B     : out std_logic;
        
        buttonL     : in std_logic;
        buttonR     : in std_logic;
        
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
    
    component data_input
        port
        (
            clock   : in std_logic;
            
            data8bit    : in std_logic_vector(0 to 7);          
            outputData  : out std_logic_vector(0 to 15) := (others => '0');
            
            notifyLeft  : out std_logic;
            notifyRight : out std_logic;
            
            buttonL     : in std_logic;
            buttonR     : in std_logic
        );
    end component data_input;

    signal dataWire :      std_logic_vector(0 to 15)    := (others => '0');

begin

    dataInputEntity : data_input
    port map
    (
        clock => CLK100MHZ,
        
        data8bit => switch(6 to 13),
        outputData => dataWire,
        
        notifyLeft => LED16_R,
        notifyRight => LED16_B,
        
        buttonL => buttonL,
        buttonR => buttonR
    );

    interconnectEntity : interconnection_network
    port map
    (
        input => dataWire,
        output => l,
        inputIndex => switch(0 to 3),
        outputIndex => switch(4 to 5)
    ); 

end dataflow;
