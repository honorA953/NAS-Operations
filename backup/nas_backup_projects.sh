#!/bin/bash
# =====================================
# NAS Project Backup
# Version : 1.1
# Author  : A953
# =====================================

set -e
# 備份位置
BACKUP_ROOT="/volume1/99_系統備份/Projects"

# 保留天數
RETENTION_DAYS=30

# 日期
DATE=$(date +%Y%m%d_%H%M)
PROJECTS=(
    "都更管理系統:/volume1/10_公司內部專案/都更管理系統"
    "RAG:/volume1/docker/rag-schedule-system"
)