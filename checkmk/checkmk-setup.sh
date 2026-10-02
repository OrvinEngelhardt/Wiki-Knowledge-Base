#!/usr/bin/env bash
# Aufruf: sudo bash checkmk-setup.sh
set -euo pipefail

[ "$EUID" -eq 0 ] || { echo "Bitte mit sudo ausführen." >&2; exit 1; }

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Local Check muss vorhanden und nicht leer sein
[ -s "$SRC/checkmk-restic-backup" ] || { echo "Fehlt oder leer: $SRC/checkmk-restic-backup" >&2; exit 1; }

# 1. Checkmk installieren
wget -nc -P /tmp https://download.checkmk.com/checkmk/2.5.0p14/check-mk-community-2.5.0p14_0.trixie_amd64.deb
apt install -y /tmp/check-mk-community-2.5.0p14_0.trixie_amd64.deb

# 2. Site anlegen (User: cmkadmin), nur wenn sie noch nicht existiert
omd sites | grep -qw monitoring || {
  omd create --admin-password 'admin' monitoring
  omd config monitoring set APACHE_TCP_ADDR 0.0.0.0
}
omd start monitoring || true   # http://127.0.0.1:5000/monitoring

# 3. Agent und Docker-Plugin
apt install -y python3-docker /omd/sites/monitoring/share/check_mk/agents/check-mk-agent_*.deb
mkdir -p /usr/lib/check_mk_agent/plugins /usr/lib/check_mk_agent/local
cp /omd/sites/monitoring/share/check_mk/agents/plugins/mk_docker.py /usr/lib/check_mk_agent/plugins/
chmod 755 /usr/lib/check_mk_agent/plugins/mk_docker.py

# 4. Local Check für das Restic-Backup
cp "$SRC/checkmk-restic-backup" /usr/lib/check_mk_agent/local/restic-backup
chmod 755 /usr/lib/check_mk_agent/local/restic-backup
