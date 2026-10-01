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
yml
CheckMk
wget https://download.checkmk.com/checkmk/2.5.0p14/check-mk-community-2.5.0p14_0.trixie_amd64.deb
sudo apt install ./check-mk-community-2.5.0p14_0.trixie_amd64.deb
sudo omd create monitoring
sudo omd start monitoring
