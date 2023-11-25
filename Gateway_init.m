function Gateway_init

ttInitKernel('prioFP');

ttCreateMailbox('temp_signal', 10);
ttCreateMailbox('umid_T_signal', 10);
ttCreateMailbox('umid_A_signal', 10);


% creazione gateway
nome_g1 = 'Task_Gateway';
deadline = 0.010;
funzione1 = 'Gateway_fnctn';

% creazione del Task
ttCreateTask(nome_g1, deadline, funzione1);

prio = 1;
ttSetPriority(prio, nome_g1);

% creazione del network handler
nome_nh = 'nw_handlergat';
funzione_nh = 'nethandgat_fnctn';


ttCreateHandler(nome_nh, 1, funzione_nh);
ttAttachNetworkHandler(1, nome_nh);
