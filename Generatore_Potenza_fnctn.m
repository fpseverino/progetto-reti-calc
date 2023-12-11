function[exectime, data] = Generatore_Potenza_fnctn(segment, data)

switch segment
    case 1
        data.msg.messaggio.tensione = ttAnalogIn(1);
        data.msg.messaggio.corrente = ttAnalogIn(2);
        data.msg.timeStamp = ttCurrentTime;
        exectime = 0.02;
    case 2
        data.msg.type = 'power_signal';
        data.msg.messaggio.potenza =  data.msg.messaggio.tensione *  data.msg.messaggio.corrente;
        ttSendMsg(1, data.msg, 80);
        ttSendMsg(2, data.msg, 80);
        ttSendMsg(3, data.msg, 80);
        exectime = 0.02;
    case 3
        exectime = -1;
end