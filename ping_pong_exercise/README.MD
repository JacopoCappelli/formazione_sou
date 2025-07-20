# Node Switcher Orchestrator con Vagrant e Docker

Questo progetto automatizza l'orchestrazione di due container Docker (`ealen/echo-server`) distribuiti su due macchine virtuali separate: una con Ubuntu e l'altra con Debian. L'ambiente è gestito tramite **Vagrant**, mentre l'orchestrazione è svolta da uno script Bash chiamato `node_switcher.sh`.

---

## 📁 Contenuto del progetto

- `Vagrantfile`: definisce e configura due VM con Docker preinstallato:
  - `ubuntu-node` (basata su Ubuntu 22.04)
  - `debian-node` (basata su Debian 11)

- `node_switcher.sh`: script Bash che alterna ogni 60 secondi l'esecuzione di un container Docker tra le due VM.
  - Il container su Ubuntu espone la porta `8080`
  - Il container su Debian espone la porta `8081`
  - Lo script registra tutto in un file di log giornaliero 
  - Se una delle due VM viene spenta, lo script si arresta automaticamente

---

## ⚙️ Prerequisiti

- [Vagrant](https://www.vagrantup.com/) installato sul sistema host
- [VirtualBox](https://www.virtualbox.org/) (o altro provider Vagrant compatibile)
- Sistema con shell Bash (`bash`, `grep`, `awk`, `cut`, ecc.)

---

## 🚀 Avvio dell'ambiente

1. Clona il repository o posizionati nella directory che contiene `Vagrantfile` e lo script.

2. Avvia le VM:
   vagrant up

3. Esegui lo script:
   ./node_switcher.sh


   

