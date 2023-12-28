function[exectime, data] = Gateway2_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('control_signal');
        if ttCurrentTime > 60 && ttCurrentTime < 65
            disp('[Gateway](1): ricevuto controllore');
        end
        if ttCurrentTime > 300 && ttCurrentTime < 305
            disp('[Gateway](2): ricevuto controllore');
        end
        if ttCurrentTime > 540 && ttCurrentTime < 545
            disp('[Gateway](3): ricevuto controllore');
        end
        temp_msg.type = 'control_signal';
        data.timeStamp = temp_msg.timeStamp;
        
        data.temperatura = temp_msg.messaggio.temperatura;
        data.umiditaT = temp_msg.messaggio.umiditaTerreno;
        data.umiditaA = temp_msg.messaggio.umiditaAria;
        data.potenza = temp_msg.messaggio.potenza;

        exectime = 0.03;
    
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

        if ttCurrentTime > 60 && ttCurrentTime < 65
            disp('[Gateway](1): mando attuatore');
        end
        if ttCurrentTime > 300 && ttCurrentTime < 305
            disp('[Gateway](2): mando attuatore');
        end
        if ttCurrentTime > 540 && ttCurrentTime < 545
            disp('[Gateway](3): mando attuatore');
        end

        exectime = -1;
end