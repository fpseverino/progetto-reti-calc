function[exectime, data] = nethandgat2_fnctn(segment, data)

temp = ttGetMsg(2);
%disp('Gateway: messaggio ricevuto...');
%disp('Contenuto di temp:');
%disp(['Tipo: ' temp.type]);
%disp(['Messaggio: ' temp.messaggio]);

ttTryPost(temp.type, temp.messaggio);

ttCreateJob('Task_Gateway2');


exectime = -1;
