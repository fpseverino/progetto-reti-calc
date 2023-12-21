function[exectime, data] = Sensore_temperatura_fnctn(segment, data)

switch segment
    case 1
        temp = ttGetMsg;
        %disp('valore potenza trasmessa: ');
        disp(temp);
        data.msg.messaggio = ttAnalogIn(1);
        exectime = 0.03;
    case 2
        data.msg.type = 'temp_signal';
        data.msg.timeStamp = ttCurrentTime;
        ttSendMsg(4, data.msg, 80);
        exectime = 0.02;
    case 3
        exectime = -1;
end