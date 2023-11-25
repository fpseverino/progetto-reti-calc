function[exectime, data] = Gateway2_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('control_signal');
        temp_msg.type = 'control_signal';
        data.temperatura = temp_msg.temperatura;
        data.umiditaT = temp_msg.umiditaTerreno;
        data.umiditaA = temp_msg.umiditaAria;
        data.potenza = temp_msg.potenza;
        %disp('valore di temp_msg');
        %disp(temp_msg);
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

        exectime = -1;
end