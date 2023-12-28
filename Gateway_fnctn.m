function[exectime, data] = Gateway_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('temp_signal');
        if ~isempty(temp_msg)
            data.temperatura = temp_msg.messaggio;
            data.timeStamp = temp_msg.timeStamp;
            %disp(['Gateway: valore temperatura ricevuto: ' num2str(data.temperatura) ]);
            if ttCurrentTime > 60 && ttCurrentTime < 65
                disp('[Gateway](1): pacchetto temperatura');
            end
            if ttCurrentTime > 300 && ttCurrentTime < 305
                disp('[Gateway](2): pacchetto temperatura');
            end
            if ttCurrentTime > 540 && ttCurrentTime < 545
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
            if ttCurrentTime > 60 && ttCurrentTime < 65
                disp('[Gateway](1): pacchetto Umidit_T');
            end
            if ttCurrentTime > 300 && ttCurrentTime < 305
                disp('[Gateway](2): pacchetto Umidit_T');
            end
            if ttCurrentTime > 540 && ttCurrentTime < 545
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
            if ttCurrentTime > 60 && ttCurrentTime < 65
                disp('[Gateway](1): pacchetto Umidit_A');
            end
            if ttCurrentTime > 300 && ttCurrentTime < 305
                disp('[Gateway](2): pacchetto Umidit_A');
            end
            if ttCurrentTime > 540 && ttCurrentTime < 545
                disp('[Gateway](3): pacchetto Umidit_A');
            end
        else
            %disp('Gateway: nessun valore umidità aria ricevuto...');
        end

        exectime = 0.002;

    case 4
    if data.temperatura ~= 0
        msg.messaggio.temp = data.temperatura;
        msg.messaggio.time = data.timeStamp;
        msg.type = 'temp_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore temperatura...');
    end
    
    if data.umiditaTerreno ~= 0
        msg.messaggio.umidT = data.umiditaTerreno;
        msg.messaggio.time = data.timeStamp;
        msg.type = 'umid_T_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità terreno...');
    end

    if data.umiditaAria ~= 0
        msg.messaggio.umidA = data.umiditaAria;
        msg.messaggio.time = data.timeStamp;
        msg.type = 'umid_A_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità aria...');
    end

    if ttCurrentTime > 60 && ttCurrentTime < 65
        disp('[Gateway](1): mando al controllore');
    end
    if ttCurrentTime > 300 && ttCurrentTime < 305
        disp('[Gateway](2): mando al controllore');
    end
    if ttCurrentTime > 540 && ttCurrentTime < 545
        disp('[Gateway](3): mando al controllore');
    end

    exectime = -1;
end

