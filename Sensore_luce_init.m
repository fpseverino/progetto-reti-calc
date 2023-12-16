function Sensore_luce_init

ttInitKernel('prioFP');

funzione = 'sensore_luce_fnctn';
nome = 'Task_Sensore';
startTime = 0.0;
periodo = 1.0;

ttCreatePeriodicTask(nome, startTime, periodo, funzione);