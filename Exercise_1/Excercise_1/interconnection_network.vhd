----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2023 10:02:19 AM
-- Design Name: 
-- Module Name: interconnection_network - Behavioral
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

entity interconnection_network is
    port(
        input       : in    std_logic_vector(0 to 15);
        output      : out   std_logic_vector(0 to 3);
        
        inputIndex  : in    std_logic_vector(0 to 3);
        outputIndex : in    std_logic_vector(0 to 1)
    );
end interconnection_network;

architecture structural of interconnection_network is
    component mux_16_1
        port(   
            b    : in std_logic_vector(0 to 15);
            s    : in std_logic_vector(0 to 3);
            y0   : out std_logic
        );
    end component mux_16_1;
    
    component demux_1_4 is
        port(       
            a : in std_logic;
            z : in  std_logic_vector(0 to 1);
            y  : out std_logic_vector(0 to 3)
        );
    end component demux_1_4;
    
    signal muxToDemuxLink : std_logic := 'U';
    
begin

    muxEntity : mux_16_1
    port map
    (
        b => input,
        s => inputIndex,
        y0 => muxToDemuxLink
    );
    
    demuxEntity : demux_1_4
    port map
    (
        a => muxToDemuxLink,
        z => outputIndex,
        y => output
    );

end structural;
