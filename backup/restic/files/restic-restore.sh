#!/usr/bin/env bash
# Aufruf: sudo restic-restore [snapshot-id]     (Standard: latest)
# ACHTUNG: Löscht die bestehenden Daten und ersetzt sie durch den Snapshot!
set -uo pipefail

set -a; . /etc/restic-backup.env; set +a

VOL="/var/lib/docker/volumes"
SITE="${CMK_SITE:-monitoring}"
SNAPSHOT="${1:-latest}"

read -r -p "Daten werden GELÖSCHT und aus Snapshot '$SNAPSHOT' wiederhergestellt. Fortfahren? (ja/nein): " A
[ "$A" = "ja" ] || { echo "Abgebrochen."; exit 1; }

omd stop "$SITE" 2>/dev/null || true
systemctl stop docker.socket docker || true
umount "/opt/omd/sites/$SITE/tmp" 2>/dev/null || true

rm -rf \
  "$VOL/docmost_caddy_data" \
  "$VOL/docmost_caddy_config" \
  "$VOL/docmost_docmost" \
  "$VOL/docmost_db_data" \
  "$VOL/docmost_redis_data" \
  "$VOL/docmost_monitoring" \
  "$VOL/metadata.db" \
  "/opt/omd/sites/$SITE" 2>/dev/null || true

restic restore "$SNAPSHOT" --target / --tag docmost

# tmp wurde vom Backup ausgeschlossen -> neu anlegen
if [ -d "/opt/omd/sites/$SITE" ]; then
  mkdir -p "/opt/omd/sites/$SITE/tmp"
  chown "$SITE:$SITE" "/opt/omd/sites/$SITE/tmp"
fi

systemctl start docker || true
omd start "$SITE" 2>/dev/null || true
echo "Restore abgeschlossen. Falls Container nicht starten: docker compose up -d"
