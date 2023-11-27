function[exectime, data] = Attuatore_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('temp_signal');

        if ~isempty(temp_msg)
            data.temperatura = temp_msg;
            ttAnalogOut(1, data.temperatura);
            %disp(['Attuatore: valore temperatura ricevuto: ' num2str(data.temperatura)]);
        else
            %disp('Attuatore: non ho ricevuto nessun valore...');
        end

        exectime = 0.02;
    case 2
        temp_msg = ttTryFetch('umid_A_signal');

        if ~isempty(temp_msg)
            data.umiditaT = temp_msg;
            ttAnalogOut(2, data.umiditaT);
            %disp(['Attuatore: valore umiditaT ricevuto: ' num2str(data.umiditaT)]);
        else
            %disp('Attuatore: non ho ricevuto nessun valore...');
        end

        exectime = 0.02;
    case 3
        temp_msg = ttTryFetch('umid_T_signal');

        if ~isempty(temp_msg)
            data.umiditaA = temp_msg;
            ttAnalogOut(3, data.umiditaA);
            %disp(['Attuatore: valore umiditaA ricevuto: ' num2str(data.umiditaA)]);
        else
            %disp('Attuatore: non ho ricevuto nessun valore...');
        end
        exectime = 0.02;
    case 4
        temp_msg = ttTryFetch('p_signal');

        if ~isempty(temp_msg)
            data.potenza = temp_msg;
            ttAnalogOut(4, data.potenza);
            %disp(['Attuatore: valore potenza ricevuto: ' num2str(data.potenza)]);
        else
            %disp('Attuatore: non ho ricevuto nessun valore...');
        end
        exectime = 0.02;

    case 5
        exectime = -1;
end