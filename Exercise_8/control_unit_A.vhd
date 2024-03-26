
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity control_unit_A is
generic (
    DIM: natural :=2 );
port ( 
    start: in STD_LOGIC;
    address_A: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    clk_A: in STD_LOGIC;
    reset: in STD_LOGIC;
    ack: in STD_LOGIC;
    read: out STD_LOGIC;
    enable_counter: out STD_LOGIC;
    req: out STD_LOGIC
);
end control_unit_A;

architecture Behavioral of control_unit_A is
type state is(
    IDLE, READ_MEM, SEND, WAIT_ACK_LOW, EN_COUNT, STOP
);

signal current_state, next_state: state;

begin

MEM: process(clk_a)
    begin
        if(clk_a'event AND clk_a='1') then
            if reset='1' then
                current_state <= IDLE;
            else
                current_state <= next_state;
            end if;
        end if;
   end process;
   
   
CU_STATES: process(current_state, start, ack, address_A)
    begin
    
    case current_state is
        when IDLE =>
            enable_counter <= '0';
            read <= '0';
            req <= '0';
            
            if start='0' then
                next_state <= IDLE;
            elsif start ='1' then
                next_state <= READ_MEM;
            end if;
            
        when READ_MEM =>
            enable_counter <= '0';
            read <= '1';
            req <= '0';
            
            next_state <= SEND;
        
        when SEND =>
            enable_counter <= '0';
            read <= '0';
            req <= '1';
            
            if ack='0' then
                next_state <= SEND;
            else
                next_state <= WAIT_ACK_LOW;
            end if;
            
        when WAIT_ACK_LOW =>
            enable_counter <= '0';
            read <= '0';
            req <= '0';
            
            if ack='1' then
                next_state <= WAIT_ACK_LOW;
            else
                if (ack='0' AND address_A="11") then
                    next_state <= STOP;
                else
                    if(ack='0' AND address_A/="11") then
                        next_state <= EN_COUNT;
                    end if;
                end if;
            end if;
                    
          when EN_COUNT =>
            enable_counter <= '1';
            read <= '0';
            req <= '0';
            
            next_state <= READ_MEM;
            
         when STOP =>
            enable_counter <= '0';
            read <= '0';
            req <= '0';
            
         end case;
    end process;
         
end Behavioral;
