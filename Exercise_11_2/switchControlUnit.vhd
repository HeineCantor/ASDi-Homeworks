library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switchControlUnit is
    port(
        en1, en2: in std_logic;
        addrBit1, addrBit2: in std_logic;
        selector1, selector2: out std_logic
    );
end switchControlUnit;

architecture dataflow of switchControlUnit is

begin

    selector1 <=    '1' when (en2 = '1' and addrBit2 = '0' and (en1 = '0' or addrBit1 = '1')) else    
                    '0' when (en1 = '1' and addrBit1 = '0') else
                    'X';
                    
    selector2 <=    '1' when (en2 = '1' and addrBit2 = '1' and (en1 = '0' or addrBit1 = '0')) else
                    '0' when (en1 = '1' and addrBit1 = '1') else
                    'X';                  

end dataflow;
