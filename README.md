--------------L6470 CONTROL GUI-----------------------------------------------------------------------------------------------------------------------------

QUESTO SISTEMA È PROGETTATO PER WINDOWS: Altri os potrebbero non funzionare.


FUNZIONALITA
|
-----Apertura porte seriali attraverso il pannello "Impostazioni porta seriale"
-----Generazione stringa sia con GUI che inserimento diretto (per schede L6470)
-----Apertura di file .txt per importare blocchi di stringhe (vedi UTILIZZO)
-----Possibilità di salvare ogni invio e ogni ricezione in file .txt appositi
	|
	------Visualizzazione diretta dei log ed eliminazione su comando dei file
	------Rigenerazione automatica dei file e della directory LOGS in cui vengono automaticamente depositati
-----Terminale integrato lanciabile con il pulsante apposito


INSTALLAZIONE
|
------Questo software è fornito in un file ZIP compresso. Basta eseguire le seguenti semplici istruzioni per la corretta installazione.
	|
	-Estrarre L6470GUI.zip in Documenti. Per raggiungere documenti: Questo PC > Documents
	-Il percorso dovrebbe essere tipo: C:/Utente/Documents/L6470GUI
		|
		------Se il percorso non dovesse essere questo dopo l'estrazione, creare manualmente in documenti la cartella "L6470GUI" e inserirci i file contenuti nello zip
			|
			-------Attenzione a:
				-Non avere L6470GUI/L6470GUI/.... perchè NON funzionerebbe. I file devono essere in Documenti/L6470GUI/.....
				-CAPS, o maiuscole: L6470GUI NON è L6470gui. Non troverebbe il percorso e alcune funzionalità si romperebbero.
	-Opzionale: creare un collegamento del software per accederci immediatamente: tasto destro su "main.exe" > Crea collegamento (Windows 10 e precedenti)
	-O su Windows 11 tasto destro su "main.exe" > Altre opzioni... > Crea collegamento (Windows 11)



UTILIZZO
|
------Perché qualsiasi operazione che involga una seriale possa essere eseguita, è NECESSARIO aprire la porta dopo aver settato i parametri
	|
	---------Se i parametri dovessero restare vuoti, si applicherebbero le seguenti impostazioni:
		|
		-Baudrate: 112500
		-Data bits: 8 (DATA8)
		-Stop bits: 1 (OneStop)
		-FlowControl: XON/XOFF (software)
		-Parity: None (NoParity)
	
	---------Ci sono due pulsanti: uno per chiudere la porta e un altro per aggiornare la lista di porte che il sistema operativo rileva.
------I file di testo devono avere NECESSARIAMENTE questa struttura (per garantirne il funzionamento):
	
MX.XXXX.XXXX
MX.XXXX.XXXX.XXXX
MX.XXXX

ALTRE CONFIGURAZIONI NON FUNZIONANO/NON GARANTISCONO IL CORRETTO INVIO DEI COMANDI SU SERIALE.
Un file di esempio (strings_example.txt) è fornito nello zip del software.

-------Per utilizzare il terminale, inserire la combinazione CTRL+T e poi CTRL+H per mostrare i comandi di aiuto (da li sarà il terminale a mostrare le opzioni)
	|
	----------IL TERMINALE POTREBBE NON ESSERE SETTATO CON GLI STANDARD PER LA L6470! 

ALTRO
|
--------Il codice sorgente del file è disponibile in ./src 
--------Questa è la versione 1.0, eventuali update verranno segnalati in changelog.txt con le modifiche e i fix della versione
--------L'eseguibile non richiede ne Python ne Qt Creator per funzionare, tuttavia sono necessari per la modifica dei file sorgente. Maggiori informazioni in ./src/.setup_environment/info.txt
