ARG BUILD_FROM=ghcr.io/hassio-addons/base:11.0.0
FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        python3-pip && \
    pip3 install pyyaml && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY options.py /app/options.py
COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY custom_components /config/custom_components
COPY options.yaml /app/options.yaml
COPY app.py /app/app.py

CMD ["/run.sh"]
