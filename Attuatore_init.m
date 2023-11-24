function Attuatore_init

ttInitKernel('prioFP');

nome_c = 'Task_Attuatore';
deadline = 10;
funzione_c = 'Attuatore_fnctn';

ttCreateTask(nome_c, deadline, funzione_c);

prio = 1;
ttSetPriority(prio, nome_c);

nome_hd = 'nw_handlerAttuatore';
funzione_hd = 'nethandlerAtt_fnctn';

ttCreateHandler(nome_hd, 1, funzione_hd);
ttAttachNetworkHandler(nome_hd);