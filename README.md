# NAS-Operations

## 專案介紹

NAS-Operations 是一套針對 Synology NAS 建立的維運工具。

目前主要功能：

- MariaDB 自動備份
- Docker Compose 備份
- 每日整合備份
- Snapshot 搭配使用

---

## 系統環境

NAS：Synology DS220+

DSM：7.x

Docker：Container Manager

Database：MariaDB 11.4

---

## 目前功能

### 資料庫備份

使用：

- mariadb-dump

每日自動備份

保留 30 天

---

### Docker Compose 備份

備份：

- docker-compose.yml

保留 30 天

---

### Snapshot

每天建立 Snapshot

搭配檔案還原

---

## 專案結構

```
NAS-Operations
│
├── backup
│   ├── nas_backup_db.sh
│   └── nas_backup_compose.sh
│
└── README.md
```

---

## 待完成

- [ ] Project Backup
- [ ] Restore
- [ ] Health Check
- [ ] Backup Verify
- [ ] Dashboard
- [ ] AI Assistant