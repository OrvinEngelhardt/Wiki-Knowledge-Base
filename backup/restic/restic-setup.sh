#!/usr/bin/env bash
# Aufruf:   sudo bash setup.sh
# Optional: sudo REPO=/var/backups/restic PASSWORT=meinpasswort CMK_SITE=monitoring bash setup.sh
set -euo pipefail

[ "$EUID" -eq 0 ] || { echo "Bitte mit sudo ausführen." >&2; exit 1; }

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES="$SRC/files"
REPO="${REPO:-$SRC}"
PASSWORT="${PASSWORT:-DeinPasswortHier}"
CMK_SITE="${CMK_SITE:-monitoring}"

# Alle benötigten Dateien vorhanden?
for f in restic-backup.sh restic-restore.sh restic-backup.service restic-backup.timer; do
  [ -f "$FILES/$f" ] || { echo "Fehlt: $FILES/$f" >&2; exit 1; }
done

# 1. Pakete
apt install -y restic jq

# 2. Env-Datei (enthält gerätespezifische Werte)
mkdir -p "$REPO"
cat > /etc/restic-backup.env << EOF
RESTIC_REPOSITORY=$REPO
RESTIC_PASSWORD=$PASSWORT
XDG_CACHE_HOME=/var/cache
CMK_SITE=$CMK_SITE
EOF
chmod 600 /etc/restic-backup.env

# 3. Repository nur anlegen, falls noch keins existiert
set -a; . /etc/restic-backup.env; set +a
restic cat config >/dev/null 2>&1 || restic init

# 4. Dateien kopieren
cp "$FILES/restic-backup.sh"      /usr/local/sbin/restic-backup
cp "$FILES/restic-restore.sh"     /usr/local/sbin/restic-restore
cp "$FILES/restic-backup.service" /etc/systemd/system/restic-backup.service
cp "$FILES/restic-backup.timer"   /etc/systemd/system/restic-backup.timer

# 5. Rechte setzen
chmod 755 /usr/local/sbin/restic-backup /usr/local/sbin/restic-restore
chmod 644 /etc/systemd/system/restic-backup.service /etc/systemd/system/restic-backup.timer

# 6. systemd aktivieren
systemctl daemon-reload
systemctl enable --now restic-backup.timer

echo
echo "Setup abgeschlossen. Repository: $REPO"
systemctl list-timers restic-backup.timer --no-pager
echo "Test: sudo systemctl start restic-backup.service"
