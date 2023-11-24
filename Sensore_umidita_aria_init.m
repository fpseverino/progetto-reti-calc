function Sensore_umidita_aria_init

ttInitKernel('prioFP');

ttSetKernelParameter('energyconsumption', 0.010);

nome_s = 'Task_Sensore_Umidita_Aria';
startTime = 0.0;
periodo = 1;
funzione = 'Sensore_umidita_aria_fnctn';

ttCreatePeriodicTask(nome_s, startTime, periodo, funzione);

prio = 1;
ttSetPriority(prio, nome_s);