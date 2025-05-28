ARG BASE=ubuntu:24.04
FROM ${BASE}

ENV DEBIAN_FRONTEND=noninteractive \
    PTS_DIR=/opt/pts \
    LANG=C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates git php-cli php-xml php-zip php-json build-essential \
      lm-sensors pciutils curl unzip && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://github.com/phoronix-test-suite/phoronix-test-suite.git ${PTS_DIR} && \
    ln -s ${PTS_DIR}/phoronix-test-suite /usr/local/bin/pts

# 禁止默认上传
COPY user-config.xml /etc/phoronix-test-suite/user-config.xml

RUN useradd -m -u 1000 pts
USER pts
WORKDIR /home/pts

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]