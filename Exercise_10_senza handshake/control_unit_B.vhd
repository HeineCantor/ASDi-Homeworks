
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity control_unit_B is
generic( DIM: integer :=3);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC; 
    enable_counter: out STD_LOGIC;
    write: out STD_LOGIC;
    read_reg: out STD_LOGIC;
   
    rda: in STD_LOGIC;
    rd: out STD_LOGIC :='0'   
);
end control_unit_B;

architecture Behavioral of control_unit_B is

type state is(
    IDLE, R_W, MEM, FINISH
);
signal current_state, next_state: state;

begin
MEM_PROC: process(clk_b)
    begin
        if(clk_b'event AND clk_b='1') then
            if reset='1' then
                current_state<= IDLE;
            else
                current_state <= next_state;
            end if;
        end if;
      end process;
      
      
      
CU_B: process(current_state, rda)
    begin
    
    case current_state is

            
        when IDLE =>
            write<='0';
            enable_counter<='0';
            read_reg<='0';
            rd<='0';
            
            if rda='0' then
                next_state <= IDLE;
            elsif rda='1' then
                next_state<=R_W;
            end if;
        
        when R_W=>
            write<='0';
            enable_counter<='0';
            read_reg<='1';
            
            rd<='1';
            
            next_state<=MEM;
        
        when MEM=>
            write<='1';
            enable_counter<='0';
            read_reg<='0';
            rd<='0';
            next_state<= FINISH;
        
        
        when FINISH=>
            write<='0';
            enable_counter<='1';
            read_reg<='0';
            rd<='0';
            next_state<= IDLE;
            
         end case;
         end process;           
       
end Behavioral;
