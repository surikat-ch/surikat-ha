#!/usr/bin/env bash
set -euo pipefail

# Chemin vers le script options.py
OPTIONS_FILE="/app/options.yaml"

# Charger les options via Python
echo "Chargement des options..."
OPTIONS=$(python3 - <<END
from options import SurikatOptions
opts = SurikatOptions("$OPTIONS_FILE")
print(opts.all())
END
)

echo "Options chargées : $OPTIONS"

# Extraire les valeurs (exemple pour MQTT)
MQTT_HOST=$(echo "$OPTIONS" | python3 -c "import sys, yaml; print(yaml.safe_load(sys.stdin.read())['mqtt_host'])")
MQTT_PORT=$(echo "$OPTIONS" | python3 -c "import sys, yaml; print(yaml.safe_load(sys.stdin.read())['mqtt_port'])")
MQTT_TOPIC=$(echo "$OPTIONS" | python3 -c "import sys, yaml; print(yaml.safe_load(sys.stdin.read())['mqtt_topic'])")
MQTT_USER=$(echo "$OPTIONS" | python3 -c "import sys, yaml; print(yaml.safe_load(sys.stdin.read())['mqtt_user'])")
MQTT_PASSWORD=$(echo "$OPTIONS" | python3 -c "import sys, yaml; print(yaml.safe_load(sys.stdin.read())['mqtt_password'])")

echo "Connexion au broker MQTT : $MQTT_HOST:$MQTT_PORT, topic : $MQTT_TOPIC"

# Ici tu démarres ton service principal
# Par exemple si tu as un script Python principal app.py :
exec python3 /app/app.py \
    --mqtt_host "$MQTT_HOST" \
    --mqtt_port "$MQTT_PORT" \
    --mqtt_topic "$MQTT_TOPIC" \
    --mqtt_user "$MQTT_USER" \
    --mqtt_password "$MQTT_PASSWORD"
