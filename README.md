# progetto-reti-calc
Corso di Reti di Calcolatori UNIKORE A.A. 2023/2024 - Progetto di fine semestre

## Simulazione di serra intelligente in Simulink e TrueTime

### Abstract:
Il progetto prevede la creazione di un modello MATLAB/Simulink, utilizzando il simulatore TrueTime, che replica il funzionamento dei dispositivi di una serra intelligente, connessi fra di loro con connessioni cablate e wireless.
I dispositivi facenti parte della simulazione sono: sensori di umidità del terreno, umidità dell’aria e temperatura; un controllore, che attraverso la logica _fuzzy_, analizza i dati dei sensori; un attuatore che con tecniche di _MBSD_ interviene sui valori; un gateway che gestisce la comunicazione fra tutti i dispositivi.
Le _performance metrics_ misurate sono: response time, reaction time e throughput, più i fattori derivati da esse.

### I. INTRODUZIONE
Nel panorama agricolo contemporaneo, l'evoluzione delle tecnologie avanzate ha svolto un ruolo catalizzatore nella trasformazione del settore, dando origine a nuovi paradigmi come l'agricoltura intelligente e sostenibile. Questa evoluzione ha generato un interesse crescente per soluzioni innovative che integrino la connettività avanzata e la simulazione in tempo reale per migliorare l'efficienza operativa e la sostenibilità ambientale delle pratiche agricole.
Il contesto simulato dal progetto è quello di una serra intelligente, e della rete di sensori, controllori e attuatori volti a migliorare la gestione delle risorse agricole, ottimizzando l'ambiente della serra per massimizzare la produzione e garantire una crescita sostenibile delle colture.
Il progetto proposto è stato realizzato utilizzando l’ambiente di sviluppo MATLAB/Simulink e sfruttando la libreria TrueTime, un simulatore per i sistemi di controllo real-time.
Nella sezione II verrà affrontato l’approccio oggetto del lavoro, descrivendo l’architettura del progetto e gli algoritmi e metodologie di controllo utilizzati; nella sezione III verrà presentato lo scenario della serra intelligente e come è stato simulato in MATLAB/Simulink/TrueTime; nella sezione IV verranno mostrati i risultati della valutazione delle performance del sistema; nella sezione V infine verranno tratte le conclusioni del lavoro svolto.

### II. APPROCCIO PROPOSTO
Nel progetto vengono utilizzate due tipologie di connessione: wireless, con lo standard IEEE 802.15.4 _ZigBee_, e cablata, con il protocollo CSMA/CD.
Nelle reti 1 e 2, composte rispettivamente dai sensori per la lettura dei dati e dal controllore per la gestione della potenza, la comunicazione è principalmente in wireless, mentre nella rete 3, dove è presente l’attuatore per la modifica e l’aggiornamento dei valori di ingresso, la comunicazione è esclusivamente via cavo.
Le tre reti hanno come centro comune il gateway, che in tutte è il nodo numero 4. Le reti si compongono nel seguente modo:
1. **Rete dei sensori:**
   1. **Sensore temperatura**: rappresenta nella rete il nodo 1. Misura la temperatura in un range 10/45 °C, consuma una potenza di 10 mW/h, e contiene una batteria di 10.000 mA, che viene consumata in modo sostenuto grazie all’utilizzo del generatore di potenza.
   2. **Sensore umidità dell’aria**: rappresenta nella rete il nodo 3. Misura l’umidità dell’aria in un range del 30/90%, consuma una potenza di 10 mW/h, e contiene una batteria di 10.000 mA, che viene consumata in modo sostenuto grazie all’utilizzo del generatore di potenza.
   3. **Sensore umidità del terreno**: rappresenta nella rete il nodo 2. Misura l’umidità del terreno in un range del 30/90% consuma una potenza di 10 mW/h, e contiene una batteria di 10.000 mA, che viene consumata in modo sostenuto grazie all’utilizzo del generatore di potenza.
   4. **Generatore di potenza**:  collegato in modo wired, rappresenta nella rete il nodo 5. Ha in ingresso il valore di corrente (un segnale sinusoidale di ampiezza 0.05A) e tensione (segnale sinusoidale di ampiezza 18 V e sfasamento di π/2), dà in uscita una potenza calcolata come prodotto di tensione e corrente, che andrà trasmessa ad ogni sensore della rete.
