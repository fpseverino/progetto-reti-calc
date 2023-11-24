function[exectime, data] = Attuatore_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('control_signal');

        if ~isempty(temp_msg)
            data.temperatura = temp_msg.temperatura;
            data.umiditaTerreno = temp_msg.umiditaTerreno;
            data.umiditaAria = temp_msg.umiditaAria;
            data.potenza = temp_msg.potenza;

            disp(['Attuatore: ho ricevuto la temperatura: ' num2str(data.temperatura) ...
                ', umidità aria: ' num2str(data.umiditaAria) ...
                ', umidità terreno: ' num2str(data.umiditaTerreno)]);
        else
            disp('Attuatore: errore non ho ricevuto i messaggi corretti...');
        end

        exectime = 0.02;

    case 2
        ttAnalogOut(1, data.temperatura);
        ttAnalogOut(2, data.umiditaAria);
        ttAnalogOut(3, data.umiditaTerreno);
        ttAnalogOut(4, data.potenza);

        exectime = -1;
end