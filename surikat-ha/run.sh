#!/usr/bin/env bash
set -euo pipefail

OPTIONS_FILE="/app/options.yaml"

echo "Chargement des options..."
OPTIONS=$(python3 - <<END
from options import SurikatOptions
opts = SurikatOptions("$OPTIONS_FILE")
print(opts.all())
END
)

echo "Options chargées : $OPTIONS"

exec python3 /app/app.py
