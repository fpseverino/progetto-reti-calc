function[exectime, data] = Controllore_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('temp_signal');

        if ~isempty(temp_msg)
            data.temperatura = temp_msg;
            disp(['Controllore: valore temperatura ricevuto: ' num2str(data.temperatura)]);
        else
            disp('Controllore: non ho ricevuto nessun valore...');
        end

        exectime = 0.02;

    case 2
        temp_msg = ttTryFetch('umid_T_signal');

        if ~isempty(temp_msg)
            data.umiditaTerreno = temp_msg;
            disp(['Controllore: valore umidità terreno ricevuto: ' num2str(data.umiditaTerreno)]);
        else
            disp('Controllore: non ho ricevuto nessun valore...');
        end

        exectime = 0.02;

    case 3

        temp_msg = ttTryFetch('umid_A_signal');

        if ~isempty(temp_msg)
            data.umiditaAria = temp_msg;
            disp(['Controllore: valore umidità aria ricevuto: ' num2str(data.umiditaAria)]);
        else
            disp('Controllore: non ho ricevuto nessun valore...');
        end

        exectime = 0.02;

    case 4
        ttAnalogOut(1, data.temperatura);
        ttAnalogOut(2, data.umiditaTerreno);
        ttAnalogOut(3, data.umiditaAria);

        data.potenza = ttAnalogIn(1);

        msg.messaggio.temperatura = data.temperatura;
        msg.messaggio.umiditaTerreno = data.umiditaTerreno;
        msg.messaggio.umiditaAria = data.umiditaAria;

        msg.messaggio.potenza = data.potenza;
        msg.type = 'control_signal';
        ttSendMsg([3 10], msg, 80);

        exectime = -1;


end