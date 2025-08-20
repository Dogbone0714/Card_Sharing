<?php
// 數位名片系統診斷腳本
echo "<h1>🔍 數位名片系統診斷報告</h1>";
echo "<hr>";

// 基本 PHP 信息
echo "<h2>📋 PHP 基本信息</h2>";
echo "PHP 版本: " . phpversion() . "<br>";
echo "當前時間: " . date('Y-m-d H:i:s') . "<br>";
echo "當前目錄: " . __DIR__ . "<br>";
echo "可寫權限: " . (is_writable(__DIR__) ? '✅ 是' : '❌ 否') . "<br><br>";

// 檢查必要的 PHP 擴展
echo "<h2>🔧 PHP 擴展檢查</h2>";
$required_extensions = ['pdo', 'pdo_mysql', 'mbstring', 'openssl', 'tokenizer', 'xml', 'ctype', 'json'];
foreach ($required_extensions as $ext) {
    $status = extension_loaded($ext) ? '✅' : '❌';
    echo "$status $ext<br>";
}
echo "<br>";

// 檢查 Laravel 相關目錄
echo "<h2>📁 Laravel 目錄檢查</h2>";
$laravel_dirs = [
    'storage' => 'storage',
    'bootstrap/cache' => 'bootstrap/cache',
    'public' => 'public',
    'vendor' => 'vendor',
    'config' => 'config'
];

foreach ($laravel_dirs as $name => $path) {
    $full_path = __DIR__ . '/' . $path;
    $exists = is_dir($full_path) ? '✅' : '❌';
    $writable = is_dir($full_path) && is_writable($full_path) ? '✅' : '❌';
    echo "$exists $name 目錄存在<br>";
    echo "$writable $name 目錄可寫<br>";
}
echo "<br>";

// 檢查關鍵文件
echo "<h2>📄 關鍵文件檢查</h2>";
$key_files = [
    '.env' => '.env',
    'public/index.php' => 'public/index.php',
    'vendor/autoload.php' => 'vendor/autoload.php',
    'bootstrap/app.php' => 'bootstrap/app.php'
];

foreach ($key_files as $name => $path) {
    $full_path = __DIR__ . '/' . $path;
    $exists = file_exists($full_path) ? '✅' : '❌';
    $readable = file_exists($full_path) && is_readable($full_path) ? '✅' : '❌';
    echo "$exists $name 文件存在<br>";
    echo "$readable $name 文件可讀<br>";
}
echo "<br>";

// 檢查 .env 文件內容（如果存在）
echo "<h2>⚙️ 環境配置檢查</h2>";
$env_file = __DIR__ . '/.env';
if (file_exists($env_file)) {
    echo "✅ .env 文件存在<br>";
    $env_content = file_get_contents($env_file);
    
    // 檢查關鍵配置
    $key_configs = ['APP_KEY', 'APP_DEBUG', 'DB_CONNECTION', 'LOG_CHANNEL'];
    foreach ($key_configs as $config) {
        if (strpos($env_content, $config) !== false) {
            echo "✅ $config 已配置<br>";
        } else {
            echo "❌ $config 未配置<br>";
        }
    }
    
    // 檢查 APP_KEY 是否為空
    if (preg_match('/APP_KEY=/', $env_content) && !preg_match('/APP_KEY=\w+/', $env_content)) {
        echo "⚠️ APP_KEY 為空，需要生成<br>";
    }
} else {
    echo "❌ .env 文件不存在<br>";
    echo "💡 請創建 .env 文件，可以參考 env-template.txt<br>";
}
echo "<br>";

// 檢查權限問題
echo "<h2>🔐 權限檢查</h2>";
$storage_path = __DIR__ . '/storage';
$bootstrap_cache_path = __DIR__ . '/bootstrap/cache';

if (is_dir($storage_path)) {
    $storage_writable = is_writable($storage_path) ? '✅' : '❌';
    echo "$storage_writable storage 目錄可寫<br>";
    
    // 檢查子目錄
    $storage_subdirs = ['logs', 'framework', 'app'];
    foreach ($storage_subdirs as $subdir) {
        $subdir_path = $storage_path . '/' . $subdir;
        if (is_dir($subdir_path)) {
            $writable = is_writable($subdir_path) ? '✅' : '❌';
            echo "$writable storage/$subdir 可寫<br>";
        }
    }
}

if (is_dir($bootstrap_cache_path)) {
    $cache_writable = is_writable($bootstrap_cache_path) ? '✅' : '❌';
    echo "$cache_writable bootstrap/cache 可寫<br>";
}
echo "<br>";

// 建議和解決方案
echo "<h2>💡 建議和解決方案</h2>";
if (!file_exists($env_file)) {
    echo "1. 🚨 立即創建 .env 文件<br>";
    echo "   - 複製 env-template.txt 為 .env<br>";
    echo "   - 運行: php artisan key:generate<br>";
}

echo "2. 🔧 清除緩存<br>";
echo "   - php artisan config:clear<br>";
echo "   - php artisan cache:clear<br>";
echo "   - php artisan view:clear<br>";

echo "3. 📁 設置正確權限<br>";
echo "   - chmod -R 755 storage/<br>";
echo "   - chmod -R 755 bootstrap/cache/<br>";

echo "4. 🌐 測試訪問<br>";
echo "   - 根目錄: https://card-sharing.opennuu.com/<br>";
echo "   - public: https://card-sharing.opennuu.com/public/<br>";

echo "<hr>";
echo "<p><strong>診斷完成時間:</strong> " . date('Y-m-d H:i:s') . "</p>";
?>
