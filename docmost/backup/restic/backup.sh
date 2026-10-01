#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
export RESTIC_REPOSITORY="$PWD"
export RESTIC_PASSWORD="DeinPasswortHier"

VOL="/var/lib/docker/volumes"

restic backup \
  --tag docmost \
  "$VOL/docmost_caddy_data" \
  "$VOL/docmost_caddy_config" \
  "$VOL/docmost_docmost" \
  "$VOL/docmost_db_data" \
  "$VOL/docmost_redis_data" \
  "$VOL/docmost_monitoring" \
  "$VOL/metadata.db" \
  "/opt/omd/sites/monitoring"

restic forget --prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6
