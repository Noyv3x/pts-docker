#!/usr/bin/env bash
set -euo pipefail

export PTS_SILENT_MODE=${PTS_SILENT_MODE:-1}
export MONITOR=${MONITOR:-all}
export PTS_CONCURRENT_TEST_RUNS=${PTS_CONCURRENT_TEST_RUNS:-2}

# 开关上传结果
if [ "${PTS_UPLOAD_RESULTS:-0}" = "1" ]; then
  export AUTO_UPLOAD_RESULT=1
fi

if [ $# -eq 0 ]; then
  echo "示例： docker run --privileged ghcr.io/<你>/pts-docker:latest benchmark openssl"
  exit 1
fi

# ---- 4. 切到源码根目录再启动，确保能找到 pts-core/ ----
cd "${PTS_DIR:-/opt/pts}"   # /opt/pts 是 Dockerfile 里克隆的位置
exec ./phoronix-test-suite "$@"