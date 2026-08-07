#!/bin/bash

DATE=$(date +%Y%m%d_%H%M)
BACKUP_DIR="/volume1/99_系統備份/DockerCompose"

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/docker_compose_$DATE.tar.gz" \
/volume1/03_容器/_compose \
/volume1/10_公司內部專案/都更管理系統/容器設定 \
/volume1/docker/rag-schedule-system

echo "Docker Compose 備份完成"

find "$BACKUP_DIR" -name "*.tar.gz" -mtime +30 -delete