2. **Rete del controllore:**
   1. **Controllore**: rappresenta nella rete il nodo 2. Ha lo scopo di dare una potenza in uscita, in base al valore della temperatura e a un valore calcolato da un controllore _fuzzy_ dalle due umidità. Possiede una batteria di 50.000 mA e consuma una potenza di 0,04 W/h.
3. **Rete dell'attuatore:**
   1. **Attuatore**: rappresenta nella rete il nodo 1. Ha lo scopo di modificare, in base al valore di potenza ricevuto, i valori di temperatura, umidità del terreno e umidità dell’aria in modo da portarli all’incirca a valori nominali. La potenza possiede una duplice valenza, in base ad essa imposta un flag di irrigazione, e tramite tecniche di _MBSD_ permette l'irrigazione automatica. C’è un ulteriore valore, che può essere settato in caso di valori estremi, che attiva un allarme in modo da riportare al livello 5 l’irrigazione.
4. **Centro rete:**
   1. **Gateway**: è su un punto di incontro comune per far in modo che i dati passino attraverso le tre reti, rappresentato in ognuna di esse con il nodo 4. Viene utilizzato un centro comune per trasmettere i dati in modo da semplificare la comunicazione, rendendo più fluido ed efficiente il sistema.

La comunicazione tra le reti avviene tramite il seguente schema:

![Schema delle 4 reti]()

### III. SCENARIO
Nell’implementazione in MATLAB/Simulink/TrueTime abbiamo tradotto lo schema presentato precedentemente nel seguente modo:

![Schema Simulink]()

Come si può vedere, la rete 1 dei sensori inizia con un generatore di potenza collegato ai sensori, i quali inviano i dati letti al gateway, che inoltrerà i dati al controllore, che in base ai dati ricevuti sceglierà una potenza e la comunicherà al gateway. Infine il gateway inoltra l’intero pacchetto dei dati all’attuatore che realizzerà le modifiche desiderate.

Nel dettaglio il funzionamento del sistema si può suddividere in 4 livelli:
1. **Livello 1 - Sensori**:
Il primo livello è gestito da tre sensori wireless che prendono in input tramite un _Uniform Random Number_ dei valori casuali di temperatura, umidità dell’aria e umidità del terreno. Essendo sensori wireless, ognuno di loro ha una batteria, con una certa energia iniziale, che verrà consumata nel tempo. Ogni sensore ha un TrueTime Kernel che sceglie il consumo del sensore (nel nostro caso di 10 mW/h) e crea una _MailBox_ di nome _“power_signal”_ per ricevere da un generatore di potenza un valore di potenza. Il generatore di potenza è un componente della rete 1 ed è collegato ai sensori tramite un collegamento cablato; esso ha in ingresso una tensione e una corrente e tramite il prodotto delle due componenti calcola la potenza da mandare a ogni singolo sensore della rete.
Ogni sensore implementa tramite una _subsystem_ la gestione della potenza che andrà sottratta alla potenza che va in ingresso alla batteria del sensore. Questa gestione della potenza viene realizzata tramite un controllore a logica _fuzzy_, che che prende in input la potenza data dal kernel e la potenza che manda il generatore di potenza, in modo da farne una stima. Questa potenza stimata andrà in ingresso a una funzione MATLAB, che in base al suo valore dà in uscita una nuova potenza sottoposta a un’amplificazione data da impulsi di durata estremamente breve, in modo da non superare mai il valore di 0.09 che è il massimo valore che possiamo sottrarre. Il risultato di questa operazione è una batteria che dura di più nel tempo.
Ogni sensore esegue un task periodico di periodo 1, durante il quale riceve un messaggio contenente il dato letto e che mostra tramite uno _scope_. Il tempo di esecuzione di questa operazione è molto breve: 0.03 secondi. Dopo di che il sensore prende il messaggio ricevuto, setta il _type_ con il suo tipo specifico e manda l’intero pacchetto dati al gateway. Questa operazione impiega 0.02 secondi per essere eseguita. In questo frangente, prima di mandare al gateway il pacchetto dati, il sensore segna il tempo corrente dell’esecuzione che servirà in seguito per calcolare il reaction time.

