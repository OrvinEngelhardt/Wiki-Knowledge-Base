# Wiki/Knowledge Base
 Implementirung von Docmoste als Lern Projekt https://docmost.com/

## Beschreibe Sie ihr Projekt (selbstdefinierte Aufgabenstellung).
- Erst einrichtung der Docmoste Aplication
- Einrichten eines Revers Proxies wie in der Docmoste Dokumentation empfohlen
- Monitoring Lösung für Implementierung heraussuchen und einrichten
- Backup lösung Einrichten und Testen (RTO + RPO)
- Dockmoste für Nutzzweck Konfigurieren und Testen
- Automatisierung und Dokumentation des Deployments
  
## Was sind ihre Ziele (persönliche Motivation)?
- Testen einer Bestehende lösungen für Firmen Wikis/Knowledge Bases
- Übung für Abschluss Praxis Projekt
- Praxis Erfarung zu Proxies/Revers Proxies sammeln
- Vollständige Implementierung einer Neuen Software durchführen
- Dochmoste als mögliche Lösung für den eigenen Betrieb Testen
### Motivation

In meinem Jetzigen betrieb haben wir aktuell keine Richtige Knowledge Base für Abteilungs Internet Informationen und Dokumentationen.
Das machte es Schwierig sich in unbekannte System in der Firma heranzuarbeiten obwohl viel Dokumentation existiert. Viel von der Dokumentation ist sehr verstreut, einiges liegt in Word Datein anderes im Ticket system oder im Teams oder irgendwelchen Excel Tabellen. Das macht es sehr frustrierend wenn man sich irgendwo einarbeiten will und erstmal eine Halbe bis Dreiviertel Stunde nach info zu dem Thema suchen muss und sich am ende trotzdem nicht sicher ist ob man alles wichtige gefunden hat. Zusätzlich gibt es keinen einhaltlichen weg wie alles Dokummentiert ist und man muss vieles einfach wissen oder wissen wo es genau liegt.

Daher habe ich überlegt für mein Abschluss Projekt vielleicht eine Knowledge base zu implementieren. Hier will ich testen was da alles dazu gehört und ob Docmoste vieleicht schon eine gute Lösung ist.

Ich habe mich für Docmoste entschieden weil es Kostenlos und Onpremis ist. Das sind beides Sachen die meinem Betrieb sehr Wichtig sind.
Zusätzlich finde ich das Simple Design und andere Theatures wie das Arbeiten in MarkDown cool. Auch die Implementiereung eines Selfhosted AI-Search-Assistenten finde ich interessant. Die Implementierung über einen Docker Container wirk ersteinmal simpel und der Empfohlene Revers Proxi ist auch etwas womit ich gerne Rumspielen will.

## Welche Dienste sollen als Teil des Projektes integriert werden?
- Backup = restic (https://restic.net/)
- Monitoring = CheckMK (https://checkmk.com/de) (https://docs.checkmk.com/latest/de/introduction_docker.html)
- AI provider = Offen
- Deployment Automatiesierung = Dockerfile
- Revers Proxi = Caddy oder Treafik

## Erstellen Sie eine grobe Übersicht, wie die Architektur des Projekes aussehen sollen.
- Auf welcher Plattform soll das Projekt laufen? Welche Hardware wird benötigt? Welche Betriebsysteme werden genutzt?
  
- OS = Irgendein Linux Distroy (Wegen Docker eigendlich egal, aber wahrscheinlich Arch da ich es Privat nutze)
- Plattform = Docker/Podman (Ich möchte lieber Podman nutze habe damit aber noch keine erfahrung daher vielleicht doch Docker)

## Sollen einzelne Dienste virtualisiert werden? Falls ja, mit welchen Technologien?
Ja Projekt wird durch Docker/Podman virtualisiert.

## Welche Anleitungen (bzw. Tutorials) soll genutzt werden? Welche sonstige Dokumentation könnte nützlich sein?
- https://docmost.com/docs/
- https://docs.docker.com/
- https://podman.io/docs

## Deployment
Dockmost:
```bash
.yml
Docker compose up -d
```
CheckMk:
```bash
wget https://download.checkmk.com/checkmk/2.5.0p14/check-mk-community-2.5.0p14_0.trixie_amd64.deb
sudo apt install ./check-mk-community-2.5.0p14_0.trixie_amd64.deb
sudo omd create --admin-password 'PASSWORT' monitoring  #User cmkadmin
sudo omd config monitoring set APACHE_TCP_ADDR 0.0.0.0
sudo omd start monitoring #http://127.0.0.1:5000/monitoring
sudo apt install python3-dockersudo cp /omd/sites/monitoring/share/check_mk/agents/plugins/mk_docker.py /usr/lib/check_mk_agent/plugins/
sudo chmod 755 /usr/lib/check_mk_agent/plugins/mk_docker.py
```

Restic:
```bash
apt-get install restic
mkdir -p backup/restic
cd backup/restic
export RESTIC_REPOSITORY=./
export RESTIC_PASSWORD_FILE=~/.restic-pw
echo 'ein-langes-sicheres-passwort' > ~/.restic-pw && chmod 600 ~/.restic-pw
restic init
```



## Bewertung

### Backup

- [ ] Inkrementelle oder Differenzielle Backups
- [ ] Konfiguration des Monitoring wird gebackupt
- [ ] Ein Backup wurde erfolgreich zurückgespielt
- [ ] Backups werden automatisch erstellt
- [ ] Benachrichtigung, wenn automatische Erstellung von Backups fehlschlägt (optional mittels Monitoring)

### Monitoring

- [ ] Läuft
- [ ] Ram-Auslastung wird überwacht
- [ ] verbleibende freie Festplatenkapazität wird überwacht
- [ ] Erfolgreiche automatische Erstellung von Backups wird überwacht
- [ ] Im Fehlerfall werden Benachrichtigungen „versendet“

### Automatisierung

- [ ] Regelmäßige vollständige Updates gewährleisten
- [ ] Automatische Wiederherstellung möglich
- [ ] Lösung ermöglicht Review von Veränderungen (Change Management)
- [ ] Idempotente Anwendung der Konfigurationsverwaltung funktioniert fehlerfrei
- [ ] Mehrere Konfigurationen lassen sich miteinander kombinieren
- [ ] Ein einzelner Konfigurationsschritt kann einfach und sauber rückgängig gemacht werden

### Organisatorische Maßnahmen

- [ ] Planung
- [ ] Dokumentation
- [ ] Versionskontrolle
- [ ] …

### Bonus

- [ ] Virtualisierung, Containerisierung
- [ ] Dienste
- [ ] Skalierung
- [ ] Weitere Maßnahmen zur Steigerung der Verfügbarkeit
  - z.B. RAID, Netzwerkredundanz
