function[exectime, data] = sensore_luce_fnctn(segment, data)

switch segment
    case 1
        data.msg.messaggio = ttAnalogIn(1);
        data.msg.timeStamp = ttCurrentTime;
        ttAnalogOut(1, data.msg.messaggio);
        exectime = 0.03;
    case 2
        data.msg.type = 'light_signal';
        ttSendMsg(4, data.msg, 80);
        exectime = 0.02;
    case 3
        exectime = -1;
end