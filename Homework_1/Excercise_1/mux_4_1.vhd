library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- creo l'entity mux_4_1
--possiedo 4 ingressi dunque necessito di log_2(4) selettori

entity mux_4_1 is
    
    port(   a0 : in  STD_LOGIC;
            a1 : in  STD_LOGIC;
            a2 : in  STD_LOGIC;
            a3 : in  STD_LOGIC;
            z0 : in  STD_LOGIC;
            z1 : in  STD_LOGIC;
            y  : out STD_LOGIC
    );
end mux_4_1;


architecture dataflow of mux_4_1 is
    begin
        y <= a0 when z0='0' and z1='0' else
             a1 when z0='0' and z1='1' else
             a2 when z0='1' and z1='0' else
             a3 when z0='1' and z1='0' else
             '-';
end dataflow;