#!/usr/bin/env bash
cd "$(dirname "$0")"

chmod +x docmost/docmost-setup.sh
chmod +x checkmk/checkmk-setup.sh
chmod +x backup/restic/restic-setup.sh

sudo ./docmost/docmost-setup.sh
sudo ./checkmk/checkmk-setup.sh
sudo ./backup/restic/restic-setup.sh

echo
echo "Docmost: http://127.0.0.1:3000"
echo "Checkmk: http://127.0.0.1:5000/monitoring"
echo "  User: cmkadmin"
echo "  Passwort: admin"
