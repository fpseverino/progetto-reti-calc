function Generatore_di_potenza_init

ttInitKernel('prioFP');

nome_s = 'Task_Generatore_Potenza';
startTime = 0.0;
periodo = 1;
funzione = 'Generatore_Potenza_fnctn';

ttCreatePeriodicTask(nome_s, startTime, periodo, funzione);

prio = 1;
ttSetPriority(prio, nome_s);