function[exectime, data] = Gateway_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('temp_signal');
        if ~isempty(temp_msg)
            data.temperatura = temp_msg;
            %disp(['Gateway: valore temperatura ricevuto: ' num2str(data.temperatura) ]);
        else
            %disp('Gateway: nessun valore temperatra ricevuto...');
        end

        exectime = 0.002;
    case 2
        temp_msg = ttTryFetch('umid_T_signal');
        if ~isempty(temp_msg)
            data.umiditaTerreno = temp_msg;
            %disp(['Gateway: valore umidità terreno ricevuto: ' num2str(data.umiditaTerreno) ]);
        else
            %disp('Gateway: nessun valore umidità terreno ricevuto...');
        end

        exectime = 0.002;
    case 3
        temp_msg = ttTryFetch('umid_A_signal');
        if ~isempty(temp_msg)
            data.umiditaAria = temp_msg;
            %disp(['Gateway: valore umidità aria ricevuto: ' num2str(data.umiditaAria) ]);
        else
            %disp('Gateway: nessun valore umidità aria ricevuto...');
        end

        exectime = 0.002;

    case 4
    if data.temperatura ~= 0
        msg.messaggio = data.temperatura;
        msg.type = 'temp_signal';
        ttSendMsg([2 1], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore temperatura...');
    end
    
    if data.umiditaTerreno ~= 0
        msg.messaggio = data.umiditaTerreno;
        msg.type = 'umid_T_signal';
        ttSendMsg([2 1], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità terreno...');
    end

    if data.umiditaAria ~= 0
        msg.messaggio = data.umiditaAria;
        msg.type = 'umid_A_signal';
        ttSendMsg([2 1], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità aria...');
    end
    exectime = 0.1;

    case 5
        temp_msg = ttTryFetch('control_signal');

        if ~isempty(temp_msg)
            data.temperatura = temp_msg.temperatura;
            data.umiditaTerreno = temp_msg.umiditaTerreno;
            data.umiditaAria = temp_msg.umiditaAria;
            data.potenza = temp_msg.potenza;

            disp(['Controllore: ho ricevuto la temperatura: ' num2str(data.temperatura) ...
                ', umidità aria: ' num2str(data.umiditaAria) ...
                ', umidità terreno: ' num2str(data.umiditaTerreno)]);

            msg.messaggio.temperatura = temp_msg.temperatura;
            msg.messaggio.umiditaTerreno = temp_msg.umiditaTerreno;
            msg.messaggio.umiditaAria = temp_msg.umiditaAria;
            msg.messaggio.potenza = temp_msg.potenza;
            msg.type = 'control_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('Controllore: errore non ho ricevuto i messaggi corretti...');
        end
        exectime = -1;     
               
end

