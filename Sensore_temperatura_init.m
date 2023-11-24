function Sensore_temperatura_init

ttInitKernel('prioFP');

ttSetKernelParameter('energyconsumption', 0.010);

% creazione del task sensore
nome_s = 'Task_Sensore_Temperatura';
startTime = 0.0;
periodo = 1;
funzione = 'Sensore_temperatura_fnctn';

% task periodico
ttCreatePeriodicTask(nome_s, startTime, periodo, funzione);

prio = 1;
ttSetPriority(prio, nome_s);
