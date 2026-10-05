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
- Revers Proxi = Caddy (https://caddyserver.com/docs/quick-starts/reverse-proxy)



## Sollen einzelne Dienste virtualisiert werden? Falls ja, mit welchen Technologien?
Ja Projekt wird durch Docker/Podman virtualisiert.

## Welche Anleitungen (bzw. Tutorials) soll genutzt werden? Welche sonstige Dokumentation könnte nützlich sein?
- https://docmost.com/docs/
- https://docs.docker.com/
- https://podman.io/docs

## Deployment Plan
### Vorausetzungen:
- Ein Debian Basiertes Linux Distro

### Durchführung:
- Clone das Reposetory
- Sudo chmod +x setup-all.sh
- bash setup-all.sh
- Warten (Falls es hier zu fehler kommt, können die einzellen skrippte auch einzellt nach einander ausgeführt werden: setup-dockmost.sh -> setup-restic.sh -> setup-checkmk.sh)
- Fertig


## Bewertung

### Backup

- [x] Inkrementelle oder Differenzielle Backups
- [x] Konfiguration des Monitoring wird gebackupt
- [x] Ein Backup wurde erfolgreich zurückgespielt
- [x] Backups werden automatisch erstellt
- [ ] Benachrichtigung, wenn automatische Erstellung von Backups fehlschlägt (optional mittels Monitoring)

### Monitoring

- [x] Läuft
- [x] Ram-Auslastung wird überwacht
- [x] verbleibende freie Festplatenkapazität wird überwacht
- [x] Erfolgreiche automatische Erstellung von Backups wird überwacht
- [ ] Im Fehlerfall werden Benachrichtigungen „versendet“

### Automatisierung

- [x] Regelmäßige vollständige Updates gewährleisten
- [x] Automatische Wiederherstellung möglich
- [x] Lösung ermöglicht Review von Veränderungen (Change Management)
- [x] Idempotente Anwendung der Konfigurationsverwaltung funktioniert fehlerfrei
- [x] Mehrere Konfigurationen lassen sich miteinander kombinieren
- [ ] Ein einzelner Konfigurationsschritt kann einfach und sauber rückgängig gemacht werden

### Organisatorische Maßnahmen

- [x] Planung
- [x] Dokumentation
- [x] Versionskontrolle

### Bonus

- [x] Virtualisierung, Containerisierung
- [x] Dienste
- [ ] Skalierung
- [ ] Weitere Maßnahmen zur Steigerung der Verfügbarkeit
  - z.B. RAID, Netzwerkredundanz
