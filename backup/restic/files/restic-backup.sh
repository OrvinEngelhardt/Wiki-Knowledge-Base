#!/usr/bin/env bash
# BACKUP-PLAN: Mo=Full | Di=Inkrementell | Mi=Differenziell | Do=Inkrementell | Fr=Differenziell
# Aufbewahrung: 7 tägliche, 4 wöchentliche, 6 monatliche Snapshots
set -euo pipefail

: "${RESTIC_REPOSITORY:?RESTIC_REPOSITORY nicht gesetzt}"
: "${RESTIC_PASSWORD:?RESTIC_PASSWORD nicht gesetzt}"
export RESTIC_REPOSITORY RESTIC_PASSWORD

VOL="/var/lib/docker/volumes"
SITE="${CMK_SITE:-monitoring}"
DAY="${DAY_OVERRIDE:-$(date +%u)}"   # 1=Mo ... 7=So; zum Testen: DAY_OVERRIDE=3

CANDIDATES=(
  "$VOL/docmost_caddy_data"
  "$VOL/docmost_caddy_config"
  "$VOL/docmost_docmost"
  "$VOL/docmost_db_data"
  "$VOL/docmost_redis_data"
  "$VOL/docmost_monitoring"
  "$VOL/metadata.db"
  "/opt/omd/sites/$SITE"
)

PATHS=()
for p in "${CANDIDATES[@]}"; do
  if [ -e "$p" ]; then PATHS+=("$p"); else echo "Warnung: $p existiert nicht, übersprungen."; fi
done
[ "${#PATHS[@]}" -gt 0 ] || { echo "Keine Pfade zum Sichern gefunden." >&2; exit 1; }

case "$DAY" in
  1)   TYPE="full"; EXTRA=(--force) ;;
  3|5) TYPE="differential"
       FULL_ID="$(restic snapshots --tag full --latest 1 --json | jq -r '.[-1].short_id // empty')"
       if [ -n "$FULL_ID" ]; then EXTRA=(--parent "$FULL_ID"); else TYPE="full"; EXTRA=(--force); fi ;;
  *)   TYPE="incremental"; EXTRA=() ;;
esac

echo "$(date '+%F %T') Backup-Typ: $TYPE"

restic backup \
  --tag docmost --tag "$TYPE" \
  --exclude "/opt/omd/sites/$SITE/tmp" \
  ${EXTRA[@]+"${EXTRA[@]}"} \
  "${PATHS[@]}"

restic forget --prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6
