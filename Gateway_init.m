function Gateway_init

ttInitKernel('prioFP');

% creazione gateway
nome_g = 'Task_Gateway';
deadline = 10;
funzione = 'Gateway_fnctn';

% creazione del Task
ttCreateTask(nome_g, deadline, funzione);

% Task in ascolto
ttAttachNetworkHandler(1, nome_g);
ttAttachNetworkHandler(2, nome_g);
ttAttachNetworkHandler(3, nome_g);