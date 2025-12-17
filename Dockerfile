ARG BUILD_FROM=ghcr.io/hassio-addons/base:11.0.0
FROM ${BUILD_FROM}

# Utiliser bash pour les scripts
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Installer dépendances système
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copier scripts et composants
COPY options.py /app/options.py
COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY custom_components /config/custom_components

# Copier le fichier options.yaml (valeurs par défaut)
COPY options.yaml /app/options.yaml

# Point d'entrée
CMD ["/run.sh"]
