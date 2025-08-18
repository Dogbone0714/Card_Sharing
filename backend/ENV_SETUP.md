# 環境配置設置指南

## 創建 .env 檔案

請在 `backend/` 目錄下手動創建 `.env` 檔案，並複製以下內容：

```env
APP_NAME="數位名片系統"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8000

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=digital_business_card
DB_USERNAME=root
DB_PASSWORD=

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_APP_NAME="${APP_NAME}"
VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"

# 數位名片系統特定配置
BUSINESS_CARD_QR_SIZE=300
BUSINESS_CARD_QR_FORMAT=svg
BUSINESS_CARD_PUBLIC_URL=https://yourdomain.com/card
BUSINESS_CARD_API_RATE_LIMIT=60

# 文件上傳配置
MAX_FILE_SIZE=2048
ALLOWED_IMAGE_TYPES=jpg,jpeg,png,gif,webp
AVATAR_STORAGE_PATH=avatars
QR_CODE_STORAGE_PATH=qr_codes

# 安全配置
SESSION_SECURE_COOKIE=false
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://localhost:8080
SANCTUM_STATEFUL_DOMAINS=localhost:3000,localhost:8080

# 緩存配置
CACHE_PREFIX=digital_business_card_
CACHE_TTL=3600

# 日誌配置
LOG_MAX_FILES=30
LOG_DAYS=14
```

## 重要配置說明

### 1. 數據庫配置
- `DB_DATABASE`: 數據庫名稱（需要先創建）
- `DB_USERNAME`: 數據庫用戶名
- `DB_PASSWORD`: 數據庫密碼

### 2. 應用程序配置
- `APP_URL`: 後端 API 的基礎 URL
- `APP_KEY`: 運行 `php artisan key:generate` 後自動生成

### 3. 數位名片系統配置
- `BUSINESS_CARD_PUBLIC_URL`: 名片公開頁面的基礎 URL
- `BUSINESS_CARD_QR_SIZE`: QR Code 的尺寸
- `BUSINESS_CARD_QR_FORMAT`: QR Code 的格式（svg 或 png）

### 4. 安全配置
- `CORS_ALLOWED_ORIGINS`: 允許跨域請求的來源
- `SANCTUM_STATEFUL_DOMAINS`: Sanctum 認證允許的域名

## 設置步驟

1. 在 `backend/` 目錄下創建 `.env` 檔案
2. 複製上述配置內容到 `.env` 檔案
3. 根據您的環境修改相關配置
4. 運行 `php artisan key:generate` 生成應用程序密鑰
5. 運行 `php artisan migrate` 創建數據庫表

## 生產環境配置

部署到生產環境時，請修改以下配置：

```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://yourdomain.com
DB_HOST=your_production_db_host
DB_USERNAME=your_production_db_user
DB_PASSWORD=your_production_db_password
SESSION_SECURE_COOKIE=true
CORS_ALLOWED_ORIGINS=https://yourdomain.com
SANCTUM_STATEFUL_DOMAINS=yourdomain.com
```
