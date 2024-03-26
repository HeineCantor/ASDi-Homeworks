
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity control_unit_B is
generic( DIM: integer :=3);
port(
    clk_b: in STD_LOGIC;
    reset: in STD_LOGIC;
    enable_counter: out STD_LOGIC;
    req: in STD_LOGIC;
    ack: out STD_LOGIC;
    done: out STD_LOGIC;
    
    write: out STD_LOGIC;
    read_reg: out STD_LOGIC;
    
    rda: in STD_LOGIC;
    rd: out STD_LOGIC    
);
end control_unit_B;

architecture Behavioral of control_unit_B is

type state is(
    IDLE, WAIT_REQUEST, WAIT_RDA, SEND_ACK, RW, MEM, FINISH
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
      
      
      
CU_B: process(current_state, req, rda)
    begin
    
    write<='0';
    enable_counter<='0';
    read_reg<='0';
    rd<='0';
    done <='0';
    ack<='0';
    
    case current_state is
       
      when IDLE =>
        if req='0' then
            next_state <= IDLE;
        else next_state <= SEND_ACK;
        end if;
      
       when SEND_ACK =>
            ack<='1';
            next_state <= WAIT_RDA;

       when WAIT_RDA =>
            ack<='1';
            if rda='0' then
                next_state <= WAIT_RDA;
            elsif rda='1' then
                next_state <= RW;
            end if;
            
       when RW=>
            ack<='1';
            read_reg<='1';  
            rd<='1';
            next_state<=MEM;
        
       when MEM=>
            ack<='1';
            write<='1';
            next_state<= FINISH;
         
       when FINISH=>
            ack<='1';
            enable_counter<='1';
            done <= '1';
            next_state<= WAIT_REQUEST;
            
       when WAIT_REQUEST =>
            ack<='1';
            done <='1';
            if req='1' then
                next_state <= WAIT_REQUEST;
            else next_state <= IDLE;
            end if;
            
         end case;
         end process;           
       
end Behavioral;
