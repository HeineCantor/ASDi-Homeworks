library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
generic(DIM: natural :=2);
    Port (
        enable: in STD_LOGIC_VECTOR(7 downto 0);
        in1,in2,in3,in4: in STD_LOGIC_VECTOR(2+(DIM-1) downto 0);
        srcAddr: out STD_LOGIC_VECTOR(1 downto 0);
        dstAddr: out STD_LOGIC_VECTOR(1 downto 0)  
    );
end control_unit;

architecture dataflow of control_unit is
    signal p0, p1, p2, p3: STD_LOGIC;
    signal int_src: STD_LOGIC_VECTOR(1 downto 0);
     
begin
    -- priority
    p0 <= en1;
    p1 <= (not en1) and en2;
    p2 <= (not en1) and (not en2) and en3;
    p3 <= (not en1) and (not en2) and (not en3) and en4;
    

    -- source addr
    int_src(1) <= ((not p0) and (not p1) and (not p2) and p3) or ((not p0) and (not p1) and p2 and (not p3));
    int_src(0) <= ((not p0) and (not p1) and (not p2) and p3) or ((not p0) and p1 and (not p2) and (not p3));

    --assigning signal to output source
    srcAddr <= int_src;
    
     with int_src select
            dstAddr <=
                in1(3 downto 2) when "00",
                in2(3 downto 2) when "01",
                in3(3 downto 2) when "10",
                in4(3 downto 2) when "11",
                "UU" when others;

end dataflow;