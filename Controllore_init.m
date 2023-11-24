function Controllore_init

ttInitKernel('prioFP');

ttCreateMailbox('temp_signal', 10);
ttCreateMailbox('umid_T_signal', 10);
ttCreateMailbox('umid_A_signal', 10);
%ttCreateMailbox('control_signal', 10);

ttSetKernelParameter('energyconsumption', 0.010);


nome_c = 'Task_Controllore';
deadline = 10;
funzione = 'Controllore_fnctn';

%Creazione del Task controllore
ttCreateTask(nome_c, deadline, funzione);


prio = 1;
ttSetPriority(prio, nome_c);

nome_hd = 'nw_handlerControllore';
funzione_hd = 'nethandlerControllore_fnctn';

ttCreateHandler(nome_hd, 1, funzione_hd);
ttAttachNetworkHandler(nome_hd);