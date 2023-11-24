function[exectime, data] = Sensore_temperatura_fnctn(segment, data)

switch segment
    case 1
        data.msg = ttAnaloIn(1); %leggere valori Input
        exectime = 0.050;
    case 2
        ttSendMsg(x, data.msg, 80);
        exectime = 0.050;
    case 3
        exectime = -1;
end