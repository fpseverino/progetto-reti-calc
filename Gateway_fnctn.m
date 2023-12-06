function[exectime, data] = Gateway_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('temp_signal');
        if ~isempty(temp_msg)
            data.temperatura = temp_msg.messaggio;
            data.timeStamp = temp_msg.timeStamp;
            %disp(['Gateway: valore temperatura ricevuto: ' num2str(data.temperatura) ]);
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
        else
            %disp('Gateway: nessun valore umidità aria ricevuto...');
        end

        exectime = 0.002;

    case 4
    if data.temperatura ~= 0
        msg.messaggio = data.temperatura;
        delay = ttCurrentTime - data.timeStamp;
        msg.type = 'temp_signal';
        Throughput_byte = 80 / 8;
        Throughput1 = Throughput_byte / delay;
        %disp(Throughput1);
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore temperatura...');
    end
    
    if data.umiditaTerreno ~= 0
        msg.messaggio = data.umiditaTerreno;
        delay = ttCurrentTime - data.timeStamp;
        msg.type = 'umid_T_signal';
        Throughput_byte = 80 / 8;
        Throughput2 = Throughput_byte / delay;
        %disp(Throughput2);
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità terreno...');
    end

    if data.umiditaAria ~= 0
        msg.messaggio = data.umiditaAria;
        delay = ttCurrentTime - data.timeStamp;
        msg.type = 'umid_A_signal';
        Throughput_byte = 80 / 8;
        Throughput3 = Throughput_byte / delay;
        %disp(Throughput3);
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità aria...');
    end
    ThroughputSensore = Throughput1 + Throughput2 + Throughput3;
    %disp(ThroughputSensore);
    exectime = -1;
end

