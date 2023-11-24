function[exectime, data] = nethandgat_fnctn(segment, data)

temp = ttGetMsg(2);
disp('Gateway: messaggio ricevuto...');
disp(temp);

ttTryPost(temp.type, temp.msg);

ttCreateJob('Task_Gateway');

exectime = -1;
