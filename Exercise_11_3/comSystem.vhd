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
            clock: in std_logic;
            startTransmit, startHandshake: in std_logic;
            inputData: in std_logic_vector(1 downto 0);
            readyToReceive: in std_logic;
            address: in std_logic_vector(1 downto 0);
            
            requestForTransmit, readyToTransmit, transmitCompleted: out std_logic;
            outputFrame: out std_logic_vector(3 downto 0)
        );
    end component;
    
    component nodeRX is
        generic(
            address: std_logic_vector(1 downto 0) := "00"
        );
        port(
            clock: in std_logic;
            inputData: in std_logic_vector(1 downto 0);
            readyToTransmit: in std_logic;
            
            readyToReceive: out std_logic;
            outputData: out std_logic_vector(1 downto 0)
        );
    end component;
    
    component simpleInterconnection4to4 is
        generic(
            dataWidth : natural := 2
        );
        port(
            input0, input1, input2, input3: in std_logic_vector(dataWidth-1 downto 0);
            selectorTx, selectorRx: in std_logic_vector(1 downto 0);
            output0, output1, output2, output3: out std_logic_vector(dataWidth-1 downto 0)
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

    signal readyToReceiveLinkTX, readyToTransmitLinkTX: std_logic_vector(3 downto 0);
    signal txCouple0, txCouple1, txCouple2, txCouple3: std_logic_vector(1 downto 0);
    
    signal readyToReceiveLinkRX, readyToTransmitLinkRX: std_logic_vector(3 downto 0);
    signal rxCouple0, rxCouple1, rxCouple2, rxCouple3: std_logic_vector(1 downto 0);
    
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
        startTransmit => enable0,
        startHandshake => startHandshakingArray(3),
        inputData => inData0,
        readyToReceive => readyToReceiveLinkTX(3),
        address => address0,
        
        requestForTransmit => enableArray(3),
        readyToTransmit => readyToTransmitLinkTX(3),
        transmitCompleted => transmitComplete0,
        outputFrame => frame0
    );
    
    nodeTx1: nodeTX
    port map(
        clock => clock,
        startTransmit => enable1,
        startHandshake => startHandshakingArray(2),
        inputData => inData1,
        readyToReceive => readyToReceiveLinkTX(2),
        address => address1,
        
        requestForTransmit => enableArray(2),
        readyToTransmit => readyToTransmitLinkTX(2),
        transmitCompleted => transmitComplete1,
        outputFrame => frame1
    );
    
    nodeTx2: nodeTX
    port map(
        clock => clock,
        startTransmit => enable2,
        startHandshake => startHandshakingArray(1),
        inputData => inData2,
        readyToReceive => readyToReceiveLinkTX(1),
        address => address2,
        
        requestForTransmit => enableArray(1),
        readyToTransmit => readyToTransmitLinkTX(1),
        transmitCompleted => transmitComplete2,
        outputFrame => frame2
    );
    
    nodeTx3: nodeTX
    port map(
        clock => clock,
        startTransmit => enable3,
        startHandshake => startHandshakingArray(0),
        inputData => inData3,
        readyToReceive => readyToReceiveLinkTX(0),
        address => address3,
        
        requestForTransmit => enableArray(0),
        readyToTransmit => readyToTransmitLinkTX(0),
        transmitCompleted => transmitComplete3,
        outputFrame => frame3
    );
    
    nodeRx0: nodeRX
    port map(
        clock => clock,
        inputData => omegaOut0,
        readyToTransmit => readyToTransmitLinkRX(3),
        
        readyToReceive => readyToReceiveLinkRX(3),
        outputData => outData0
    );
    
    nodeRx1: nodeRX
    port map(
        clock => clock,
        inputData => omegaOut1,
        readyToTransmit => readyToTransmitLinkRX(2),
        
        readyToReceive => readyToReceiveLinkRX(2),
        outputData => outData1
    );
    
    nodeRx2: nodeRX
    port map(
        clock => clock,
        inputData => omegaOut2,
        readyToTransmit => readyToTransmitLinkRX(1),
        
        readyToReceive => readyToReceiveLinkRX(1),
        outputData => outData2
    );
    
    nodeRx3: nodeRX
    port map(
        clock => clock,
        inputData => omegaOut3,
        readyToTransmit => readyToTransmitLinkRX(0),
        
        readyToReceive => readyToReceiveLinkRX(0),
        outputData => outData3
    );
    
    txCouple0 <= readyToTransmitLinkTX(3) & readyToReceiveLinkTX(3);
    txCouple1 <= readyToTransmitLinkTX(2) & readyToReceiveLinkTX(2);
    txCouple2 <= readyToTransmitLinkTX(1) & readyToReceiveLinkTX(1);
    txCouple3 <= readyToTransmitLinkTX(0) & readyToReceiveLinkTX(0);
    
    rxCouple0 <= readyToTransmitLinkRX(3) & readyToReceiveLinkRX(3);
    rxCouple1 <= readyToTransmitLinkRX(2) & readyToReceiveLinkRX(2);
    rxCouple2 <= readyToTransmitLinkRX(1) & readyToReceiveLinkRX(1);
    rxCouple3 <= readyToTransmitLinkRX(0) & readyToReceiveLinkRX(0);
    
    handshakeInterconnection: simpleInterconnection4to4
    port map(
        input0 => txCouple0,
        input1 => txCouple1,
        input2 => txCouple2,
        input3 => txCouple3,
        selectorTx => txSelector,
        selectorRx => rxSelector,
        output0 => rxCouple0,
        output1 => rxCouple1,
        output2 => rxCouple2,
        output3 => rxCouple3
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

    transmissionCompleteSignal <= transmitComplete0 and transmitComplete1 and transmitComplete2 and transmitComplete3; 

end structural;
