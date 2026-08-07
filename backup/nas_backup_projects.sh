#!/bin/bash
# =====================================
# NAS Project Backup
# Version : 1.1
# Author  : A953
# Description:
#   備份各專案原始碼
# =====================================

set -e

# ==========================
# 設定區
# ==========================

# 備份根目錄
BACKUP_ROOT="/volume1/99_系統備份/Projects"

# 保留天數
RETENTION_DAYS=30

# 日期
DATE=$(date +%Y%m%d_%H%M)

# 建立備份資料夾
mkdir -p "$BACKUP_ROOT"

# ==========================
# 專案清單
# 格式：
# "名稱:路徑"
# ==========================

PROJECTS=(
    "都更管理系統:/volume1/10_公司內部專案/都更管理系統"
    "RAG:/volume1/docker/rag-schedule-system"
)

echo "========================================="
echo "開始備份專案..."
echo "========================================="

# ==========================
# 開始備份
# ==========================

for ENTRY in "${PROJECTS[@]}"
do
    PROJECT_NAME="${ENTRY%%:*}"
    PROJECT_PATH="${ENTRY#*:}"

    echo ""
    echo "-----------------------------------------"
    echo "專案：$PROJECT_NAME"
    echo "路徑：$PROJECT_PATH"

    if [ ! -d "$PROJECT_PATH" ]; then
        echo "找不到資料夾，跳過..."
        continue
    fi

    OUTPUT_FILE="$BACKUP_ROOT/${PROJECT_NAME}_${DATE}.tar.gz"

    echo "建立備份..."

    tar \
        --exclude='.git' \
        --exclude='.venv' \
        --exclude='node_modules' \
        --exclude='__pycache__' \
        --exclude='*.log' \
        --exclude='*.tmp' \
        --exclude='dist' \
        --exclude='build' \
        -czf "$OUTPUT_FILE" \
        "$PROJECT_PATH"

    echo "完成：$OUTPUT_FILE"

done

echo ""
echo "========================================="
echo "刪除 ${RETENTION_DAYS} 天前備份..."
echo "========================================="

find "$BACKUP_ROOT" \
    -name "*.tar.gz" \
    -mtime +$RETENTION_DAYS \
    -delete

echo ""
echo "========================================="
echo "全部完成"
echo "========================================="