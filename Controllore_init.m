function Controllore_init

ttInitKernel('prioFP');

ttSetKernelParameter('energyconsumption', 0.010);

nome_c = 'Task_controllore';
deadline = 10;
funzione = 'Controllore_fnctn';

%Creazione del Task controllore
ttCreateTask(nome_c, deadline, funzione);

ttAttachNetworkHandler(1, nome_c);