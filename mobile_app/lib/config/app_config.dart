class AppConfig {
  // API 配置
  static const String apiBaseUrl = 'http://card-sharing.opennuu.com:8000/api';
  static const String apiVersion = 'v1';
  
  // 應用程式配置
  static const String appName = '數位名片';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // 功能開關
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePushNotifications = false;
  
  // 超時配置
  static const int connectionTimeout = 30000; // 30秒
  static const int receiveTimeout = 30000; // 30秒
  
  // 緩存配置
  static const int maxCacheAge = 86400000; // 24小時
  static const int maxCacheSize = 50 * 1024 * 1024; // 50MB
  
  // 圖片配置
  static const int maxImageSize = 1024; // 1024x1024
  static const double imageQuality = 0.8;
  
  // 本地化配置
  static const String defaultLocale = 'zh_TW';
  static const List<String> supportedLocales = ['zh_TW', 'en_US'];
  
  // 主題配置
  static const String defaultTheme = 'light';
  static const List<String> availableThemes = ['light', 'dark', 'auto'];
  
  // 開發模式配置
  static const bool isDevelopment = true;
  static const bool enableDebugMode = true;
  static const bool enableHotReload = true;
  
  // 測試配置
  static const bool enableTestMode = false;
  static const String testApiUrl = 'http://card-sharing.opennuu.com:8001/api';
  
  // 生產環境配置
  static const String productionApiUrl = 'https://api.card-sharing.opennuu.com.com';
  static const String productionWebUrl = 'https://card-sharing.opennuu.com.com';
  
  // 第三方服務配置
  static const String googleMapsApiKey = '';
  static const String firebaseConfig = '';
  
  // 功能限制
  static const int maxBusinessCards = 100;
  static const int maxSocialLinks = 10;
  static const int maxCustomFields = 20;
  
  // 安全配置
  static const bool enableBiometricAuth = false;
  static const bool enableEncryption = true;
  static const int sessionTimeout = 3600000; // 1小時
  
  // 日誌配置
  static const String logLevel = 'info';
  static const bool enableFileLogging = false;
  static const String logFilePath = '/logs/app.log';
  
  // 更新配置
  static const bool enableAutoUpdate = false;
  static const String updateCheckUrl = '';
  static const int updateCheckInterval = 86400000; // 24小時
  
  // 備份配置
  static const bool enableAutoBackup = false;
  static const String backupPath = '/backup';
  static const int backupInterval = 604800000; // 7天
  
  // 同步配置
  static const bool enableCloudSync = false;
  static const String syncServerUrl = '';
  static const int syncInterval = 300000; // 5分鐘
  
  // 通知配置
  static const bool enableEmailNotifications = false;
  static const bool enableSmsNotifications = false;
  
  // 分享配置
  static const List<String> supportedShareTypes = ['text', 'image', 'file', 'contact'];
  static const int maxShareFileSize = 10 * 1024 * 1024; // 10MB
  
  // QR Code 配置
  static const int qrCodeSize = 300;
  static const String qrCodeFormat = 'png';
  static const bool enableQrCodeCustomization = true;
  
  // 聯絡人配置
  static const bool enableContactSync = true;
  static const bool enableContactBackup = false;
  static const int maxContacts = 1000;
  
  // 導出配置
  static const List<String> supportedExportFormats = ['vcf', 'csv', 'json', 'pdf'];
  static const String exportPath = '/exports';
  
  // 導入配置
  static const List<String> supportedImportFormats = ['vcf', 'csv', 'json'];
  static const int maxImportFileSize = 5 * 1024 * 1024; // 5MB
  
  // 搜索配置
  static const bool enableSearchHistory = true;
  static const int maxSearchHistory = 50;
  static const bool enableSearchSuggestions = true;
  
  // 統計配置
  static const bool enableUsageStatistics = false;
  static const bool enablePerformanceMonitoring = false;
  static const String analyticsEndpoint = '';
  
  // 錯誤報告配置
  static const bool enableErrorReporting = false;
  static const String errorReportingEndpoint = '';
  static const bool enableCrashDumps = false;
  
  // 網絡配置
  static const bool enableOfflineMode = true;
  static const bool enableDataCompression = true;
  static const int maxRetryAttempts = 3;
  
  // 存儲配置
  static const String documentsPath = '/documents';
  static const String imagesPath = '/images';
  static const String cachePath = '/cache';
  static const String tempPath = '/temp';
  
  // 權限配置
  static const List<String> requiredPermissions = [
    'camera',
    'storage',
    'contacts',
    'location',
    'microphone',
  ];
  
  // 版本兼容性
  static const int minimumAndroidVersion = 21; // Android 5.0
  static const int minimumIOSVersion = 12; // iOS 12.0
  static const int minimumFlutterVersion = 3; // Flutter 3.0
  
  // 性能配置
  static const bool enablePerformanceOptimization = true;
  static const bool enableMemoryOptimization = true;
  static const bool enableBatteryOptimization = true;
  
  // 可訪問性配置
  static const bool enableAccessibility = true;
  static const bool enableScreenReader = true;
  static const bool enableHighContrast = true;
  
  // 國際化配置
  static const bool enableRTLSupport = false;
  static const bool enableLocalization = true;
  static const String fallbackLocale = 'en_US';
  
  // 測試配置
  static const bool enableUnitTests = true;
  static const bool enableIntegrationTests = true;
  static const bool enableWidgetTests = true;
  
  // 開發工具配置
  static const bool enableDevTools = true;
  static const bool enablePerformanceOverlay = false;
  static const bool enableDebugBanner = false;
  
  // 模擬器配置
  static const bool enableEmulatorMode = false;
  static const String emulatorApiUrl = 'http://10.0.2.2:8000/api';
  
  // 生產環境檢查
  static bool get isProduction => !isDevelopment;
  static bool get isDebugMode => enableDebugMode && isDevelopment;
  static bool get isTestMode => enableTestMode;
  
  // API URL 獲取
  static String get apiUrl {
    if (isTestMode) return testApiUrl;
    if (isProduction) return productionApiUrl;
    return apiBaseUrl;
  }
  
  // Web URL 獲取
  static String get webUrl {
    if (isProduction) return productionWebUrl;
    return 'http://card-sharing.opennuu.com:3000';
  }
  
  // 完整 API URL
  static String get fullApiUrl => '$apiUrl/$apiVersion';
  
  // 功能檢查
  static bool get canUseCamera => true;
  static bool get canUseContacts => true;
  static bool get canUseLocation => false;
  static bool get canUseMicrophone => false;
  
  // 環境信息
  static String get environmentInfo {
    return '''
    應用程式: $appName
    版本: $appVersion
    構建號: $appBuildNumber
    環境: ${isProduction ? '生產' : '開發'}
    模式: ${isDebugMode ? '調試' : '發布'}
    API URL: $fullApiUrl
    Web URL: $webUrl
    ''';
  }
}
