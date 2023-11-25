function[exectime, data] = Gateway2_fnctn(segment, data)

switch segment
    case 1
        exectime = 0.02;
    case 2
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
        exectime = 0.02;     
    case 3
        exectime = -1;
end