![Rappresentazione di un sensore in MATLAB/Simulink/TrueTime.]()

2. **Livello 2 - Gateway**:
Il secondo livello è quello del gateway: esso è collegato a tutte le reti, ha il compito di inoltrare dati in modo da facilitare la comunicazione tra i vari componenti del sistema.
Il gateway crea 4 _MailBox_ dove inserire i dati, una per ogni sensore e una relativa alla gestione della potenza del controllore. 
Esegue due task separati con funzionalità diverse: infatti la prima funzione del gateway è quella di leggere i dati inviati dal sensore, di verificare quanti pacchetti sono stati inviati da ogni sensore in determinati intervalli temporali e inoltrare al controllore l’intero pacchetto dati in modo che potrà svolgere la sua funzionalità. La seconda funzione del gateway è quella di ricevere il pacchetto dati dal controllore insieme alla potenza scelta e di inoltrare il tutto all’attuatore. Anch’esso verificherà quanti pacchetti sono stati recapitati in determinati istanti di tempo.

3. **Livello 3 - Controllore**:
Il terzo livello del sistema è il controllore wireless: esso ha la funzionalità di prendere in ingresso i dati inviati dal gateway e utilizzarli in modo da scegliere una potenza adatta alla situazione in tempo reale.
Esegue un solo task, il quale recupera i dati inviati dal gateway e tramite due controllore a logica _fuzzy_ in cascata sceglie la potenza da inoltrare al gateway; il primo controllore a logica _fuzzy_ calcola una stima tra l’umidità dell’aria e l’umidità del terreno che andrà in input a un secondo controllore _fuzzy_ che riceve in input anche il valore della temperatura.
In base ai dati ricevuti, il controllore sceglie una potenza e inoltra l’intero pacchetto dati al gateway, impostando il _type_ in modo da eseguire il secondo task del gateway.

![Grafico control surface del controllore fuzzy.]()

![Rappresentazione del controllore in MATLAB/Simulink/TrueTime.]()

4. **Livello 4 - Attuatore**:
Il quarto livello del sistema è quello dell’attuatore. È un componente Ethernet che utilizza il protocollo CSMA/CD. Riceve i dati inoltrati dal gateway e con una funzione MATLAB, sulla base della potenza ricevuta in ingresso, modifica il valore della temperatura, dell’umidità dell’aria e dell’umidità del terreno in modo da portarli a livelli nominali. La modifica avviene sottraendo al valore di ingresso la potenza ricevuta moltiplicata per determinate costanti. 
Un’ulteriore compito dell’attuatore è quello di gestire l'irrigazione automatica. Il flag di irrigazione settato dall’attuatore viene utilizzato tramite tecniche di _MBSD_ in uno _state chart_, che lo usa per modificare il valore di irrigazione. All’interno dello state chart troviamo due sistemi che lavorano in parallelo: uno è quello che gestisce l'irrigazione aumentando, diminuendo o mantenendo stabile il valore dell’irrigazione, compreso tra 0 e 10; l’altro blocco informa l’utente, in base al valore di una variabile interna, in caso di errore, infatti, quando il sistema tenta di salire sopra il valore massimo o scendere al di sotto del valore minimo, questa variabile informa l’utente dell’avvenimento dell’errore, accendendo una lampada e riportando il valore dell’irrigazione a 5.

![Rappresentazione dell’attuatore in MATLAB/Simulink/TrueTime.]()

![State chart che governa il sistema di irrigazione.]()

### IV. VALUTAZIONE DELLE PERFORMANCE
Sono state eseguite tre distinte simulazioni del modello, con una durata di 600 secondi ciascuna, modificando opportunamente il _seed_ dei generatori di valori randomici in ogni simulazione (rispettivamente uguale a  0, 5 e 10). I risultati di ciascuna _performance metric_ misurata coincidono in ognuna delle tre simulazioni.

