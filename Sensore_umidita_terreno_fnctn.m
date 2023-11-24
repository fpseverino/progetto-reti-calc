function[exectime, data] = Sensore_umidita_terreno_fnctn(segment, data)

switch segment
    case 1
        data.msg.messaggio = ttAnalogIn(1);
        exectime = 0.02;
    case 2
        data.msg.type = 'umid_T_signal';
        ttSendMsg(10, data.msg, 80);
        exectime = 0.02;
    case 3
        exectime = -1;
end