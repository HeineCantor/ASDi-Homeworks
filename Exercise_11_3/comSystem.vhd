library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comSystem is
    port(
        clock, reset: in std_logic;
        inData0, inData1, inData2, inData3: in std_logic_vector(1 downto 0);
        address0, address1, address2, address3: in std_logic_vector(1 downto 0);
        enable0, enable1, enable2, enable3: in std_logic;
        
        outData0, outData1, outData2, outData3: out std_logic_vector(1 downto 0)
    );
end comSystem;

architecture structural of comSystem is

    component nodeTX is
        port(
            clock, reset: in std_logic;
            startTransmit: in std_logic;
            inputData: in std_logic_vector(1 downto 0);
            readyToReceive: in std_logic;
            address: in std_logic_vector(1 downto 0);
            
            readyToTransmit, transmitCompleted: out std_logic;
            outputFrame: out std_logic_vector(3 downto 0)
        );
    end component;
    
    component nodeRX is
        generic(
            address: std_logic_vector(1 downto 0) := "00"
        );
        port(
            clock, reset: in std_logic;
            inputData: in std_logic_vector(1 downto 0);
            readyToTransmit: in std_logic;
            
            readyToReceive: out std_logic;
            outputData: out std_logic_vector(1 downto 0)
        );
    end component;
    
    component simpleInterconnection4to4 is
        port(
            inputArray: in std_logic_vector(3 downto 0);
            selectorTx, selectorRx: in std_logic_vector(1 downto 0);
            outputArray: out std_logic_vector(3 downto 0)
        );
    end component;
    
    component omega_network is
        generic( DIM: natural :=2);
        port (
            IN1,IN2,IN3,IN4: in STD_LOGIC_VECTOR(2+(DIM-1) downto 0);
            AB1,AB2,AB3,AB4: in STD_LOGIC;
            OUT1,OUT2,OUT3,OUT4: out STD_LOGIC_VECTOR((DIM-1) downto 0)
         );
    end component;
    
    component systemControlUnit is
        port(
            clock, reset: in std_logic;
            enableArray: in std_logic_vector(3 downto 0);
            rxAddress0, rxAddress1, rxAddress2, rxAddress3: in std_logic_vector(1 downto 0);
            transmissionComplete: in std_logic;
            
            selectorTx, selectorRx: out std_logic_vector(1 downto 0);
            startHandshakingArray, enableOmegaInput: out std_logic_vector(3 downto 0)
        );
    end component;


    signal txReqArray, txAckArray, rxReqArray, rxAckArray: std_logic_vector(3 downto 0);
    
    signal omegaOut0, omegaOut1, omegaOut2, omegaOut3: std_logic_vector(1 downto 0);
    
    signal txSelector, rxSelector:  std_logic_vector(1 downto 0);
    
    signal frame0, frame1, frame2, frame3: std_logic_vector(3 downto 0);
    
    signal enableArray, startHandshakingArray, enableOmegaInputArray: std_logic_vector(3 downto 0) := "0000";
    signal transmitComplete0, transmitComplete1, transmitComplete2, transmitComplete3: std_logic := '0';
    signal transmissionCompleteSignal: std_logic;

begin
    
    comSystemCU: systemControlUnit
    port map(
        clock => clock,
        reset => reset,
        enableArray => enableArray,
        rxAddress0 => address0,
        rxAddress1 => address1,
        rxAddress2 => address2,
        rxAddress3 => address3,
        transmissionComplete => transmissionCompleteSignal,
        
        selectorTx => txSelector,
        selectorRx => rxSelector,
        startHandshakingArray => startHandshakingArray,
        enableOmegaInput => enableOmegaInputArray
    );  
   
    nodeTx0: nodeTX
    port map(
        clock => clock,
        reset => reset,
        startTransmit => startHandshakingArray(3),
        inputData => inData0,
        readyToReceive => txAckArray(3),
        address => address0,
        
        readyToTransmit => txReqArray(3),
        transmitCompleted => transmitComplete0,
        outputFrame => frame0
    );
    
    nodeTx1: nodeTX
    port map(
        clock => clock,
        reset => reset,
        startTransmit => startHandshakingArray(2),
        inputData => inData1,
        readyToReceive => txAckArray(2),
        address => address1,
        
        readyToTransmit => txReqArray(2),
        transmitCompleted => transmitComplete1,
        outputFrame => frame1
    );
    
    nodeTx2: nodeTX
    port map(
        clock => clock,
        reset => reset,
        startTransmit => startHandshakingArray(1),
        inputData => inData2,
        readyToReceive => txAckArray(1),
        address => address2,
        
        readyToTransmit => txReqArray(1),
        transmitCompleted => transmitComplete2,
        outputFrame => frame2
    );
    
    nodeTx3: nodeTX
    port map(
        clock => clock,
        reset => reset,
        startTransmit => startHandshakingArray(0),
        inputData => inData3,
        readyToReceive => txAckArray(0),
        address => address3,
        
        readyToTransmit => txReqArray(0),
        transmitCompleted => transmitComplete3,
        outputFrame => frame3
    );
    
    nodeRx0: nodeRX
    port map(
        clock => clock,
        reset => reset,
        inputData => omegaOut0,
        readyToTransmit => rxReqArray(3),
        
        readyToReceive => rxAckArray(3),
        outputData => outData0
    );
    
    nodeRx1: nodeRX
    port map(
        clock => clock,
        reset => reset,
        inputData => omegaOut1,
        readyToTransmit => rxReqArray(2),
        
        readyToReceive => rxAckArray(2),
        outputData => outData1
    );
    
    nodeRx2: nodeRX
    port map(
        clock => clock,
        reset => reset,
        inputData => omegaOut2,
        readyToTransmit => rxReqArray(1),
        
        readyToReceive => rxAckArray(1),
        outputData => outData2
    );
    
    nodeRx3: nodeRX
    port map(
        clock => clock,
        reset => reset,
        inputData => omegaOut3,
        readyToTransmit => rxReqArray(0),
        
        readyToReceive => rxAckArray(0),
        outputData => outData3
    );
    
    reqInterconnection: simpleInterconnection4to4
    port map(
        inputArray => txReqArray,
        selectorTx => txSelector,
        selectorRx => rxSelector,
        outputArray => rxReqArray
    );
    
    ackInterconnection: simpleInterconnection4to4
    port map(
        inputArray => rxAckArray,
        selectorTx => rxSelector,
        selectorRx => txSelector,
        outputArray => txAckArray
    );

    dataOmegaNetwork: omega_network
    port map(
        in1 => frame0,
        in2 => frame1,
        in3 => frame2,
        in4 => frame3,
        
        ab1 => enableOmegaInputArray(3),
        ab2 => enableOmegaInputArray(2),
        ab3 => enableOmegaInputArray(1),
        ab4 => enableOmegaInputArray(0),
        
        out1 => omegaOut0,
        out2 => omegaOut1,
        out3 => omegaOut2,
        out4 => omegaOut3
    );

    enableArray <= enable0 & enable1 & enable2 & enable3;
    transmissionCompleteSignal <= transmitComplete0 and transmitComplete1 and transmitComplete2 and transmitComplete3; 

end structural;
