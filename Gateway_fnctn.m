function[exectime, data] = Gateway_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('temp_signal');
        if ~isempty(temp_msg)
            data.temperatura = temp_msg.messaggio;
            data.timeStamp = temp_msg.timeStamp;
            %disp(['Gateway: valore temperatura ricevuto: ' num2str(data.temperatura) ]);
            if ttCurrentTime > 2 && ttCurrentTime < 4
                disp('[Gateway](1): pacchetto temperatura');
            end
            if ttCurrentTime > 10 && ttCurrentTime < 12
                disp('[Gateway](2): pacchetto temperatura');
            end
            if ttCurrentTime > 18 && ttCurrentTime < 20
                disp('[Gateway](3): pacchetto temperatura');
            end
        else
            %disp('Gateway: nessun valore temperatra ricevuto...');
        end

        exectime = 0.002;
    case 2
        temp_msg = ttTryFetch('umid_T_signal');
        if ~isempty(temp_msg)
            data.umiditaTerreno = temp_msg.messaggio;
            data.timeStamp = temp_msg.timeStamp;
            %disp(['Gateway: valore umidità terreno ricevuto: ' num2str(data.umiditaTerreno) ]);
            if ttCurrentTime > 2 && ttCurrentTime < 4
                disp('[Gateway](1): pacchetto Umidit_T');
            end
            if ttCurrentTime > 10 && ttCurrentTime < 12
                disp('[Gateway](2): pacchetto Umidit_T');
            end
            if ttCurrentTime > 18 && ttCurrentTime < 20
                disp('[Gateway](3): pacchetto Umidit_T');
            end
        else
            %disp('Gateway: nessun valore umidità terreno ricevuto...');
        end

        exectime = 0.002;
    case 3
        temp_msg = ttTryFetch('umid_A_signal');
        if ~isempty(temp_msg)
            data.umiditaAria = temp_msg.messaggio;
            data.timeStamp = temp_msg.timeStamp;
            %disp(['Gateway: valore umidità aria ricevuto: ' num2str(data.umiditaAria) ]);
            if ttCurrentTime > 2 && ttCurrentTime < 4
                disp('[Gateway](1): pacchetto Umidit_A');
            end
            if ttCurrentTime > 10 && ttCurrentTime < 12
                disp('[Gateway](2): pacchetto Umidit_A');
            end
            if ttCurrentTime > 18 && ttCurrentTime < 20
                disp('[Gateway](3): pacchetto Umidit_A');
            end
        else
            %disp('Gateway: nessun valore umidità aria ricevuto...');
        end

        exectime = 0.002;

    case 4
    if data.temperatura ~= 0
        msg.messaggio = data.temperatura;
        delay = ttCurrentTime - data.timeStamp;
        msg.type = 'temp_signal';
        ttAnalogOut(1, delay);
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore temperatura...');
    end
    
    if data.umiditaTerreno ~= 0
        msg.messaggio = data.umiditaTerreno;
        delay = ttCurrentTime - data.timeStamp;
        ttAnalogOut(2, delay);
        msg.type = 'umid_T_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità terreno...');
    end

    if data.umiditaAria ~= 0
        msg.messaggio = data.umiditaAria;
        delay = ttCurrentTime - data.timeStamp;
        ttAnalogOut(3, delay);
        msg.type = 'umid_A_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità aria...');
    end

    if ttCurrentTime > 2 && ttCurrentTime < 4
        disp('[Gateway](1): mando al controllore');
    end
    if ttCurrentTime > 10 && ttCurrentTime < 12
        disp('[Gateway](2): mando al controllore');
    end
    if ttCurrentTime > 18 && ttCurrentTime < 20
        disp('[Gateway](3): mando al controllore');
    end

    exectime = -1;
end

