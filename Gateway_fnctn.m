function[exectime, data] = Gateway_fnctn(segment, data)

switch segment
    case 1
        exectime = 0.002;
    case 2
        for nw = 1:2
            ttGetMsg(nw);
            % ciclo for per mandare i messaggi alla destinazione corretta
            if ~isempty(data.msg)
                ttSendMsg(data.msg.destination, data.msg, 512);
                exectime = exectime + 0.002;
            end
        end
    case 3
        exectime = -1;
end