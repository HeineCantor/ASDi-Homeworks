library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- creo l'entity mux_4_1
--possiedo 4 ingressi dunque necessito di log_2(4) selettori

entity mux_4_1 is
    
port(       a : in STD_LOGIC_VECTOR(0 to 3);
            z : in  STD_LOGIC_VECTOR(0 to 1);
            y  : out STD_LOGIC
    );
    
end mux_4_1;


architecture dataflow of mux_4_1 is
    begin
        y <= a(0) when z="00" else
             a(1) when z="01" else
             a(2) when z="10" else
             a(3) when z="11" else
             '-';
end dataflow;