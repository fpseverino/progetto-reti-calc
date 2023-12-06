function[exectime, data] = Gateway2_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('control_signal');
        temp_msg.type = 'control_signal';
        data.timeStamp = temp_msg.timeStamp;
        %disp(temp_msg.timeStamp);
        
        data.temperatura = temp_msg.messaggio.temperatura;
        data.umiditaT = temp_msg.messaggio.umiditaTerreno;
        data.umiditaA = temp_msg.messaggio.umiditaAria;
        data.potenza = temp_msg.messaggio.potenza;

        exectime = 0.01;
    
    case 2
        if data.umiditaT ~= 0
            msg.messaggio = data.umiditaT;
            msg.type = 'umid_T_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('errore');
        end
        if data.umiditaA ~= 0
            msg.messaggio = data.umiditaA;
            msg.type = 'umid_A_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('errore');
        end
        if data.temperatura ~= 0
            msg.messaggio = data.temperatura;
            msg.type = 'temp_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('errore');
        end
        if data.potenza ~= 0
            msg.messaggio = data.potenza;
            msg.type = 'p_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('errore');
        end

        delay = ttCurrentTime - data.timeStamp;
        Throughput_byte = 80 / 8;
        Throughput = Throughput_byte / delay;
        disp(Throughput);

        exectime = -1;
end