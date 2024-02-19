
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity control_unit_A is
generic (
    DIM: integer :=3 );
port ( 
    start: in STD_LOGIC;
    address_A: in STD_LOGIC_VECTOR((DIM-1) downto 0);
    clk_A: in STD_LOGIC;
    reset: in STD_LOGIC;
    read: out STD_LOGIC;
    enable_counter: out STD_LOGIC;
    
    wr: out STD_LOGIC;
    tbe: in STD_LOGIC
);
end control_unit_A;

architecture Behavioral of control_unit_A is
type state is(
    IDLE, INIT, WRITE, WAIT_TBE, EN_COUNTER
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
   
   
CU_STATES: process(current_state, start, tbe, address_A)
    begin
   enable_counter <= '0';
   read <= '0';
   wr <= '0';
    case current_state is
    
        when IDLE =>
            if start='0' then
                next_state <= IDLE;
            elsif start ='1' then
                next_state <= INIT;
            end if;
            
       
        when INIT =>
            read <= '1';
            next_state <= WRITE;
       

         when WRITE =>
            wr <= '1';
            next_state <= WAIT_TBE;
         
         when WAIT_TBE =>
            if tbe='0' then
                next_state <=WAIT_TBE;
            elsif tbe='1' then
                next_state<=EN_COUNTER;
            end if;
            
                  
          when EN_COUNTER =>
            enable_counter <= '1';
                   
            if address_A/="100" then
                next_state <=INIT;
            elsif address_A="100" then
                next_state <=IDLE;
            end if;
            
         end case;
    end process;
         
end Behavioral;