Di seguito vengono riportati i risultati di ogni performance metric:
- **Response time**: Il response time è stato misurato utilizzando la funzione di TrueTime _ttCreateLog_. Di seguito i risultati per ogni task:
  - _Sensore umidità dell’aria_: costante a 0,05 sec
  - _Sensore umidità del terreno_: costante a 0,05 sec
  - _Sensore temperatura_: costante a 0,05 sec
  - _Gateway_: ![Grafico Response time del Gateway]()
  - _Gateway2_: costante a 0,03 sec
  - _Controllore_: ![Grafico Response time del Controllore]()
  - _Attuatore_: ![Grafico Response time dell'Attuatore]()
- **Reaction time dei sensori**: Il reaction time dei tre sensori, misurato facendo la differenza tra l’istante in cui il controllore inizia l’esecuzione di una richiesta e quello in cui il sensore la invia, risulta essere periodico per tutta la durata della simulazione. Le ampiezze in secondi sono diverse per ciascun sensore, come si può notare dai grafici a seguire, ma ciascuna di esse è costante nel tempo, ovvero senza smorzamenti o accrescimenti.

![Grafico Reaction time (sensore di temperatura)]()

![Grafico Reaction time (sensore umidità dell'aria)]()

![Grafico Reaction time (sensore umidità del terreno)]()

- **Stretch factor**: Nelle simulazioni di questo progetto non vi è peggioramento delle prestazioni, in quanto il reaction time è periodico e non è soggetto a carichi di diversa entità.
- **Throughput del gateway**: È stato misurato il numero di pacchetti ricevuti e mandati dal gateway, stampando un messaggio sulla console per ciascuno di essi, durante tre intervalli di 5 secondi all’inizio, a metà e alla fine della simulazione. I risultati nei tre intervalli sono identici, pertanto il throughput è costante. Tutti i pacchetti hanno una dimensione di 10 byte.
Nell’intervallo di 5 secondi il gateway riceve 5 pacchetti da ogni sensore e 45 pacchetti dal controllore, il throughput in ingresso è quindi di 120 byte/sec. Nello stesso intervallo manda 15 pacchetti al controllore e 45 all’attuatore, quindi il throughput in uscita è sempre di 120 byte/sec.

![Grafico Pacchetti mandati e ricevuti in 5 secondi]()

- **Nominal capacity**: Nel contesto di questo progetto e di questa simulazione ideale, la nominal capacity, ovvero la bandwidth, coincide con il throughput.
- **Usable capacity**: Quanto detto per la nominal capacity vale, in questa simulazione ideale, anche per la usable capacity.
- **Efficienza**: L’efficienza, ovvero il rapporto fra nominal capacity e usable capacity, in questa simulazione ideale, è di 1 a 1.

### V. CONCLUSIONI
Il lavoro svolto ha proposto una simulazione di una serra intelligente, utilizzando MATLAB/Simulink e TrueTime. L'implementazione delle reti cablate e wireless, insieme ad algoritmi di controllo basati su logica _fuzzy_ e _MBSD_, ha permesso di creare un modello quanto più completo e realistico per la gestione accurata delle risorse agricole.

Il sistema proposto ha dimostrato una buona stabilità e coerenza nelle simulazioni, con risultati consistenti in diverse condizioni. Le misurazioni di performance, come response time, reaction time e throughput, indicano un funzionamento efficiente e reattivo del sistema.

Per quanto riguarda le future direzioni, il modello potrebbe essere ampliato per includere ulteriori parametri ambientali e diverse tipologie di coltivazioni. L'integrazione di dati da sensori in una serra reale potrebbe contribuire a rendere il modello più accurato e adattabile alle condizioni del mondo reale.

In sintesi, il lavoro offre una base solida per ulteriori studi nel campo delle reti di calcolatori, fornendo un modello pratico e flessibile per la gestione ottimizzata in ambiente di serre intelligenti, con un particolare focus sulla misurazione delle performance.

### BIBLIOGRAFIA
Tutti i riferimenti bibliografici, utilizzati nelle sezioni precedenti.

1. Anton Cervin, Dan Henriksson, Martin Ohlin, [_“TrueTime 2.0 - Reference Manual”_](http://archive.control.lth.se/media/Research/Tools/TrueTime/report_2016-02-10.pdf), Department of Automatic Control, Lund University, February 2016 
