# 數位名片系統環境配置完整指南

## 概述

本專案包含三個主要組件，每個組件都需要適當的環境配置：

1. **Flutter 移動應用程式** (`mobile_app/`)
2. **Laravel 後端 API** (`backend/`)
3. **靜態網頁客戶端** (`web_client/`)

## 1. Laravel 後端配置

### 創建 .env 檔案

在 `backend/` 目錄下手動創建 `.env` 檔案：

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

### 重要配置說明

- **數據庫配置**: 需要先創建 MySQL 數據庫 `digital_business_card`
- **APP_KEY**: 運行 `php artisan key:generate` 後自動生成
- **CORS 配置**: 允許前端應用程式的跨域請求

## 2. Flutter 移動應用程式配置

### 配置文件位置

配置文件已創建在 `mobile_app/lib/config/app_config.dart`

### 主要配置項目

- **API 配置**: 指向 Laravel 後端
- **功能開關**: 控制各種功能的啟用/禁用
- **環境檢測**: 自動識別開發/測試/生產環境
- **權限配置**: 定義應用程式需要的權限

### 環境特定配置

#### 開發環境
```dart
static const bool isDevelopment = true;
static const bool enableDebugMode = true;
static const String apiBaseUrl = 'http://localhost:8000/api';
```

#### 生產環境
```dart
static const bool isDevelopment = false;
static const bool enableDebugMode = false;
static const String productionApiUrl = 'https://api.yourdomain.com';
```

## 3. 靜態網頁客戶端配置

### 配置文件

靜態網頁客戶端使用 JavaScript 配置文件，位於 `web_client/js/config.js`

### 主要配置

- **API 端點**: 指向 Laravel 後端
- **主題配置**: 控制頁面外觀
- **功能開關**: 控制各種功能的啟用/禁用

## 4. 環境設置步驟

### 步驟 1: 數據庫設置

```bash
# 創建 MySQL 數據庫
mysql -u root -p
CREATE DATABASE digital_business_card;
exit;

# 或使用 phpMyAdmin 創建數據庫
```

### 步驟 2: Laravel 後端設置

```bash
cd backend

# 安裝依賴
composer install

# 創建 .env 檔案（手動創建並複製配置）

# 生成應用程式密鑰
php artisan key:generate

# 運行數據庫遷移
php artisan migrate

# 啟動開發服務器
php artisan serve
```

### 步驟 3: Flutter 應用程式設置

```bash
cd mobile_app

# 安裝依賴
flutter pub get

# 檢查配置
flutter analyze

# 運行應用程式
flutter run
```

### 步驟 4: 靜態網頁客戶端設置

```bash
cd web_client

# 使用任何 HTTP 服務器啟動
# 例如：Python 內建服務器
python -m http.server 3000

# 或使用 Node.js http-server
npx http-server -p 3000
```

## 5. 生產環境配置

### Laravel 後端

```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://api.yourdomain.com
DB_HOST=your_production_db_host
DB_USERNAME=your_production_db_user
DB_PASSWORD=your_production_db_password
SESSION_SECURE_COOKIE=true
CORS_ALLOWED_ORIGINS=https://yourdomain.com
SANCTUM_STATEFUL_DOMAINS=yourdomain.com
```

### Flutter 應用程式

```dart
static const bool isDevelopment = false;
static const bool enableDebugMode = false;
static const String productionApiUrl = 'https://api.yourdomain.com';
static const String productionWebUrl = 'https://yourdomain.com';
```

## 6. 常見問題解決

### 問題 1: 數據庫連接失敗

**解決方案**:
- 檢查 MySQL 服務是否運行
- 確認數據庫名稱、用戶名和密碼
- 檢查防火牆設置

### 問題 2: CORS 錯誤

**解決方案**:
- 確認 `.env` 中的 `CORS_ALLOWED_ORIGINS` 設置
- 檢查前端應用程式的 URL 是否在允許列表中

### 問題 3: API 請求失敗

**解決方案**:
- 確認 Laravel 服務器正在運行
- 檢查 API URL 配置
- 查看 Laravel 日誌文件

### 問題 4: Flutter 編譯錯誤

**解決方案**:
- 運行 `flutter clean` 清理緩存
- 運行 `flutter pub get` 重新安裝依賴
- 檢查 Dart 語法錯誤

## 7. 安全注意事項

### 敏感信息保護

- 不要在代碼中硬編碼 API 密鑰
- 使用環境變數管理敏感配置
- 定期更新依賴包以修復安全漏洞

### 生產環境安全

- 啟用 HTTPS
- 設置適當的防火牆規則
- 定期備份數據庫
- 監控應用程式日誌

## 8. 監控和維護

### 日誌監控

- Laravel 日誌: `storage/logs/laravel.log`
- Flutter 日誌: 通過 IDE 或設備日誌查看
- 網頁客戶端: 瀏覽器開發者工具

### 性能監控

- 數據庫查詢性能
- API 響應時間
- 應用程式內存使用

### 備份策略

- 定期備份數據庫
- 備份應用程式代碼
- 備份配置文件

## 9. 更新和部署

### 代碼更新

1. 拉取最新代碼
2. 更新依賴包
3. 運行測試
4. 部署到目標環境

### 配置更新

1. 備份當前配置
2. 更新配置文件
3. 測試配置是否正確
4. 重啟相關服務

## 10. 聯繫和支持

如果在配置過程中遇到問題：

1. 檢查本文檔的常見問題部分
2. 查看相關組件的官方文檔
3. 檢查錯誤日誌
4. 在專案倉庫中提交 Issue

---

**注意**: 本配置指南適用於開發環境。生產環境部署時，請根據實際需求調整配置參數。
