#!/usr/bin/env bash
cd "$(dirname "$0")"

# 1. Checkmk installieren
wget -nc -P /tmp https://download.checkmk.com/checkmk/2.5.0p14/check-mk-community-2.5.0p14_0.trixie_amd64.deb
sudo apt install -y /tmp/check-mk-community-2.5.0p14_0.trixie_amd64.deb

# 2. Site anlegen (User: cmkadmin), nur wenn sie noch nicht existiert
omd sites | grep -qw monitoring || {
  sudo omd create --admin-password 'admin' monitoring
  sudo omd config monitoring set APACHE_TCP_ADDR 0.0.0.0
}
sudo omd start monitoring

# 3. Agent (nur das Paket der eigenen Architektur) und Docker-Plugin
sudo apt install -y python3-docker
sudo apt install -y /omd/sites/monitoring/share/check_mk/agents/check-mk-agent_*_$(dpkg --print-architecture).deb
sudo mkdir -p /usr/lib/check_mk_agent/plugins /usr/lib/check_mk_agent/local
sudo cp /omd/sites/monitoring/share/check_mk/agents/plugins/mk_docker.py /usr/lib/check_mk_agent/plugins/
sudo chmod 755 /usr/lib/check_mk_agent/plugins/mk_docker.py

# 4. Local Check für das Restic-Backup
sudo cp checkmk-restic-backup /usr/lib/check_mk_agent/local/restic-backup
sudo chmod 755 /usr/lib/check_mk_agent/local/restic-backup
