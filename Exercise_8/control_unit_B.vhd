
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity control_unit_B is
generic( DIM: natural :=2);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    req: in STD_LOGIC;
    address_B: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    read_reg: out STD_LOGIC;
    write: out STD_LOGIC;
    read: out STD_LOGIC;
    enable_counter: out STD_LOGIC;
    ack: out STD_LOGIC
    --stop: out STD_LOGIC
);
end control_unit_B;

architecture Behavioral of control_unit_B is

type state is(
    WAIT_REQ, LOAD, WRITE_STATE, CHECK, EN_COUNT, STOP
);
signal current_state, next_state: state;

begin
MEM: process(clk_b)
    begin
        if(clk_b'event AND clk_b='1') then
            if reset='1' then
                current_state<= WAIT_REQ;
            else
                current_state <= next_state;
            end if;
        end if;
      end process;
      
      
      
CU_B: process(current_state, req, address_B)
    begin
   
   
    read_reg <= '0';
    write <= '0';
    read <= '0';
    enable_counter<='0';
    ack<='0';
    --stop <='0';
    
    case current_state is
   
        when WAIT_REQ =>
            if req='0' then
                next_state <= WAIT_REQ;
            else
                next_state <= LOAD;
            end if;
          
        when LOAD =>
            read_reg <='1';
            read<='1';
            
            next_state<=WRITE_STATE;
        
        when WRITE_STATE =>
            write <='1';
            next_state <= CHECK;
        
        when CHECK =>
            ack <='1';
            
            if req='1' then
                next_state <= CHECK;
            else
                if(req='0' AND address_B="11") then
                    next_state <= STOP;
                else
                    if(req='0' AND address_B/="11") then
                        next_state<=EN_COUNT;
                    end if;
                end if;
            end if;
            
         
         when EN_COUNT =>
            enable_counter<='1';
            ack<='1';
            next_state<= WAIT_REQ;
            
            
         when STOP =>
            --stop<='1';
         
         end case;
         end process;           
       
end Behavioral;
