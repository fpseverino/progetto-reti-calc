function Gateway_init

ttInitKernel('prioFP');


ttCreateMailbox('temp_signal', 10);
ttCreateMailbox('umid_T_signal', 10);
ttCreateMailbox('umid_A_signal', 10);

% creazione gateway
nome_g = 'Task_Gateway';
deadline = 10;
funzione = 'Gateway_fnctn';

% creazione del Task
ttCreateTask(nome_g, deadline, funzione);
ttAttachNetworkHandler(2, nome_g);

% creazione del network handler
nome_nh = 'nw_handlergat';
funzione_nh = 'nethandgat_fnctn';

ttCreateHandler(nome_nh, 1, funzione_nh);
ttAttachNetworkHandler(1, nome_nh);