#!/bin/bash
# DS220+ NAS - 每日 MariaDB 各專案 DB 備份
set -e

ROOT_PASSWORD_FILE="/root/.mariadb_root_password"
INTERNAL_PROJECTS_ROOT="/volume1/10_公司內部專案"
RETENTION_DAYS=30

PROJECTS=(
    "urban_renewal_db:都更管理系統"
)

DATE=$(date +%Y%m%d_%H%M)
ROOT_PASSWORD=$(head -1 "${ROOT_PASSWORD_FILE}")

for ENTRY in "${PROJECTS[@]}"; do
    DB="${ENTRY%%:*}"
    PROJECT="${ENTRY##*:}"
    DEST_DIR="${INTERNAL_PROJECTS_ROOT}/${PROJECT}/DB備份"
    DEST_FILE="${DEST_DIR}/${DB}_${DATE}.sql.gz"

    if [ ! -d "${DEST_DIR}" ]; then
        echo "[$(date)] WARNING: dest dir not found: ${DEST_DIR}"
        continue
    fi

    echo "[$(date)] Dumping ${DB} -> ${DEST_FILE}"
    docker exec mariadb mariadb-dump \
        -uroot -p"${ROOT_PASSWORD}" \
        --single-transaction \
        --quick \
        --skip-lock-tables \
        "${DB}" 2>/dev/null | gzip > "${DEST_FILE}"

    chown 1029:100 "${DEST_FILE}"

    find "${DEST_DIR}" -name "${DB}_*.sql.gz" -mtime +${RETENTION_DAYS} -delete
done

echo "[$(date)] All dumps completed."