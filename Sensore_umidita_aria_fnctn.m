function[exectime, data] = Sensore_umidita_aria_fnctn(segment, data)

switch segment
    case 1
        data.msg.messaggio = ttAnalogIn(1);
        data.msg.timeStamp = ttCurrentTime;
        exectime = 0.02;
    case 2
        data.msg.type = 'umid_A_signal';
        ttSendMsg(4, data.msg, 80);
        exectime = 0.02;
    case 3
        exectime = -1;
end