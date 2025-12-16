ARG BUILD_FROM=ghcr.io/hassio-addons/base:11.0.0
FROM ${BUILD_FROM}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    python3 \
    python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Script de validation des options (facultatif)
COPY options.py /app/options.py

# Script principal
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Si ton addon inclut des custom_components
# COPY custom_components /config/custom_components

CMD [ "/run.sh" ]