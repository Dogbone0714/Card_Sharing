# 數位名片 & QR Code 分享系統

一個完整的數位名片解決方案，包含Flutter移動應用、Laravel後端API和現代化Web客戶端。

## 🚀 功能特色

### 移動應用 (Flutter)
- 📱 創建和編輯個人數位名片
- 🔍 QR Code掃描功能
- 💾 一鍵保存聯絡人到手機
- 🎨 多種名片樣式主題
- 📤 分享名片功能
- 🔐 用戶認證和個人資料管理

### 後端API (Laravel)
- 🏗️ RESTful API設計
- 🔐 Laravel Sanctum認證
- 📊 名片數據管理
- 🎯 QR Code生成
- 🗄️ 數據庫優化
- 🔒 隱私和安全控制

### Web客戶端
- 🌐 響應式設計
- 🎨 現代化UI/UX
- 📱 移動端優化
- 🚀 快速載入
- 🎭 多種主題樣式
- 📊 作品集展示

## 🛠️ 技術架構

### 前端技術
- **Flutter**: 跨平台移動應用開發
- **HTML5/CSS3**: 現代化Web標準
- **JavaScript (ES6+)**: 互動功能和動畫
- **Font Awesome**: 圖標庫
- **Google Fonts**: 字體優化

### 後端技術
- **Laravel 10**: PHP框架
- **MySQL/PostgreSQL**: 數據庫
- **Laravel Sanctum**: API認證
- **Simple QR Code**: QR Code生成
- **RESTful API**: 標準化接口

### 開發工具
- **Composer**: PHP依賴管理
- **Flutter SDK**: 移動開發工具
- **Git**: 版本控制
- **VS Code**: 推薦開發環境

## 📁 項目結構

```
Card-Share/
├── mobile_app/                 # Flutter移動應用
│   ├── lib/
│   │   ├── screens/           # 應用屏幕
│   │   ├── models/            # 數據模型
│   │   └── services/          # API服務
│   ├── pubspec.yaml           # Flutter依賴配置
│   └── README.md              # 移動應用說明
├── backend/                    # Laravel後端
│   ├── app/
│   │   ├── Http/Controllers/  # API控制器
│   │   └── Models/            # 數據模型
│   ├── database/migrations/   # 數據庫遷移
│   ├── routes/api.php         # API路由
│   └── composer.json          # PHP依賴配置
├── web_client/                 # Web客戶端
│   ├── index.html             # 主頁面
│   ├── styles.css             # 樣式文件
│   └── script.js              # JavaScript功能
└── README.md                  # 項目說明
```

## 🚀 快速開始

### 1. 移動應用 (Flutter)

```bash
cd mobile_app
flutter pub get
flutter run
```

**系統要求:**
- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio / Xcode

### 2. 後端API (Laravel)

```bash
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
```

**系統要求:**
- PHP 8.1+
- Composer
- MySQL/PostgreSQL
- Laravel 10

### 3. Web客戶端

```bash
cd web_client
# 使用任何HTTP服務器，例如:
python -m http.server 8000
# 或
php -S localhost:8000
```

## 📱 移動應用功能詳解

### 主要屏幕
1. **首頁**: 歡迎界面和快速操作
2. **掃描**: QR Code掃描器
3. **我的名片**: 個人名片管理和QR Code生成
4. **個人資料**: 用戶設置和偏好

### 核心功能
- **名片創建**: 完整的表單驗證和數據管理
- **QR掃描**: 相機權限和掃描結果處理
- **聯絡人保存**: 系統聯絡人API整合
- **主題切換**: 多種視覺風格選擇

## 🌐 後端API文檔

### 認證端點
```
POST /api/register    # 用戶註冊
POST /api/login       # 用戶登入
```

### 名片端點
```
GET    /api/cards           # 獲取用戶名片列表
POST   /api/cards           # 創建/更新名片
GET    /api/cards/{id}      # 獲取特定名片
PUT    /api/cards/{id}      # 更新名片
DELETE /api/cards/{id}      # 刪除名片
GET    /api/cards/{id}/scan # 掃描名片
GET    /api/cards/{id}/qr   # 獲取QR Code
```

### 數據模型
```php
BusinessCard {
    id: string,
    user_id: string,
    name: string,
    title: string,
    company: string,
    email: string,
    phone: string,
    website: string,
    avatar: string,
    bio: string,
    social_links: array,
    custom_fields: object,
    theme: string,
    is_public: boolean
}
```

## 🎨 Web客戶端特色

### 設計亮點
- **漸變背景**: 現代化的視覺效果
- **卡片設計**: Material Design風格
- **響應式佈局**: 適配所有設備尺寸
- **動畫效果**: 平滑的過渡和交互

### 功能特性
- **聯絡方式**: 一鍵撥號、郵件、網站訪問
- **社交媒體**: 品牌化的社交連結
- **技能展示**: 專業能力介紹
- **作品集**: 項目案例展示

## 🔧 配置說明

### 環境變量
```env
# Laravel後端
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=digital_business_card
DB_USERNAME=root
DB_PASSWORD=

# API配置
API_BASE_URL=http://localhost:8000/api
```

### 數據庫配置
```sql
-- 創建數據庫
CREATE DATABASE digital_business_card CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 運行遷移
php artisan migrate
```

## 🚀 部署指南

### 生產環境部署
1. **後端部署**
   - 配置Web服務器 (Nginx/Apache)
   - 設置SSL證書
   - 配置環境變量
   - 運行數據庫遷移

2. **移動應用發布**
   - 生成簽名APK/IPA
   - 上傳到應用商店
   - 配置生產環境API

3. **Web客戶端部署**
   - 靜態文件託管
   - CDN配置
   - 域名設置

## 🤝 貢獻指南

### 開發流程
1. Fork項目
2. 創建功能分支
3. 提交更改
4. 發起Pull Request

### 代碼規範
- 遵循各語言的標準規範
- 添加適當的註釋
- 編寫測試用例
- 更新文檔

## 📄 授權協議

本項目採用 MIT 授權協議 - 詳見 [LICENSE](LICENSE) 文件

## 📞 聯絡方式

- **項目維護者**: 開發團隊
- **郵箱**: support@example.com
- **GitHub**: [項目地址](https://github.com/your-username/digital-business-card)

## 🙏 致謝

感謝所有為此項目做出貢獻的開發者和設計師！

---

**⭐ 如果這個項目對您有幫助，請給我們一個星標！**
