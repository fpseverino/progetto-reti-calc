function[exectime, data] = Sensore_temperatura_fnctn(segment, data)

switch segment
    case 1
        data.msg.messaggio = ttAnalogIn(1); %leggere valori Input
        exectime = 0.050;
    case 2
        data.msg.type = 'temp_signal';
        ttSendMsg(10, data.msg, 80);
        exectime = 0.050;
    case 3
        exectime = -1;
end